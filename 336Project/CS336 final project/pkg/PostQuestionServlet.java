package com.cs336.pkg;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class PostQuestionServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    // Ensure user is logged in
    HttpSession session = req.getSession(false);
    if (session == null || session.getAttribute("userID") == null) {
      resp.sendRedirect("login.jsp");
      return;
    }
    int userID = (Integer) session.getAttribute("userID");

    // Grab form params
    String title = req.getParameter("title");
    String body  = req.getParameter("body");
    if (title == null || title.isEmpty() || body == null || body.isEmpty()) {
      req.setAttribute("error", "Both title and message are required.");
      req.getRequestDispatcher("questionForm.jsp").forward(req, resp);
      return;
    }

    // Insert into DB
    String sql = "INSERT INTO questions(userID,title,body) VALUES (?,?,?)";
    try (Connection conn = ApplicationDB.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, userID);
      ps.setString(2, title);
      ps.setString(3, body);
      ps.executeUpdate();
    } catch (SQLException e) {
      throw new ServletException(e);
    }

    // Redirect back to list
    resp.sendRedirect("BrowseQAServlet");
  }
}

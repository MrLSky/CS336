package com.cs336.pkg;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class LoginServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    String user = req.getParameter("username");
    String pass = req.getParameter("password");

    try (Connection conn = ApplicationDB.getConnection();
         PreparedStatement ps = conn.prepareStatement(
           "SELECT userID FROM user_login WHERE username=? AND password=?")) {

      ps.setString(1, user);
      ps.setString(2, pass);

      try (ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
          // 1) Grab userID
          int userID = rs.getInt("userID");

          // 2) Put basics in session
          HttpSession session = req.getSession();
          session.setAttribute("userID",   userID);
          session.setAttribute("username", user);

          // 3) Now load permissions into session
          try (PreparedStatement ps2 = conn.prepareStatement(
                 "SELECT permissions FROM user_login WHERE userID=?")) {
            ps2.setInt(1, userID);
            try (ResultSet rs2 = ps2.executeQuery()) {
              if (rs2.next()) {
                session.setAttribute("permissions", rs2.getInt("permissions"));
              }
            }
          }

          // 4) Redirect to home
          resp.sendRedirect("home.jsp");
          return;
        }
      }

    } catch (SQLException e) {
      throw new ServletException(e);
    }

    // bad login → back to login.jsp with error flag
    resp.sendRedirect("login.jsp?error=1");
  }
}

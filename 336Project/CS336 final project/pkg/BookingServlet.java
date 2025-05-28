package com.cs336.pkg;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class BookingServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    // 1) Get current user
    HttpSession session = req.getSession(false);
    if (session == null || session.getAttribute("userID") == null) {
      resp.sendRedirect("login.jsp");
      return;
    }
    int userId = (Integer) session.getAttribute("userID");

    // 2) Get flight & class from form
    String flightNum = req.getParameter("flight_num");
    String seatClass = req.getParameter("seat_class");

    String message;

    try (Connection conn = ApplicationDB.getConnection()) {
      // 3) Try to insert a booking (NULL seat_num lets DB auto‐assign or leave blank)
      try (PreparedStatement ps = conn.prepareStatement(
          "INSERT INTO userflightbookings "
        +    "(userID, flight_num, seat_num, seat_class, purchase_date, paid_cost) "
        + "SELECT ?, flight_num, NULL, ?, NOW(), trip_cost "
        + "FROM flights "
        + "WHERE flight_num = ?")) {

        ps.setInt(1, userId);
        ps.setString(2, seatClass);
        ps.setString(3, flightNum);

        int rows = ps.executeUpdate();
        if (rows > 0) {
          message = "✅ Your ticket has been booked!";
        } else {
          // 4) Flight is full (or doesn't exist) → add to waiting_list
          try (PreparedStatement pw = conn.prepareStatement(
              "INSERT INTO waiting_list (userID, flight_num) VALUES (?, ?)")) {
            pw.setInt(1, userId);
            pw.setString(2, flightNum);
            pw.executeUpdate();
          }
          message = "⚠️ Flight is full. You've been added to the waiting list.";
        }
      }
    } catch (SQLException e) {
      throw new ServletException(e);
    }

    // 5) Forward to confirmation JSP
    req.setAttribute("bookingMsg", message);
    req.getRequestDispatcher("bookingConfirmation.jsp")
       .forward(req, resp);
  }
}

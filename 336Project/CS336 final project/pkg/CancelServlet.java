package com.cs336.pkg;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class CancelServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  // 1) Handle GETs by bouncing back to the bookings view
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    resp.sendRedirect("MyBookingsServlet");
  }

  // 2) Process the cancellation POST
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    int bookingId = Integer.parseInt(req.getParameter("bookID"));
    String flightNum = null;
    String seatClass = null;

    try (Connection conn = ApplicationDB.getConnection()) {

      // 1) Fetch flight_num & seat_class for this booking
      try (PreparedStatement ps0 = conn.prepareStatement(
              "SELECT flight_num, seat_class FROM userflightbookings WHERE unique_bookID=?")) {
        ps0.setInt(1, bookingId);
        try (ResultSet rs0 = ps0.executeQuery()) {
          if (rs0.next()) {
            flightNum = rs0.getString("flight_num");
            seatClass = rs0.getString("seat_class");
          }
        }
      }

      // 2) Delete the existing booking
      try (PreparedStatement ps = conn.prepareStatement(
              "DELETE FROM userflightbookings WHERE unique_bookID=?")) {
        ps.setInt(1, bookingId);
        ps.executeUpdate();
      }

      // 3) Pull the next waiting‐list entry, if any
      Integer nextWaitID = null, nextUserID = null;
      try (PreparedStatement ps1 = conn.prepareStatement(
              "SELECT waitID, userID FROM waiting_list WHERE flight_num=? ORDER BY request_time LIMIT 1")) {
        ps1.setString(1, flightNum);
        try (ResultSet rs1 = ps1.executeQuery()) {
          if (rs1.next()) {
            nextWaitID = rs1.getInt("waitID");
            nextUserID = rs1.getInt("userID");
          }
        }
      }

      if (nextWaitID != null) {
        // 4) Book that waiting‐list user
        try (PreparedStatement ps2 = conn.prepareStatement(
                "INSERT INTO userflightbookings "
              + "(userID, flight_num, seat_num, seat_class, purchase_date, paid_cost) "
              + "SELECT ?, flight_num, NULL, ?, NOW(), trip_cost "
              + "FROM flights WHERE flight_num=?")) {
          ps2.setInt(1, nextUserID);
          ps2.setString(2, seatClass);
          ps2.setString(3, flightNum);
          ps2.executeUpdate();
        }
        // 5) Remove them from the waiting list
        try (PreparedStatement ps3 = conn.prepareStatement(
                "DELETE FROM waiting_list WHERE waitID=?")) {
          ps3.setInt(1, nextWaitID);
          ps3.executeUpdate();
        }
        // 6) Notify via request attribute
        req.setAttribute("notifyMsg",
            "An empty seat opened up and user #" + nextUserID +
            " has been automatically moved from the waiting list into a booking.");
      }

    } catch (SQLException e) {
      throw new ServletException(e);
    }

    // 7) Forward to confirmation JSP
    req.getRequestDispatcher("cancelConfirmation.jsp").forward(req, resp);
  }
}


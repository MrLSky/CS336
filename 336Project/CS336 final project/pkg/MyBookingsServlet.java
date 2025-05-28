package com.cs336.pkg;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MyBookingsServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /** JavaBean to hold one booking’s details */
  public static class Booking {
    private int bookId;
    private String flightNum, airlineName, fromCode, toCode, seatClass;
    private Timestamp departDate, arriveDate;
    private float paidCost;

    public Booking(int bookId,
                   String flightNum,
                   String airlineName,
                   String fromCode,
                   String toCode,
                   Timestamp departDate,
                   Timestamp arriveDate,
                   String seatClass,
                   float paidCost) {
      this.bookId      = bookId;
      this.flightNum   = flightNum;
      this.airlineName = airlineName;
      this.fromCode    = fromCode;
      this.toCode      = toCode;
      this.departDate  = departDate;
      this.arriveDate  = arriveDate;
      this.seatClass   = seatClass;
      this.paidCost    = paidCost;
    }

    // JavaBean getters (EL will look for these)
    public int getBookId()          { return bookId; }
    public String getFlightNum()    { return flightNum; }
    public String getAirlineName()  { return airlineName; }
    public String getFromCode()     { return fromCode; }
    public String getToCode()       { return toCode; }
    public Timestamp getDepartDate(){ return departDate; }
    public Timestamp getArriveDate(){ return arriveDate; }
    public String getSeatClass()    { return seatClass; }
    public float getPaidCost()      { return paidCost; }
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    // 1) Authentication‐check
    HttpSession session = req.getSession(false);
    if (session == null || session.getAttribute("userID") == null) {
      resp.sendRedirect("login.jsp");
      return;
    }
    int userId = (Integer) session.getAttribute("userID");

    // 2) Prepare two lists
    List<Booking> upcoming = new ArrayList<>();
    List<Booking> past     = new ArrayList<>();

    // 3) Common SQL for both upcoming & past
    String baseSql =
      "SELECT ub.unique_bookID, f.flight_num, a.Airline_name, " +
      "       f.departs_from, f.arrives_at, f.depart_date, f.arrives_date, " +
      "       ub.seat_class, ub.paid_cost " +
      "FROM userflightbookings ub " +
      "  JOIN flights f    ON ub.flight_num = f.flight_num " +
      "  JOIN airlines a   ON f.AirlineID    = a.AirlineID " +
      "WHERE ub.userID = ? AND f.depart_date ";

    try (Connection conn = ApplicationDB.getConnection()) {
      // 3a) Upcoming: depart_date >= NOW()
      try (PreparedStatement ps = conn.prepareStatement(baseSql + ">= NOW()")) {
        ps.setInt(1, userId);
        try (ResultSet rs = ps.executeQuery()) {
          while (rs.next()) {
            upcoming.add(new Booking(
              rs.getInt(1),
              rs.getString(2),
              rs.getString(3),
              rs.getString(4),
              rs.getString(5),
              rs.getTimestamp(6),
              rs.getTimestamp(7),
              rs.getString(8),
              rs.getFloat(9)
            ));
          }
        }
      }

      // 3b) Past: depart_date < NOW()
      try (PreparedStatement ps = conn.prepareStatement(baseSql + "< NOW()")) {
        ps.setInt(1, userId);
        try (ResultSet rs = ps.executeQuery()) {
          while (rs.next()) {
            past.add(new Booking(
              rs.getInt(1),
              rs.getString(2),
              rs.getString(3),
              rs.getString(4),
              rs.getString(5),
              rs.getTimestamp(6),
              rs.getTimestamp(7),
              rs.getString(8),
              rs.getFloat(9)
            ));
          }
        }
      }
    } catch (SQLException e) {
      throw new ServletException(e);
    }

    // 4) Expose to JSP and forward
    req.setAttribute("upcomingBookings", upcoming);
    req.setAttribute("pastBookings", past);
    req.getRequestDispatcher("myBookings.jsp")
       .forward(req, resp);
  }
}


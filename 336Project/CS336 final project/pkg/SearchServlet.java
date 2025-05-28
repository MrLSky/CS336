package com.cs336.pkg;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SearchServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public static class Flight {
    public String flightNum, airline, ori, dest;
    public Timestamp depart, arrive;
    public int stops;
    public float cost;
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    // 1) pull all inputs
    String ori      = req.getParameter("ori");
    String dest     = req.getParameter("dest");
    String date1    = req.getParameter("date1");
    String type     = req.getParameter("type");
    String date2    = req.getParameter("date2");

    // 2) ensure sortBy is never null
    String sortBy   = req.getParameter("sortBy");
    if (sortBy == null || sortBy.isEmpty()) {
      sortBy = "price";
    }

    // 3) optional filters
    String maxPrice = req.getParameter("maxPrice");
    String airlineF = req.getParameter("airline");
    String maxStops = req.getParameter("maxStops");
    String depStart = req.getParameter("depStart");
    String depEnd   = req.getParameter("depEnd");
    String arrStart = req.getParameter("arrStart");
    String arrEnd   = req.getParameter("arrEnd");

    // 4) build dynamic WHERE
    StringBuilder where = new StringBuilder(
      "WHERE f.departs_from=? AND f.arrives_at=? ");
    if ("oneway".equals(type)) {
      where.append("AND DATE(f.depart_date)=? ");
    } else if ("roundtrip".equals(type)) {
      where.append("AND DATE(f.depart_date)=? AND DATE(f.arrives_date)=? ");
    } else {
      where.append("AND DATE(f.depart_date) BETWEEN DATE_SUB(?,INTERVAL 3 DAY) AND DATE_ADD(?,INTERVAL 3 DAY) ");
    }
    if (maxPrice!=null && !maxPrice.isEmpty()) {
      where.append("AND f.trip_cost<=? ");
    }
    if (airlineF!=null && !airlineF.isEmpty()) {
      where.append("AND a.Airline_name LIKE ? ");
    }
    if (maxStops!=null && !maxStops.isEmpty()) {
      where.append("AND f.stopOver_num<=? ");
    }
    if (depStart!=null && !depStart.isEmpty()) {
      where.append("AND TIME(f.depart_date)>=? ");
    }
    if (depEnd!=null && !depEnd.isEmpty()) {
      where.append("AND TIME(f.depart_date)<=? ");
    }
    if (arrStart!=null && !arrStart.isEmpty()) {
      where.append("AND TIME(f.arrives_date)>=? ");
    }
    if (arrEnd!=null && !arrEnd.isEmpty()) {
      where.append("AND TIME(f.arrives_date)<=? ");
    }

    // 5) build ORDER BY
    String orderBy;
    switch (sortBy) {
      case "depart":   orderBy="ORDER BY f.depart_date"; break;
      case "arrive":   orderBy="ORDER BY f.arrives_date"; break;
      case "duration": orderBy="ORDER BY TIMESTAMPDIFF(MINUTE,f.depart_date,f.arrives_date)"; break;
      default:         orderBy="ORDER BY f.trip_cost";
    }

    String sql =
      "SELECT f.flight_num, a.Airline_name, f.departs_from, f.arrives_at, " +
      "       f.depart_date, f.arrives_date, f.stopOver_num, f.trip_cost " +
      "FROM flights f JOIN airlines a ON f.AirlineID=a.AirlineID " +
      where + orderBy;

    // 6) execute
    List<Flight> results = new ArrayList<>();
    try (Connection conn = ApplicationDB.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

      int idx=1;
      ps.setString(idx++, ori);
      ps.setString(idx++, dest);

      // date params
      if ("oneway".equals(type)) {
        ps.setDate(idx++, Date.valueOf(date1));
      } else if ("roundtrip".equals(type)) {
        ps.setDate(idx++, Date.valueOf(date1));
        ps.setDate(idx++, Date.valueOf(date2));
      } else {
        ps.setDate(idx++, Date.valueOf(date1));
        ps.setDate(idx++, Date.valueOf(date1));
      }

      // optional binds
      if (maxPrice!=null && !maxPrice.isEmpty()) {
        ps.setFloat(idx++, Float.parseFloat(maxPrice));
      }
      if (airlineF!=null && !airlineF.isEmpty()) {
        ps.setString(idx++, "%" + airlineF + "%");
      }
      if (maxStops!=null && !maxStops.isEmpty()) {
        ps.setInt(idx++, Integer.parseInt(maxStops));
      }
      if (depStart!=null && !depStart.isEmpty()) {
        ps.setTime(idx++, Time.valueOf(depStart + ":00"));
      }
      if (depEnd!=null && !depEnd.isEmpty()) {
        ps.setTime(idx++, Time.valueOf(depEnd   + ":00"));
      }
      if (arrStart!=null && !arrStart.isEmpty()) {
        ps.setTime(idx++, Time.valueOf(arrStart + ":00"));
      }
      if (arrEnd!=null && !arrEnd.isEmpty()) {
        ps.setTime(idx++, Time.valueOf(arrEnd   + ":00"));
      }

      try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
          Flight f = new Flight();
          f.flightNum = rs.getString("flight_num");
          f.airline   = rs.getString("Airline_name");
          f.ori       = rs.getString("departs_from");
          f.dest      = rs.getString("arrives_at");
          f.depart    = rs.getTimestamp("depart_date");
          f.arrive    = rs.getTimestamp("arrives_date");
          f.stops     = rs.getInt("stopOver_num");
          f.cost      = rs.getFloat("trip_cost");
          results.add(f);
        }
      }
    } catch (SQLException e) {
      throw new ServletException(e);
    }

    // 7) dispatch to JSP
    req.setAttribute("flights", results);
    req.getRequestDispatcher("searchResults.jsp")
       .forward(req, resp);
  }
}

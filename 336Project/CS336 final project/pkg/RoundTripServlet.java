package com.cs336.pkg;

import javax.servlet.ServletException;
import java.sql.Date;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class RoundTripServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  // show the form
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.getRequestDispatcher("roundTripForm.jsp").forward(req, resp);
  }

  // handle form submission
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    String ori    = req.getParameter("ori").toUpperCase();
    String dest   = req.getParameter("dest").toUpperCase();
    Date   d1     = Date.valueOf(req.getParameter("d1"));
    Date   d2     = Date.valueOf(req.getParameter("d2"));
    String sortBy = req.getParameter("sortBy");

    List<Map<String,Object>> outbound = new ArrayList<>();
    List<Map<String,Object>> inbound  = new ArrayList<>();

    try (Connection conn = ApplicationDB.getConnection();
         CallableStatement cs = conn.prepareCall("{CALL search_roundtrip(?,?,?,?,?)}")) {
      cs.setString(1, ori);
      cs.setString(2, dest);
      cs.setDate(3, d1);
      cs.setDate(4, d2);
      cs.setString(5, sortBy);

      // outbound result set
      try (ResultSet rs = cs.executeQuery()) {
        while (rs.next()) {
          Map<String,Object> row = new HashMap<>();
          row.put("flight_num",   rs.getString("flight_num"));
          row.put("airline_name", rs.getString("Airline_name"));
          row.put("depart_date",  rs.getTimestamp("depart_date"));
          row.put("arrives_date", rs.getTimestamp("arrives_date"));
          row.put("trip_cost",    rs.getDouble("trip_cost"));
          outbound.add(row);
        }
      }
      // move to second resultset for return
      if (cs.getMoreResults()) {
        try (ResultSet rs2 = cs.getResultSet()) {
          while (rs2.next()) {
            Map<String,Object> row = new HashMap<>();
            row.put("flight_num",   rs2.getString("flight_num"));
            row.put("airline_name", rs2.getString("Airline_name"));
            row.put("depart_date",  rs2.getTimestamp("depart_date"));
            row.put("arrives_date", rs2.getTimestamp("arrives_date"));
            row.put("trip_cost",    rs2.getDouble("trip_cost"));
            inbound.add(row);
          }
        }
      }
    } catch (SQLException e) {
      throw new ServletException(e);
    }

    req.setAttribute("outbound", outbound);
    req.setAttribute("inbound", inbound);
    req.getRequestDispatcher("roundTripResults.jsp").forward(req, resp);
  }
}

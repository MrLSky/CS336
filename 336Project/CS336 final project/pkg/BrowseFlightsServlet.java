package com.cs336.pkg;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BrowseFlightsServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public static class Flight {
    // raw fields
    private String flightNum, airline, ori, dest;
    private Timestamp depart, arrive;
    private int stops;
    private float cost;

    // constructor for convenience
    public Flight(String flightNum, String airline,
                  String ori, String dest,
                  Timestamp depart, Timestamp arrive,
                  int stops, float cost)
    {
      this.flightNum = flightNum;
      this.airline   = airline;
      this.ori       = ori;
      this.dest      = dest;
      this.depart    = depart;
      this.arrive    = arrive;
      this.stops     = stops;
      this.cost      = cost;
    }

    // JavaBean getters
    public String getFlightNum() { return flightNum; }
    public String getAirline()   { return airline;   }
    public String getOri()       { return ori;       }
    public String getDest()      { return dest;      }
    public Timestamp getDepart() { return depart;    }
    public Timestamp getArrive() { return arrive;    }
    public int getStops()        { return stops;     }
    public float getCost()       { return cost;      }
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    List<Flight> flights = new ArrayList<>();
    String sql =
      "SELECT f.flight_num, a.Airline_name, f.departs_from, f.arrives_at, " +
      "       f.depart_date, f.arrives_date, f.stopOver_num, f.trip_cost " +
      "FROM flights f " +
      " JOIN airlines a ON f.AirlineID=a.AirlineID " +
      " ORDER BY f.depart_date";

    try (Connection conn = ApplicationDB.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

      while (rs.next()) {
        flights.add(new Flight(
          rs.getString("flight_num"),
          rs.getString("Airline_name"),
          rs.getString("departs_from"),
          rs.getString("arrives_at"),
          rs.getTimestamp("depart_date"),
          rs.getTimestamp("arrives_date"),
          rs.getInt("stopOver_num"),
          rs.getFloat("trip_cost")
        ));
      }

    } catch (SQLException e) {
      throw new ServletException(e);
    }

    req.setAttribute("flights", flights);
    req.getRequestDispatcher("browseFlights.jsp")
       .forward(req, resp);
  }
}

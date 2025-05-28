<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Search Results</title></head>
  <body>
    <h2>Search Results</h2>

    <c:choose>
      <c:when test="${empty flights}">
        <p>No flights found matching your criteria.</p>
      </c:when>
      <c:otherwise>
        <table border="1" cellpadding="5">
          <tr>
            <th>Flight#</th><th>Airline</th><th>From</th><th>To</th>
            <th>Depart</th><th>Arrive</th><th>Stops</th><th>Cost</th><th>Action</th>
          </tr>
          <c:forEach var="f" items="${flights}">
            <tr>
              <!-- Note: use the properties from your Flight DTO -->
              <td><c:out value="${f.flightNum}"/></td>
              <td><c:out value="${f.airline}"/></td>
              <td><c:out value="${f.ori}"/></td>
              <td><c:out value="${f.dest}"/></td>
              <td><c:out value="${f.depart}"/></td>
              <td><c:out value="${f.arrive}"/></td>
              <td><c:out value="${f.stops}"/></td>
              <td>$<c:out value="${f.cost}"/></td>
              <td>
                <form action="BookingServlet" method="post">
                  <input type="hidden" name="flight_num" value="${f.flightNum}"/>
                  <label>
                    Class:
                    <select name="seat_class">
                      <option value="Economy">Economy</option>
                      <option value="Business">Business</option>
                    </select>
                  </label>
                  <button type="submit">Book</button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </table>
      </c:otherwise>
    </c:choose>

    <p><a href="searchForm.jsp">← New Search</a></p>
  </body>
</html>

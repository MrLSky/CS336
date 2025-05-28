<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <body>
    <h2>Round-Trip Results</h2>

    <h3>Outbound</h3>
    <c:if test="${empty outbound}">
      <p>No outbound flights found.</p>
    </c:if>
    <c:if test="${not empty outbound}">
      <table border="1">
        <tr><th>Flight#</th><th>Airline</th><th>Depart</th><th>Arrive</th><th>Cost</th></tr>
        <c:forEach var="f" items="${outbound}">
          <tr>
            <td>${f.flight_num}</td>
            <td>${f.airline_name}</td>
            <td>${f.depart_date}</td>
            <td>${f.arrives_date}</td>
            <td>$${f.trip_cost}</td>
          </tr>
        </c:forEach>
      </table>
    </c:if>

    <h3>Return</h3>
    <c:if test="${empty inbound}">
      <p>No return flights found.</p>
    </c:if>
    <c:if test="${not empty inbound}">
      <table border="1">
        <tr><th>Flight#</th><th>Airline</th><th>Depart</th><th>Arrive</th><th>Cost</th></tr>
        <c:forEach var="f" items="${inbound}">
          <tr>
            <td>${f.flight_num}</td>
            <td>${f.airline_name}</td>
            <td>${f.depart_date}</td>
            <td>${f.arrives_date}</td>
            <td>$${f.trip_cost}</td>
          </tr>
        </c:forEach>
      </table>
    </c:if>

    <p><a href="roundTripForm.jsp">← New Round-Trip Search</a></p>
    <p><a href="home.jsp">← Home</a></p>
  </body>
</html>

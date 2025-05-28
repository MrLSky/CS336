<%@ page session="true" contentType="text/html;charset=UTF-8" %>
<%
  if (session.getAttribute("username")==null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<html>
  <body>
    <h2>Welcome, ${sessionScope.username}!</h2>
    <ul>
      <li><a href="logout.jsp">Log out</a></li>
      <li><a href="searchForm.jsp?type=oneway">One‐Way Search</a></li>
      <li><a href="searchForm.jsp?type=roundtrip">Round‐Trip Search</a></li>
      <li><a href="searchForm.jsp?type=flexible">Flexible Dates Search</a></li>
      <li><a href="BrowseFlightsServlet">Browse All Flights</a></li>
      <li><a href="MyBookingsServlet">My Bookings</a></li>
  
      <li><a href="MyBookingsServlet">Cancel Reservation</a></li>

      <li><a href="BrowseQAServlet">Browse Questions and Answers</a></li>
      <li><a href="questionForm.jsp">Ask a Question</a></li>
    </ul>
  </body>
</html>


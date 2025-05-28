<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <body>
    <h2>Round-Trip Flight Search</h2>
    <form action="RoundTripServlet" method="post">
      Origin:      <input name="ori" maxlength="3" required/><br/>
      Destination: <input name="dest" maxlength="3" required/><br/>
      Depart Date: <input name="d1" type="date" required/><br/>
      Return Date: <input name="d2" type="date" required/><br/>
      Sort by:
      <select name="sortBy">
        <option value="price">Price</option>
        <option value="depart">Departure</option>
        <option value="arrive">Arrival</option>
        <option value="duration">Duration</option>
      </select><br/><br/>
      <button type="submit">Search Round-Trip</button>
    </form>
    <p><a href="home.jsp">← Back to Home</a></p>
  </body>
</html>

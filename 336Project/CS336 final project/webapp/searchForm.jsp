<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // figure out which trip type to pre-select
  String initialType = request.getParameter("type");
  if (initialType == null) initialType = "oneway";
%>
<html>
<head>
  <title>Search Flights</title>
</head>
<body>
  <h2>Search for Flights</h2>
  <form action="SearchServlet" method="get">
    <label>Origin:</label>
    <input name="ori" required placeholder="e.g. JFK"
           value="${param.ori}" /><br/>

    <label>Destination:</label>
    <input name="dest" required placeholder="e.g. LAX"
           value="${param.dest}" /><br/>

    <label>Depart Date:</label>
    <input type="date" name="date1" required
           value="${param.date1}" /><br/>

    <label>Trip Type:</label>
    <select name="type" id="tripType">
      <option value="oneway"    
        <%= initialType.equals("oneway")    ? "selected" : "" %>>
        One‐way
      </option>
      <option value="roundtrip" 
        <%= initialType.equals("roundtrip") ? "selected" : "" %>>
        Round‐trip
      </option>
      <option value="flexible"  
        <%= initialType.equals("flexible")  ? "selected" : "" %>>
        Flexible ±3 days
      </option>
    </select><br/>

    <div id="returnDate" style="display:none;">
      <label>Return Date:</label>
      <input type="date" name="date2"
             value="${param.date2}" /><br/>
    </div>

    <hr/>
    <h3>Sort &amp; Filter</h3>

    <label>Sort by:</label>
    <select name="sortBy">
      <option value="price"    ${param.sortBy=='price'    ? 'selected':''}>Price</option>
      <option value="depart"   ${param.sortBy=='depart'   ? 'selected':''}>Take‐off Time</option>
      <option value="arrive"   ${param.sortBy=='arrive'   ? 'selected':''}>Landing Time</option>
      <option value="duration" ${param.sortBy=='duration' ? 'selected':''}>Duration</option>
    </select><br/>

    <label>Max Price:</label>
    <input name="maxPrice" type="number" step="0.01" placeholder="e.g. 300"
           value="${param.maxPrice}" /><br/>

    <label>Airline contains:</label>
    <input name="airline" placeholder="e.g. American"
           value="${param.airline}" /><br/>

    <label>Max Stops:</label>
    <select name="maxStops">
      <option value=""  ${param.maxStops=='' ? 'selected':''}>Any</option>
      <option value="0" ${param.maxStops=='0'? 'selected':''}>Non‐stop</option>
      <option value="1" ${param.maxStops=='1'? 'selected':''}>≤ 1 stop</option>
      <option value="2" ${param.maxStops=='2'? 'selected':''}>≤ 2 stops</option>
    </select><br/>

    <label>Departs between:</label>
    <input name="depStart" type="time" value="${param.depStart}" />
    and
    <input name="depEnd"   type="time" value="${param.depEnd}" /><br/>

    <label>Arrives between:</label>
    <input name="arrStart" type="time" value="${param.arrStart}" />
    and
    <input name="arrEnd"   type="time" value="${param.arrEnd}" /><br/>

    <button type="submit">Search</button>
  </form>

  <script>
    const tripType = document.getElementById('tripType');
    const retDiv   = document.getElementById('returnDate');
    function toggleReturn() {
      retDiv.style.display = tripType.value==='roundtrip' ? 'block' : 'none';
    }
    // re‐compute on change
    tripType.addEventListener('change', toggleReturn);
    // and once on page load
    toggleReturn();
  </script>
</body>
</html>


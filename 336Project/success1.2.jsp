<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch last 5 login attempts
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/cs336project", "webuser", "webpass");

    String histSql = 
      "SELECT attempt_time, success, ip_address " +
      "FROM login_history WHERE username = ? " +
      "ORDER BY attempt_time DESC LIMIT 5";
    PreparedStatement histStmt = con.prepareStatement(histSql);
    histStmt.setString(1, user);
    ResultSet rs = histStmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Welcome, <%= user %></title>
</head>
<body>
  <h1>Welcome, <%= user %>!</h1>

  <h3>Your last 5 login attempts</h3>
  <table border="1" cellpadding="5">
    <tr>
      <th>Time</th>
      <th>Result</th>
      <th>IP Address</th>
    </tr>
    <% while (rs.next()) { %>
      <tr>
        <td><%= rs.getTimestamp("attempt_time") %></td>
        <td><%= rs.getBoolean("success") ? "✅ Success" : "❌ Failure" %></td>
        <td><%= rs.getString("ip_address") %></td>
      </tr>
    <% } %>
  </table>

  <p><a href="logout.jsp">Log out</a></p>
</body>
</html>
<%
    rs.close();
    histStmt.close();
    con.close();
%>

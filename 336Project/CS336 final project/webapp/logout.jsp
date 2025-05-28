<%@ page session="true" %>
<%
  // Invalidate session and return to login
  session.invalidate();
  response.sendRedirect("login.jsp");
%>

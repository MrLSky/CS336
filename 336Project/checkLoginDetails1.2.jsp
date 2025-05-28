<%@ page import="java.sql.*" %>
<%
    String userid = request.getParameter("username");
    String pwd    = request.getParameter("password");
    boolean valid = false;

    Connection con = null;
    PreparedStatement ps = null;
    PreparedStatement logStmt = null;
    ResultSet rs = null;

    try {
        // 1) Load driver & connect
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/cs336project?useSSL=false&serverTimezone=UTC",
            "webuser", "webpass");

        // 2) Check credentials
        String checkSql = 
            "SELECT 1 FROM user_login WHERE username = ? AND password = ?";
        ps = con.prepareStatement(checkSql);
        ps.setString(1, userid);
        ps.setString(2, pwd);
        rs = ps.executeQuery();
        valid = rs.next();
        rs.close();
        ps.close();

        // 3) Log the attempt (always runs)
        String logSql = 
            "INSERT INTO login_history(username, success, ip_address) VALUES (?,?,?)";
        logStmt = con.prepareStatement(logSql);
        logStmt.setString(1, userid);
        logStmt.setBoolean(2, valid);
        logStmt.setString(3, request.getRemoteAddr());
        logStmt.executeUpdate();
        logStmt.close();

        // 4) Redirect based on result
        if (valid) {
            session.setAttribute("user", userid);
            response.sendRedirect("success.jsp");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }

    } catch (Exception e) {
        out.println("Database error: " + e.getMessage());
    } finally {
        // 5) Clean‑up
        if (rs       != null) try { rs.close();      } catch (SQLException ignored) {}
        if (ps       != null) try { ps.close();      } catch (SQLException ignored) {}
        if (logStmt  != null) try { logStmt.close(); } catch (SQLException ignored) {}
        if (con      != null) try { con.close();     } catch (SQLException ignored) {}
    }
%>

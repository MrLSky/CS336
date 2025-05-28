package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {

    // JDBC URL pointing at your cs336project database
    private static final String URL      = "jdbc:mysql://localhost:3306/cs336project?useSSL=false&serverTimezone=UTC";
    private static final String USER     = "root";            // your MySQL user
    private static final String PASSWORD = "Gw7#Ts4kL9";   // 

    static {
        try {
            // MySQL Connector/J 8.x driver class
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL driver not found", e);
        }
    }

    /**  
     * live connection to cs336project database.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    /**  
     * Safely close a Connection (ignore if null).
     */
    public static void close(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException ignored) {}
        }
    }

  
    public static void main(String[] args) throws SQLException {
        Connection conn = getConnection();
        System.out.println("Connected: " + conn);
        close(conn);
    }
}


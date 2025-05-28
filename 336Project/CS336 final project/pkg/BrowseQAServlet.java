package com.cs336.pkg;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BrowseQAServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    List<Question> questions = new ArrayList<>();

    String qSql =
      "SELECT q.questionID, q.title, q.body, DATE_FORMAT(q.date_posted,'%Y-%m-%d %T') AS dt, "
    + "       u.first_name, u.last_name "
    + "FROM questions q "
    + " JOIN `user` u ON q.userID=u.userID "
    + "ORDER BY q.date_posted DESC";

    try (Connection conn = ApplicationDB.getConnection();
         PreparedStatement psQ = conn.prepareStatement(qSql);
         ResultSet rsQ = psQ.executeQuery()) {

      while (rsQ.next()) {
        Question q = new Question();
        q.setQuestionID(rsQ.getInt("questionID"));
        q.setTitle(rsQ.getString("title"));
        q.setBody(rsQ.getString("body"));
        q.setDatePosted(rsQ.getString("dt"));
        String asker = rsQ.getString("first_name") + " " + rsQ.getString("last_name");
        q.setAskerName(asker);

        // load answers for this question
        String aSql = 
          "SELECT answerID, body, DATE_FORMAT(date_posted,'%Y-%m-%d %T') AS dt "
        + "FROM answers WHERE questionID=? ORDER BY date_posted ASC";
        try (PreparedStatement psA = conn.prepareStatement(aSql)) {
          psA.setInt(1, q.getQuestionID());
          try (ResultSet rsA = psA.executeQuery()) {
            while (rsA.next()) {
              Answer a = new Answer();
              a.setAnswerID(rsA.getInt("answerID"));
              a.setBody(rsA.getString("body"));
              a.setDatePosted(rsA.getString("dt"));
              q.getAnswers().add(a);
            }
          }
        }

        questions.add(q);
      }

    } catch (SQLException e) {
      throw new ServletException(e);
    }

    req.setAttribute("questions", questions);
    req.getRequestDispatcher("browseQnA.jsp").forward(req, resp);
  }
}

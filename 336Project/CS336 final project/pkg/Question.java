package com.cs336.pkg;

import java.util.ArrayList;
import java.util.List;

public class Question {
  private int    questionID;
  private String title, body, datePosted, askerName;
  private List<Answer> answers = new ArrayList<>();

  // getters & setters
  public int    getQuestionID() { return questionID; }
  public void   setQuestionID(int id) { this.questionID = id; }
  public String getTitle()      { return title;     }
  public void   setTitle(String t) { this.title = t; }
  public String getBody()       { return body;      }
  public void   setBody(String b){ this.body = b; }
  public String getDatePosted(){ return datePosted;}
  public void   setDatePosted(String d){ this.datePosted = d; }
  public String getAskerName(){ return askerName; }
  public void   setAskerName(String n){ this.askerName = n; }
  public List<Answer> getAnswers(){ return answers; }
}

package com.cs336.pkg;

public class Answer {
  private int    answerID;
  private String body, datePosted;
  // getters & setters
  public int    getAnswerID(){ return answerID; }
  public void   setAnswerID(int id){ this.answerID = id; }
  public String getBody(){ return body; }
  public void   setBody(String b){ this.body = b; }
  public String getDatePosted(){ return datePosted; }
  public void   setDatePosted(String d){ this.datePosted = d; }
}

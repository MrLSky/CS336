<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Questions and Answers</title></head>
<body>
  <h2>
    <c:choose>
      <c:when test="${not empty searchKeyword}">
        Search results for “${searchKeyword}”
      </c:when>
      <c:otherwise>
        All Questions & Answers
      </c:otherwise>
    </c:choose>
  </h2>


<p><a href="questionForm.jsp">Ask a Question</a></p>


  <form action="SearchQAServlet" method="get">
    <input name="keyword" value="${searchKeyword}" placeholder="Search Q&A…"/>
    <button>Search</button>
    <a href="BrowseQAServlet">Show All</a>
  </form>

  <c:forEach var="q" items="${questions}">
    <c:if test="${empty searchKeyword 
                  or fn:contains(q.title,searchKeyword) 
                  or fn:contains(q.body,searchKeyword)}">
      <div style="border:1px solid #ccc; padding:10px; margin:10px;">
        <h3>${q.title}</h3>
        <p><em>by ${q.askerName} on ${q.datePosted}</em></p>
        <p>${q.body}</p>
        <c:if test="${not empty q.answers}">
          <h4>Answers:</h4>
          <ul>
            <c:forEach var="a" items="${q.answers}">
              <li>
                ${a.body} <br/>
                <small>— ${a.datePosted}</small>
              </li>
            </c:forEach>
          </ul>
        </c:if>
      </div>
    </c:if>
  </c:forEach>
</body>
</html>

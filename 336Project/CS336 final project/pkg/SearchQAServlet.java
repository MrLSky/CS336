package com.cs336.pkg;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class SearchQAServlet extends BrowseQAServlet {
  private static final long serialVersionUID = 1L;

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    // grab keyword
    String kw = req.getParameter("keyword");
    req.setAttribute("searchKeyword", kw);
    // delegate to BrowseQAServlet with an override: 
    // stash it in request so JSP can adjust heading and we’ll filter in JSP
    super.doGet(req, resp);
  }
}

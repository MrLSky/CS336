package com.cs336.pkg;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class CustomerAuthFilter implements Filter {
  @Override
  public void init(FilterConfig config) throws ServletException {}

  @Override
  public void doFilter(ServletRequest request, ServletResponse response,
                       FilterChain chain)
        throws IOException, ServletException {

    HttpServletRequest  req  = (HttpServletRequest) request;
    HttpServletResponse res  = (HttpServletResponse) response;
    HttpSession session = req.getSession(false);

    // Grab the permissions from session (null if not logged in)
    Integer perms = session==null
                  ? null
                  : (Integer) session.getAttribute("permissions");

    if (perms != null && perms == 0) {
      // user is a “customer” → allow
      chain.doFilter(request, response);
    } else {
      // not a logged‐in customer → back to login
      res.sendRedirect(req.getContextPath() + "/login.jsp?error=auth");
    }
  }

  @Override
  public void destroy() {}
}


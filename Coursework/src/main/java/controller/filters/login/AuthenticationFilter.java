package controller.filters.login;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/authenticationfilter")
public class AuthenticationFilter implements Filter {
private ServletContext context;
@Override
public void init(FilterConfig filterConfig) throws ServletException {
	this.context = filterConfig.getServletContext();
	this.context.log("AuthenticationFilter initialized");
}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
	        throws IOException, ServletException {
	    HttpServletRequest req = (HttpServletRequest) request;
	    HttpServletResponse res = (HttpServletResponse) response;

	    // check if the request is the context root of the application
	    String uri = req.getRequestURI();
	    boolean isContextRoot = uri.equals(req.getContextPath() + "/");

	    HttpSession session = req.getSession(false);
	    boolean loggedIn = session != null && session.getAttribute("user") != null;

	    if (loggedIn && isContextRoot) {
	        res.sendRedirect(req.getContextPath() + "/home.jsp");
	    } else {
	        chain.doFilter(request, response);
	    }
	}


	
	
	@Override
	public void destroy() {
		
	}
}




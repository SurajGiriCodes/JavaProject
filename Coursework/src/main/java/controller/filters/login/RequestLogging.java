package controller.filters.login;


import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.Filter;
import javax.servlet.http.HttpServletRequest;

public class RequestLogging implements Filter {

public void init(FilterConfig filterconfig)throws ServletException{		}

public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
	 throws IOException, ServletException{
	HttpServletRequest req = (HttpServletRequest) request;
	Enumeration<String> params = req.getParameterNames();
	while(params.hasMoreElements()) {
		String name = params.nextElement();
		String value = request.getParameter(name);
	}
	
	  
	Cookie[] cookies = req.getCookies();
	if(cookies != null) {
		for(Cookie cookie : cookies) {
		}
	
		}
	//pass the request along the filter chain
	chain.doFilter(request, response);
	
	}


	public void destroy() {
	}
}

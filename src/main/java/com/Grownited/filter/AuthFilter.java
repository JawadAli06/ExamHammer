package com.Grownited.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.stereotype.Component;

import com.Grownited.entity.UserEntity;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class AuthFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		
		String uri = req.getRequestURI();

		ArrayList<String> publicUrl = new ArrayList<>();

		publicUrl.add("/login");
		publicUrl.add("/signup");
		publicUrl.add("/forget-password");
		publicUrl.add("/authenticate");
		publicUrl.add("/register");
		publicUrl.add("/sendOtp");
		publicUrl.add("/verifyOtpAndReset");

		boolean isPublic = publicUrl.stream().anyMatch(uri::contains);

		if (isPublic || uri.contains("assets")) {
		    chain.doFilter(request, response);
		    return;
		}

		System.out.println("AuthFilter ......" + new Date());
		System.out.println(uri);

		HttpSession session = req.getSession();
		UserEntity user = (UserEntity) session.getAttribute("user");

		if (user == null) {
		    res.sendRedirect("/login");
		} else {
		    chain.doFilter(request, response);
		

		}

		// login no
		// forgetpassword no
		// admin-dashboard yes

	}
}

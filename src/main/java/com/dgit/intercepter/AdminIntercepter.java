package com.dgit.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.or.dgit.haru.domain.AuthDTO;

public class AdminIntercepter extends HandlerInterceptorAdapter{
	public static final String LOGIN = "auth";
	private static Logger logger = LoggerFactory.getLogger(AdminIntercepter.class);

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		logger.info("postHandle - start..........................");
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		logger.info("preHandle - start..........................");
		
		AuthDTO auth = (AuthDTO) request.getSession().getAttribute(LOGIN);
		if(auth == null || auth.isUadmin() == false){
			logger.info("not Admin");
			response.sendRedirect(request.getContextPath()+"/diary/list.do");
			return false;
		}
		
		return true;
	}
}

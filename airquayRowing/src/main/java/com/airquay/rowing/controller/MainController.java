package com.airquay.rowing.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.airquay.rowing.vo.main;
@Controller
public class MainController {
	
	@Autowired
	private com.airquay.rowing.service.rowingService rowingService;
	
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)//http://localhost:8080/airquayRowing/main 접속 시 호출
	public String main(Model model, HttpServletRequest request, HttpServletResponse response) {
 		HttpSession session = request.getSession();
 		Boolean loginUser = (Boolean) session.getAttribute("loginUser");
 		//loginUser = true; // --> 로그인화면 패스
		if(loginUser==null){
			model.addAttribute("loginCheck", false);
		}else{
			model.addAttribute("loginCheck", true);
		}
		return "main/login"; //main폴더의login.jsp로 ㄱㄱ
	}
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(Model model, HttpServletRequest request, HttpServletResponse response) {
		return "main/main";//main폴더의 main.jsp로 ㄱㄱ
	}
	
	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })//로그인정보 확인 후 true/false반환
	public @ResponseBody Boolean login(Model model, HttpServletRequest request, HttpServletResponse response) {
		main main = new main();
		HttpSession session = request.getSession(false);
		String userId = request.getParameter("userId");
		String userPw = request.getParameter("userPw");
		main.setUserId(userId);
		main.setUserPw(userPw);
		Boolean userCheck = rowingService.checkUser(main);
		if(userCheck==true){
			List<List> userInfo = rowingService.userInfo(main);
			session.setAttribute("loginUser", true);
			session.setAttribute("userName", main.getUserName());
			session.setAttribute("userNo", main.getUserNo());
			session.setAttribute("userId", main.getUserId());
			session.setAttribute("sex", main.getSex());
			session.setAttribute("birth", main.getBirth());
			session.setAttribute("teamName", main.getTeamName());
			session.setAttribute("team_num", main.getteam_num());
			session.setAttribute("teamCountry", main.getTeamCountry());
		}
		return userCheck;
	}
	
	@RequestMapping(value = "/main/raceStartPoling", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody int raceStartPoling(Model model, HttpServletRequest request, HttpServletResponse response) {
		String raceNum = request.getParameter("raceNum");
		Integer startYn = rowingService.raceStartPoling(raceNum);
		return startYn;
	}
	
	@RequestMapping(value = "/main/beforeStartPolling", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List finish_timePoling(Model model, HttpServletRequest request, HttpServletResponse response) {
		main main = new main();
		String raceNum = request.getParameter("raceNum");
		String orderType = request.getParameter("orderType");
		if(orderType==null){
			orderType="finish_time";
		}
		main.setRaceNum(Integer.parseInt(raceNum));
		main.setOrderType(orderType);
		List<List> bowInfo = rowingService.getBowInfo(main);
		return bowInfo;
	}
	
	@RequestMapping(value = "/main/passTimer", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List passTimer(Model model, HttpServletRequest request, HttpServletResponse response) {
		List<List> timeList = rowingService.passTimer();
		return timeList;
	}
	
	@RequestMapping(value = "/main/getRaceInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List getRaceInfo(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		main main = new main();
		String raceDate = request.getParameter("raceDate");
		List<List> raceInfo = rowingService.getRaceInfo(raceDate);
		return raceInfo;
	}
	
	@RequestMapping(value = "/main/getBowInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List getBowInfo(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		main main = new main();
		String raceNum = request.getParameter("raceNum");
		String orderType = request.getParameter("orderType");
		if(orderType==null){
			orderType="finish_time";
		}
		main.setRaceNum(Integer.parseInt(raceNum));
		main.setOrderType(orderType);
		List<List> bowInfo = rowingService.getBowInfo(main);
		return bowInfo;
	}
	
	@RequestMapping(value = "/main/setRaceStart", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Boolean setRaceStart(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Boolean result = false;
		result = rowingService.setRaceStart();
		return result;
	}	
	
	@RequestMapping(value = "/main/setRaceFinish", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Boolean setRaceFinish(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Boolean result = false;
		result = rowingService.setRaceFinish();
		return result;
	}
}

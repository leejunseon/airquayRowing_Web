package com.airquay.rowing.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


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
		List<Object> raceList = new ArrayList<Object>();
		raceList = rowingService.getRaceList();
		model.addAttribute("raceList", raceList);
		return "main/main";//main폴더의 main.jsp로 ㄱㄱ
	}
	
	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })//로그인정보 확인 후 true/false반환
	public @ResponseBody Boolean login(Model model, HttpServletRequest request, HttpServletResponse response) {
		main main = new main();
		HttpSession session = request.getSession(false);
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		main.setUser_id(user_id);
		main.setUser_pw(user_pw);
		Boolean userCheck = rowingService.checkUser(main);
		if(userCheck==true){
			List<List> userInfo = rowingService.userInfo(main);
			session.setAttribute("loginUser", true);
			session.setAttribute("user_name", main.getUser_name());
			session.setAttribute("user_no", main.getUser_no());
			session.setAttribute("user_id", main.getUser_id());
			session.setAttribute("sex", main.getSex());
			session.setAttribute("birth", main.getBirth());
			session.setAttribute("team_name", main.getTeam_name());
			session.setAttribute("team_num", main.getTeam_num());
			session.setAttribute("team_country", main.getTeam_country());
		}
		return userCheck;
	}
	
	@RequestMapping(value = "/main/raceStartPoling", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody int raceStartPoling(Model model, HttpServletRequest request, HttpServletResponse response) {
		String race_num = request.getParameter("race_num");
		Integer startYn = rowingService.raceStartPoling(race_num);
		return startYn;
	}
	
	@RequestMapping(value = "/main/beforeStartPolling", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List finish_timePoling(Model model, HttpServletRequest request, HttpServletResponse response) {
		main main = new main();
		String race_num = request.getParameter("race_num");
		String orderType = request.getParameter("orderType");
		if(orderType==null){
			orderType="finish_time";
		}
		main.setRace_num(Integer.parseInt(race_num));
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
		String race_num = request.getParameter("race_num");
		String orderType = request.getParameter("orderType");
		if(orderType==null){
			orderType="finish_time";
		}
		main.setRace_num(Integer.parseInt(race_num));
		main.setOrderType(orderType);
		List<List> bowInfo = rowingService.getBowInfo(main);
		return bowInfo;
	}
	
	@RequestMapping(value = "/main/setRaceStart", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Boolean setRaceStart(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Boolean result = false;
		String check_onoff = request.getParameter("raceDate");
		main main=new main();
		main.setCheck_onoff(check_onoff);
		result = rowingService.setRaceStart(main);
		return result;
	}		
	
	@RequestMapping(value = "/main/pastTimeSave", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Boolean pastTimeSave(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Boolean result = false;
		String pastHour = request.getParameter("HOUR");
		String pastMinute = request.getParameter("MINUTE");
		String pastSecond = request.getParameter("SECOND");
		String pastMiliSecond = request.getParameter("MILISECOND");
		main main=new main();
		main.setPastHour(Integer.parseInt(pastHour));
		main.setPastMinute(Integer.parseInt(pastMinute));
		main.setPastSecond(Integer.parseInt(pastSecond));
		main.setPastMiliSecond(Integer.parseInt(pastMiliSecond));
		result = rowingService.pastTimeSave(main);
		return result;
	}		
	
	@RequestMapping(value = "/main/startTimeSend", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Boolean startTimeSend(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Boolean result = false;
		String start_time=request.getParameter("start_time");
		String race_num=request.getParameter("race_num");
		main main=new main();
		main.setStart_time(start_time);
		main.setRace_num(Integer.parseInt(race_num));
		result=rowingService.startTimeSend(main);
		return result;
	}
	
	@RequestMapping(value = "/main/finishTimeSend", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Boolean finishTimeSend(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Boolean result = false;
		String stop_time=request.getParameter("stop_time");
		String race_num=request.getParameter("race_num");
		main main=new main();
		main.setStop_time(stop_time);
		main.setRace_num(Integer.parseInt(race_num));
		result=rowingService.stopTimeSend(main);
		return result;
	}
	
	/*	
  	@RequestMapping(value = "/main/getRaceNum", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody JSONObject getRaceNum(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session){
		String CurrentDate = request.getParameter("raceDate");
		main main=new main();
		JSONObject sObject = new JSONObject();
		JSONArray sArray = new JSONArray();
		JSONObject sMain = new JSONObject();
		main.setRace_date(CurrentDate);
		List <List> raceDate=rowingService.getRaceNum(main);
		if(CurrentDate.equals(raceDate.get(0))){
			 sObject.put("key", "ok");
			 sArray.add(0, sObject);
			 sMain.put("dataSend", sArray);
		}
		else{
			 sObject.put("key", "no");
			 sArray.add(0, sObject);
			 sMain.put("dataSend", sArray);
		}
		return sMain;
	}
	*/
	
}

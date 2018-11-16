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
		if(loginUser==null){
			model.addAttribute("loginCheck", false);
		}else{
			model.addAttribute("loginCheck", true);
		}
		//model.addAttribute("loginCheck", false);//새로고침할때마다 로그인
		return "main/login"; //main폴더의login.jsp로 ㄱㄱ
	}
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(Model model, HttpServletRequest request, HttpServletResponse response) {
		List<Object> raceList = new ArrayList<Object>();
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format ( currentTime );
		raceList = rowingService.getRaceList(mTime);
		model.addAttribute("raceList", raceList);
		return "main/dashboard";//main폴더의 main.jsp로 ㄱㄱ
	}
	
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	public String select(Model model, HttpServletRequest request, HttpServletResponse response) {
		return "main/select";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup(Model model, HttpServletRequest request, HttpServletResponse response) {
		return "main/signup";
	}
	
	@RequestMapping(value = "/aftersignup", method = RequestMethod.GET)
	public String aftersignup(Model model, HttpServletRequest request, HttpServletResponse response) {
		return "main/loginResult";
	}
	
	@RequestMapping(value = "/afteraddrace", method = RequestMethod.GET)
	public String afteraddrace(Model model, HttpServletRequest request, HttpServletResponse response) {
		return "main/select";
	}
	
	@RequestMapping(value = "/addrace", method = RequestMethod.GET)
	public String addrace(Model model, HttpServletRequest request, HttpServletResponse response) {
		return "main/addrace";
	}
	
	@RequestMapping(value = "/recordview", method = RequestMethod.GET)
	public String recordview(Model model, HttpServletRequest request, HttpServletResponse response) {
		return "main/recordView";
	}
	
	@RequestMapping(value = "/returnlogin", method = RequestMethod.GET)
	public String returnlogin(Model model, HttpServletRequest request, HttpServletResponse response) {
		return "main/login";
	}
	
	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })//로그인정보 확인 후 true/false반환
	public @ResponseBody List login(Model model, HttpServletRequest request, HttpServletResponse response) {
		main main = new main();
		List<Object> resultList = new ArrayList();
		HttpSession session = request.getSession(false);
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		main.setUser_id(user_id);
		main.setUser_pw(user_pw);
		Boolean userCheck = rowingService.checkUser(main);
		List<List> userInfo = rowingService.userInfo(main);
		if(userCheck==true){
			model.addAttribute("userInfo",userInfo);
			session.setAttribute("loginUser", true);
			resultList.add(0, userInfo);
			resultList.add(1, userCheck);
		}
		else {
			resultList.add(0, userInfo);
			resultList.add(1, userCheck);
		}
		return resultList;
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
		main.setRace_num(Integer.parseInt(race_num));
		List<List> bowInfo = rowingService.getBowInfo(main);
		return bowInfo;
	}
	
	@RequestMapping(value = "/main/passTimer", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List passTimer(Model model, HttpServletRequest request, HttpServletResponse response) {
		main main=new main();
		String race_num=request.getParameter("race_num");
		main.setRace_num(Integer.parseInt(race_num));
		List<List> timeList = rowingService.passTimer(main);
		return timeList;
	}
	
	@RequestMapping(value = "/main/passTimerString", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String passTimerString(Model model, HttpServletRequest request, HttpServletResponse response) {
		main main=new main();
		String race_num=request.getParameter("race_num");
		String timeList = rowingService.passTimerString(race_num);
		return timeList;
	}
	
	@RequestMapping(value = "/main/getRaceInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List getRaceInfo(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		main main = new main();
		String raceDate = request.getParameter("raceDate");
		List<List> raceInfo = rowingService.getRaceInfo(raceDate);
		return raceInfo;
	}
	
	@RequestMapping(value = "/main/getTeamInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List getTeamInfo(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		List<List> teamInfo = rowingService.getteamList();
		return teamInfo;
	}
	
	@RequestMapping(value = "/main/getRecord", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List displayRecord(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String teamName=request.getParameter("team_num");
		List<List> record = rowingService.getRecord(teamName);
		return record;
	}
	
	@RequestMapping(value = "/main/getBowInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List getBowInfo(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		main main = new main();
		String race_num = request.getParameter("race_num");
		main.setRace_num(Integer.parseInt(race_num));
		List<List> bowInfo = rowingService.getBowInfo(main);
		return bowInfo;
	}
	
	@RequestMapping(value = "/main/setOnOff", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Boolean setRaceStart(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Boolean result = false;
		String check_onoff = request.getParameter("OnOff");
		String race_num=request.getParameter("raceNum");
		main main=new main();
		main.setCheck_onoff(check_onoff);
		main.setRace_num(Integer.parseInt(race_num));
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
		String race_num=request.getParameter("raceNum");
		main main=new main();
		main.setPastHour(Integer.parseInt(pastHour));
		main.setPastMinute(Integer.parseInt(pastMinute));
		main.setPastSecond(Integer.parseInt(pastSecond));
		main.setPastMiliSecond(Integer.parseInt(pastMiliSecond));
		main.setRace_num(Integer.parseInt(race_num));
		result = rowingService.pastTimeSave(main);
		return result;
	}		
	
	@RequestMapping(value = "/main/startTimeSend", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Boolean startTimeSend(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Boolean result = false;
		String start_time=request.getParameter("start_time");
		String race_num=request.getParameter("race_num");
		String check_onoff=request.getParameter("OnOff");
		main main=new main();
		main.setStart_time(start_time);
		main.setRace_num(Integer.parseInt(race_num));
		main.setCheck_onoff(check_onoff);
		result=rowingService.startTimeSend(main);
		return result;
	}
	
	@RequestMapping(value = "/main/finishTimeSend", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Boolean finishTimeSend(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Boolean result = false;
		String stop_time=request.getParameter("stop_time");
		String race_num=request.getParameter("race_num");
		String check_onoff=request.getParameter("OnOff");
		main main=new main();
		main.setStop_time(stop_time);
		main.setRace_num(Integer.parseInt(race_num));
		main.setCheck_onoff(check_onoff);
		result=rowingService.stopTimeSend(main);
		return result;
	}
	
	@RequestMapping(value = "/main/getStartTime", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List getStartTime(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String race_num=request.getParameter("race_num");
		main main=new main();
		main.setRace_num(Integer.parseInt(race_num));
		List<List> StartTime=rowingService.getStartTime(main);
		return StartTime;
	}
	
	@RequestMapping(value = "/main/getFinishTime", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List getFinishTime(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String race_num=request.getParameter("race_num");
		main main=new main();
		main.setRace_num(Integer.parseInt(race_num));
		List<List> FinishTime=rowingService.getFinishTime(main);
		return FinishTime;
	}
		
  	@RequestMapping(value = "/main/getRaceNum", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody JSONObject getRaceNum(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session){
		String CurrentDate = request.getParameter("raceDate");
		String raceNum=request.getParameter("raceNum");
		main main=new main();
		main.setRace_date(CurrentDate);
		main.setRace_num(Integer.parseInt(raceNum));
		JSONObject sObject = new JSONObject();
		JSONArray sArray = new JSONArray();
		JSONObject sMain = new JSONObject();
		String raceDate=rowingService.getRaceNum(main);
		if(CurrentDate.equals(raceDate)){
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
  	
  	@RequestMapping(value = "/main/nextRacenum", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody JSONObject nextRacenum(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session){
		String raceNum=request.getParameter("raceNum");
		main main=new main();
		main.setRace_num(Integer.parseInt(raceNum));
		main.setHut("Start");
		String startRacenum=rowingService.getCurrentRaceNum(main);
		String Hut=request.getParameter("Hut");
		main.setHut(Hut);
		JSONObject sObject = new JSONObject();
		JSONArray sArray = new JSONArray();
		JSONObject sMain = new JSONObject();
		if(main.getRace_num()<Integer.parseInt(startRacenum)){
			main.setRace_num(Integer.parseInt(raceNum)+1);
			 rowingService.nextRacenum(main);
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
  	
  	@RequestMapping(value = "/main/recordUpload", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody void recordUpload(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String Hut=request.getParameter("HUT");
		String rank=request.getParameter("RANK");
		String Hour=request.getParameter("HOUR");
		String Minute=request.getParameter("MINUTE");
		String Second=request.getParameter("SECOND");
		String MiliSecond=request.getParameter("MILISECOND");
		String BowNum=request.getParameter("BOWNUM");
		String RaceNum=request.getParameter("RACENUM");
		String LabTime=Hour+":"+Minute+":"+Second+"."+MiliSecond;
		main main=new main();
		main.setHut(Hut);
		main.setRank(Integer.parseInt(rank));
		main.setLabTime(LabTime);
		main.setBow_num(Integer.parseInt(BowNum));
		main.setRace_num(Integer.parseInt(RaceNum));
		rowingService.recordUpload(main);
	}
  	
  	@RequestMapping(value = "/main/fiveNull", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String fiveNull(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
  		String result=null;
  		String race_num = request.getParameter("race_num");
  		result = rowingService.five_null(race_num);
  		return result;
	}
  	  	
  	@RequestMapping(value = "/main/updateRaceinfo", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody JSONObject updateRaceinfo(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session){
		String race_date = request.getParameter("raceDate");
		String Hut=request.getParameter("Hut");
		main main=new main();
		main.setHut(Hut);//Hut 설정
		main.setRace_date(race_date);//경기 날짜 설정
		String race_num=rowingService.getCurrentRaceNum(main);//Hut에 따른 현재 경기번호 가져옴
		main.setRace_num(Integer.parseInt(race_num));//진행중인 경기 번호 설정
		
		String check_onoff=rowingService.getCurrentOnoff(main);
		String start_time=rowingService.getCurrenStarttime(main);
		String finish_time=rowingService.passTimerString(race_num);
		String day_race_num=rowingService.dayRacenum(race_num);
		String five_null=rowingService.five_null(race_num);
		
		JSONObject Racenum = new JSONObject();
		JSONObject Onoff=new JSONObject();
		JSONObject Starttime=new JSONObject();
		JSONObject Finishtime=new JSONObject();
		JSONObject dayRacenum=new JSONObject();
		JSONObject fiveNull=new JSONObject();
		JSONArray sArray = new JSONArray();
		JSONObject sMain = new JSONObject();

		Racenum.put("race_num", race_num);
		Onoff.put("Onoff", check_onoff);
		Starttime.put("StartTime", start_time);
		Finishtime.put("FinishTime", finish_time);
		dayRacenum.put("day_race_num", day_race_num);
		fiveNull.put("five_null", five_null);
		sArray.add(0, Racenum);
		sArray.add(1,Onoff);
		sArray.add(2,Starttime);
		sArray.add(3,Finishtime);
		sArray.add(4,dayRacenum);
		sArray.add(5,fiveNull);
		sMain.put("dataSend", sArray);
	
		return sMain;
	}
  	
	@RequestMapping(value = "/main/addUser", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody void addUser(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
  		String user_id=request.getParameter("user_id");
  		String user_pw=request.getParameter("user_pw");
  		String user_name=request.getParameter("user_name");
  		String sex=request.getParameter("sex");
  		String birthday=request.getParameter("birthday");
  		String nationality=request.getParameter("nationality");
  		String team_num=request.getParameter("team_num");
  		
  		main main=new main();
  		main.setUser_id(user_id);
  		main.setUser_pw(user_pw);
  		main.setUser_name(user_name);
  		main.setSex(sex);
  		main.setBirth(birthday);
  		main.setNationality(nationality);
  		main.setTeam_num(Integer.parseInt(team_num));
  		
  		rowingService.addUser(main);
	}
	
	@RequestMapping(value = "/main/addRace", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody void addRace(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
  		String event_name=request.getParameter("event_name");
  		String race_date=request.getParameter("year")+"-"+request.getParameter("month")+"-"+request.getParameter("day");
  		String round_type=request.getParameter("round_type");
  		String progression=request.getParameter("progression");
  		String LaneOne=request.getParameter("LaneOne");
  		String LaneTwo=request.getParameter("LaneTwo");
  		String LaneThree=request.getParameter("LaneThree");
  		String LaneFour=request.getParameter("LaneFour");
  		String LaneFive=request.getParameter("LaneFive");
  		String LaneSix=request.getParameter("LaneSix");
  		int day_race_num=rowingService.getDayracenum(race_date);
  		int race_num=rowingService.getracenum();
  		
  		main main=new main();
  		main.setDay_race_num(day_race_num);
  		main.setRace_num(race_num);
  		main.setEvent_name(event_name);
  		main.setRace_date(race_date);
  		main.setRound_type(round_type);
  		main.setProgression(progression);
  		main.setLaneOne(LaneOne);
  		main.setLaneTwo(LaneTwo);
  		main.setLaneThree(LaneThree);
  		main.setLaneFour(LaneFour);
  		main.setLaneFive(LaneFive);
  		main.setLaneSix(LaneSix);
  		
  		rowingService.addRace(main);
  	}
}
package com.airquay.rowing.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.airquay.rowing.vo.main;

@Repository
public class mainDaoImpl  implements mainDAO{
	@Autowired
	private SqlSession sqlSession;
	
	private String mapper = "mapper.main.";
	
	@Override
	public Integer raceStartPoling(String race_num) {
		// TODO Auto-generated method stub
		Integer startYn = sqlSession.selectOne(mapper+"raceStartPoling", race_num);
		return startYn;
	}

	@Override
	public List passTimer(main main) {
		// TODO Auto-generated method stub
		
		List passTimer = sqlSession.selectList(mapper+"getPassTimer",main);
		return passTimer;
	}

	@Override
	public List getRaceInfo(String toDay) {
		// TODO Auto-generated method stub
		List raceInfo = sqlSession.selectList(mapper+"getRaceInfo", toDay);
		return raceInfo;
	}

	@Override
	public List getbowInfo(main main) {
		// TODO Auto-generated method stub
		List bowInfo = sqlSession.selectList(mapper+"getBowInfo", main);
		return bowInfo;
	}

	@Override
	public List checkUser(main main) {
		// TODO Auto-generated method stub
		List userCheck = sqlSession.selectList(mapper+"checkUser", main);
		return userCheck;
	}

	@Override
	public List getUserInfo(main main) {
		// TODO Auto-generated method stub
		List userInfo = sqlSession.selectList(mapper+"getUserInfo", main);
		return userInfo;
	}

	@Override
	public void setRaceStart(main main) {
		// TODO Auto-generated method stub
		sqlSession.update(mapper+"setRaceStart",main);
	}

	@Override
	public void pastTimeSave(main main) {
		// TODO Auto-generated method stub
		sqlSession.update(mapper+"pastTimeSave",main);
	}

	@Override
	public void startTimeSend(main main) {
		// TODO Auto-generated method stub
		sqlSession.update(mapper+"startTimeSend",main);
	}

	@Override
	public void stopTimeSend(main main) {
		// TODO Auto-generated method stub
		sqlSession.update(mapper+"stopTimeSend",main);
	}

	@Override
	public List getRaceList(String mTime) {
		// TODO Auto-generated method stub
		List raceList=sqlSession.selectList(mapper+"getRaceList",mTime);
		return raceList;
	}

	@Override
	public List getStartTime(main main) {
		// TODO Auto-generated method stub
		List StartTime=sqlSession.selectList(mapper+"getStartTime",main);
		return StartTime;
	}

	@Override
	public List getFinishTime(main main) {
		// TODO Auto-generated method stub
		List FinishTime = sqlSession.selectList(mapper+"getFinishTime",main);	
		return FinishTime;
	}

	@Override
	public String getRaceNum(main main) {
		// TODO Auto-generated method stub
		String raceInfo=sqlSession.selectOne(mapper+"getRaceNum", main);
		if(raceInfo!=null)
			sqlSession.update(mapper+"updateRaceNum", main);
		return raceInfo;
	}

	@Override
	public void recordUpload(main main) {
		// TODO Auto-generated method stub
		if(main.getHut().equals("500m"))
			sqlSession.update(mapper+"recordUpload500m",main);
		else if(main.getHut().equals("1000m"))
			sqlSession.update(mapper+"recordUpload1000m",main);
		else if(main.getHut().equals("1500m"))
			sqlSession.update(mapper+"recordUpload1500m",main);
		else if(main.getHut().equals("Final"))
			sqlSession.update(mapper+"recordUploadFinish",main);
	}

	@Override
	public String getCurrentRaceNum(main main) {
		// TODO Auto-generated method stub
		String CurrentRaceNum=null;
		if(main.getHut().equals("Start"))
			CurrentRaceNum=sqlSession.selectOne(mapper+"getCurrentRaceNum_Start");
		else if(main.getHut().equals("500m"))
			CurrentRaceNum=sqlSession.selectOne(mapper+"getCurrentRaceNum_500");
		else if(main.getHut().equals("1000m"))
			CurrentRaceNum=sqlSession.selectOne(mapper+"getCurrentRaceNum_1000");
		else if(main.getHut().equals("1500m"))
			CurrentRaceNum=sqlSession.selectOne(mapper+"getCurrentRaceNum_1500");
		else if(main.getHut().equals("Final"))
			CurrentRaceNum=sqlSession.selectOne(mapper+"getCurrentRaceNum_Final");

		return CurrentRaceNum;
	}

	@Override
	public String getCurrentOnoff(main main) {
		// TODO Auto-generated method stub
		String CurrentOnoff=sqlSession.selectOne(mapper+"getCurrentOnoff",main);
		return CurrentOnoff;
	}

	@Override
	public String getCurrentStarttime(main main) {
		// TODO Auto-generated method stub
		String CurrentStarttime=sqlSession.selectOne(mapper+"getCurrentStarttime",main);
		return CurrentStarttime;
	}

	@Override
	public void nextRacenum(main main) {
		// TODO Auto-generated method stub
		if(main.getHut().equals("500m"))
			sqlSession.update(mapper+"nextRacenum_500",main);
		else if(main.getHut().equals("1000m"))
			sqlSession.update(mapper+"nextRacenum_1000",main);
		else if(main.getHut().equals("1500m"))
			sqlSession.update(mapper+"nextRacenum_1500",main);
		else if(main.getHut().equals("Final"))
			sqlSession.update(mapper+"nextRacenum_Final",main);
	}


	@Override
	public String passTimerString(String race_num) {
		// TODO Auto-generated method stub
		String pastHour=sqlSession.selectOne(mapper+"pastHour",race_num);
		String pastMinute=sqlSession.selectOne(mapper+"pastMinute",race_num);
		String pastSecond=sqlSession.selectOne(mapper+"pastSecond",race_num);
		String pastMiliSecond=sqlSession.selectOne(mapper+"pastMiliSecond",race_num);
		
		if(Integer.parseInt(pastHour)<10)
			pastHour="0"+pastHour;
		if(Integer.parseInt(pastMinute)<10)
			pastMinute="0"+pastMinute;
		if(Integer.parseInt(pastSecond)<10)
			pastSecond="0"+pastSecond;
		if(Integer.parseInt(pastMiliSecond)<10)
			pastMiliSecond="0"+pastMiliSecond;
		
		String passTimerString=pastHour+":"+pastMinute+":"+pastSecond+"."+pastMiliSecond;
		
		return passTimerString;
	}

	@Override
	public String dayRacenum(String race_num) {
		// TODO Auto-generated method stub
		String dayRacenum=sqlSession.selectOne(mapper+"dayRacenum",race_num);
		return dayRacenum;
	}
	
	@Override
	public String five_null(String race_num) {
		// TODO Auto-generated method stub
		String result;
		
		String teamOne=sqlSession.selectOne(mapper+"five_null_one",race_num);
		String teamTwo=sqlSession.selectOne(mapper+"five_null_two",race_num);
		String teamThree=sqlSession.selectOne(mapper+"five_null_three",race_num);
		String teamFour=sqlSession.selectOne(mapper+"five_null_four",race_num);
		String teamFive=sqlSession.selectOne(mapper+"five_null_five",race_num);
		String teamSix=sqlSession.selectOne(mapper+"five_null_six",race_num);
				
		if(teamOne==null &&
		   teamTwo==null &&
		   teamThree==null &&
		   teamFour==null &&
		   teamFive==null && 
		   teamSix==null) {
			result="true";
		}else {
			result="false";
		}
		return result;
	}

	@Override
	public void addUser(main main) {
		// TODO Auto-generated method stub
		sqlSession.insert(mapper+"addUser", main);
	}

	@Override
	public int getDayracenum(String race_date) {
		// TODO Auto-generated method stub
		int Dayracenum;
		List<List> pastRace=sqlSession.selectList(mapper+"getPastrace",race_date);
		Dayracenum=pastRace.size()+1;
		return Dayracenum;
	}

	@Override
	public void addRace(main main) {
		// TODO Auto-generated method stub
		sqlSession.insert(mapper+"addRace",main);
		sqlSession.insert(mapper+"addIson",main);
		
		sqlSession.insert(mapper+"addRecordOne",main);
		sqlSession.insert(mapper+"addRecordTwo",main);
		sqlSession.insert(mapper+"addRecordThree",main);
		sqlSession.insert(mapper+"addRecordFour",main);
		sqlSession.insert(mapper+"addRecordFive",main);
		sqlSession.insert(mapper+"addRecordSix",main);
	}

	@Override
	public int getRacenum() {
		// TODO Auto-generated method stub
		String raceNum=sqlSession.selectOne(mapper+"getRacenum");
		int race_num=Integer.parseInt(raceNum)+1;
		return race_num;
	}

	@Override
	public List getTeamList() {
		// TODO Auto-generated method stub
		List teamList=sqlSession.selectList(mapper+"getTeamList");
		return teamList;
	}

	@Override
	public List getRecord(String teamName) {
		// TODO Auto-generated method stub
		List record=sqlSession.selectList(mapper+"getRecord",teamName);
		return record;
	}

}

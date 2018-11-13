package com.airquay.rowing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airquay.rowing.vo.main;

@Service
public class rowingService {
	@Autowired
	private com.airquay.rowing.dao.mainDAO mainDAO;

	public Integer raceStartPoling(String race_num) {
		// TODO Auto-generated method stub
		Integer startYn = mainDAO.raceStartPoling(race_num);
		return startYn;
	}

	public List<List> passTimer(main main) {
		// TODO Auto-generated method stub
		List passTimer = mainDAO.passTimer(main);
		return passTimer;
	}

	public List<List> getRaceInfo(String toDay) {
		// TODO Auto-generated method stub
		List raceInfo = mainDAO.getRaceInfo(toDay);
		return raceInfo;
	}
	public List<List> getBowInfo(main main) {
		// TODO Auto-generated method stub
		List bowInfo = mainDAO.getbowInfo(main);
		return bowInfo;
	}

	public Boolean checkUser(main main) {
		// TODO Auto-generated method stub
		List userCheck = mainDAO.checkUser(main);
		if(userCheck.size() == 1){
			return true;
		}else{
			return false;
		}
	}
	
	public List<List> userInfo(main main) {
		// TODO Auto-generated method stub
		List userInfo = mainDAO.getUserInfo(main);
		return userInfo;
	}

	public Boolean setRaceStart(main main) {
		// TODO Auto-generated method stub
		Boolean result;
		try {
			mainDAO.setRaceStart(main);
			result=true;
		}catch(Exception e) {
			result=false;
		}
		return result;
	}

	public Boolean pastTimeSave(main main) {
		// TODO Auto-generated method stub
		Boolean result;
		try {
			mainDAO.pastTimeSave(main);
			result=true;
		}catch(Exception e) {
			result=false;
		}
		return result;
	}

	public Boolean startTimeSend(main main) {
		// TODO Auto-generated method stub
		Boolean result;
		try {
			mainDAO.startTimeSend(main);
			result=true;
		}catch(Exception e) {
			result=false;
		}
		return result;
	}

	public Boolean stopTimeSend(main main) {
		// TODO Auto-generated method stub
		Boolean result;
		try {
			mainDAO.stopTimeSend(main);
			result=true;
		}catch(Exception e) {
			result=false;
		}
		return result;
	}


	public List<Object> getRaceList(String mTime) {
		// TODO Auto-generated method stub
		List raceList=mainDAO.getRaceList(mTime);
		return raceList;
	}

	public List<List> getStartTime(main main) {
		// TODO Auto-generated method stub
		List StartTime = mainDAO.getStartTime(main);
		return StartTime;
	}

	public List<List> getFinishTime(main main) {
		// TODO Auto-generated method stub
		List FinishTime=mainDAO.getFinishTime(main);
		return FinishTime;
	}

	public String getRaceNum(main main) {
		// TODO Auto-generated method stub
		String raceInfo=mainDAO.getRaceNum(main);
		return raceInfo;
	}

	public void recordUpload(main main) {
		// TODO Auto-generated method stub
		mainDAO.recordUpload(main);
	}

	public String getCurrentRaceNum(main main) {
		// TODO Auto-generated method stub
		String CurrentRaceNum=mainDAO.getCurrentRaceNum(main);
		return CurrentRaceNum;
	}

	public String getCurrentOnoff(main main) {
		// TODO Auto-generated method stub
		String CurrentOnoff=mainDAO.getCurrentOnoff(main);
		return CurrentOnoff;
	}

	public String getCurrenStarttime(main main) {
		// TODO Auto-generated method stub
		String CurrentStarttime=mainDAO.getCurrentStarttime(main);
		return CurrentStarttime;
	}

	public void nextRacenum(main main) {
		// TODO Auto-generated method stub
		mainDAO.nextRacenum(main);
	}

	public String passTimerString(String race_num) {
		// TODO Auto-generated method stub
		String passTimerString = mainDAO.passTimerString(race_num);
		return passTimerString;
	}

	public String dayRacenum(String race_num) {
		// TODO Auto-generated method stub
		String dayRacenum=mainDAO.dayRacenum(race_num);
		return dayRacenum;
	}

	public String five_null(String race_num) {
		// TODO Auto-generated method stub
		String result =mainDAO.five_null(race_num);
		return result;
	}

	public void addUser(main main) {
		// TODO Auto-generated method stub
		mainDAO.addUser(main);
	}

	public int getDayracenum(String race_date) {
		// TODO Auto-generated method stub
		int pastRace=mainDAO.getDayracenum(race_date);
		return pastRace;
	}

	public void addRace(main main) {
		// TODO Auto-generated method stub
		mainDAO.addRace(main);
	}

	public int getracenum() {
		// TODO Auto-generated method stub
		int race_num=mainDAO.getRacenum();
		return race_num;
	}

	public List<Object> getteamList() {
		// TODO Auto-generated method stub
		List teamList=mainDAO.getTeamList();
		return teamList;
	}

	public List<Object> getRecord(String teamName) {
		// TODO Auto-generated method stub
		List record=mainDAO.getRecord(teamName);
		return record;
	}


}

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

	public List<List> passTimer() {
		// TODO Auto-generated method stub
		List passTimer = mainDAO.passTimer();
		return passTimer;
	}

	public List<List> getRank(main main) {
		// TODO Auto-generated method stub
		List rankList = mainDAO.getRank(main);
		return rankList;
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
		Boolean result = false;
//try catch 성공 = return = true
		// 실패 = return = false
		mainDAO.setRaceStart(main);

		return result;
	}

	public Boolean pastTimeSave(main main) {
		// TODO Auto-generated method stub
		
		Boolean result=false;
		mainDAO.pastTimeSave(main);
		return result;
	}

	public Boolean startTimeSend(main main) {
		// TODO Auto-generated method stub
		Boolean result=false;
		mainDAO.startTimeSend(main);
		return result;
	}

	public Boolean stopTimeSend(main main) {
		// TODO Auto-generated method stub
		Boolean result=false;
		mainDAO.stopTimeSend(main);
		return result;
	}


	public List<Object> getRaceList() {
		// TODO Auto-generated method stub
		List raceList=mainDAO.getRaceList();
		return raceList;
	}




}

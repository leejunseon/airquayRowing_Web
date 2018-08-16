package com.airquay.rowing.dao;

import java.util.List;

import com.airquay.rowing.vo.main;

public interface mainDAO {

	Integer raceStartPoling(String race_num);

	List passTimer(main main);

	List getRank(main main);

	List getRaceInfo(String toDay);

	List getbowInfo(main main);

	List checkUser(main main);

	List getUserInfo(main main);

	void setRaceStart(main main);

	void pastTimeSave(main main);

	void startTimeSend(main main);

	void stopTimeSend(main main);

	List getRaceList();

	List getStartTime(main main);

	List getFinishTime(main main);

	String getRaceNum(String raceNum);

	void recordUpload(main main);

	String getCurrentRaceNum(main main);

	String getCurrentOnoff(main main);

	String getCurrentStarttime(main main);

	void nextRacenum(main main);
	
}

package com.airquay.rowing.dao;

import java.util.List;

import com.airquay.rowing.vo.main;

public interface mainDAO {

	Integer raceStartPoling(String race_num);

	List passTimer(main main);

	List getRaceInfo(String toDay);

	List getbowInfo(main main);

	List checkUser(main main);

	List getUserInfo(main main);

	void setRaceStart(main main);

	void pastTimeSave(main main);

	void startTimeSend(main main);

	void stopTimeSend(main main);

	List getRaceList(String mTime);

	List getStartTime(main main);

	List getFinishTime(main main);

	String getRaceNum(main main);

	void recordUpload(main main);

	String getCurrentRaceNum(main main);

	String getCurrentOnoff(main main);

	String getCurrentStarttime(main main);

	void nextRacenum(main main);

	String passTimerString(String race_num);

	String dayRacenum(String race_num);

	String five_null(String race_num);

	void addUser(main main);

	int getDayracenum(String race_date);

	void addRace(main main);

	int getRacenum();

	List getTeamList();

	List getRecord(String teamName);
	
}

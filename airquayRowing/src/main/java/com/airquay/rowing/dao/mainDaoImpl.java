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
	public List passTimer() {
		// TODO Auto-generated method stub
		
		List passTimer = sqlSession.selectList(mapper+"getPassTimer");
		return passTimer;
	}

	@Override
	public List getRank(main main) {
		// TODO Auto-generated method stub
		
		List rankList = sqlSession.selectList(mapper+"getRankList", main);
		return rankList;
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

}

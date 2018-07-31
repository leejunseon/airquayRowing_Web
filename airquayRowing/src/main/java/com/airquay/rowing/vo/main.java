package com.airquay.rowing.vo;

public class main {

		private Integer raceNum;
	    private Integer dayRaceNum;
	    private String eventName;
	    private String raceDate;
	    private String roundType;
	    private String startTime;
	    private String stopTime;
	    private String checkOnoff;
	    private String progression;
	    private Integer recordNum;
	    private Integer teamNum;
	    private Integer rank;
	    private Integer bowNum;
	    private String finish_time;
	    private String hTime;
	    private String htTime;
	    private String finishTime;
	    private Integer prNum;
	    private Integer playerNum;

	    private String playerName;
	    private String sex;
	    private String birth;
	    private String nationality;
	    private String orderType;
	    
	    //airquay_user_table
		private Integer userNo;
		private String userId;
		private String userPw;
		private String userName;
		private String Nationality;
		private String teamManagerYn;
		private Integer adminYn;
		
		//team_info_table
	    private String teamName;
	    private String teamCountry;
	    private Integer team_num;
	    
	    //ison_table
	    private Integer pastHour;
		private Integer pastMinute;
	    private Integer pastSecond;
	    private Integer pastMiliSecond;
	   
	    public Integer getPastHour() {
			return pastHour;
		}
		public void setPastHour(Integer pastHour) {
			this.pastHour = pastHour;
		}
		public Integer getPastMinute() {
			return pastMinute;
		}
		public void setPastMinute(Integer pastMinute) {
			this.pastMinute = pastMinute;
		}
		public Integer getPastSecond() {
			return pastSecond;
		}
		public void setPastSecond(Integer pastSecond) {
			this.pastSecond = pastSecond;
		}
		public Integer getPastMiliSecond() {
			return pastMiliSecond;
		}
		public void setPastMiliSecond(Integer pastMiliSecond) {
			this.pastMiliSecond = pastMiliSecond;
		}

		private String Fivehundred_Time;
		private String Thousand_Time;
		private String ThousandFivehundred_Time;
		
		public String getFivehundred_Time() {
			return Fivehundred_Time;
		}
		public void setFivehundred_Time(String fivehundred_Time) {
			Fivehundred_Time = fivehundred_Time;
		}
		public String getThousand_Time() {
			return Thousand_Time;
		}
		public void setThousand_Time(String thousand_Time) {
			Thousand_Time = thousand_Time;
		}
		public String getThousandFivehundred_Time() {
			return ThousandFivehundred_Time;
		}
		public void setThousandFivehundred_Time(String thousandFivehundred_Time) {
			ThousandFivehundred_Time = thousandFivehundred_Time;
		}
		
		
		
	    public Integer getteam_num() {
			return team_num;
		}
		public void setteam_num(Integer team_num) {
			this.team_num = team_num;
		}

		
	    private Boolean loginCheck;
		public Boolean getLoginCheck() {
			return loginCheck;
		}
		public void setLoginCheck(Boolean loginCheck) {
			this.loginCheck = loginCheck;
		}
		public Integer getUserNo() {
			return userNo;
		}
		public void setUserNo(Integer userNo) {
			this.userNo = userNo;
		}
		public String getUserId() {
			return userId;
		}
		public void setUserId(String userId) {
			this.userId = userId;
		}
		public String getUserPw() {
			return userPw;
		}
		public void setUserPw(String userPw) {
			this.userPw = userPw;
		}
		public String getUserName() {
			return userName;
		}
		public void setUserName(String userName) {
			this.userName = userName;
		}
		public String getTeamManagerYn() {
			return teamManagerYn;
		}
		public void setTeamManagerYn(String teamManagerYn) {
			this.teamManagerYn = teamManagerYn;
		}
		public Integer getAdminYn() {
			return adminYn;
		}
		public void setAdminYn(Integer adminYn) {
			this.adminYn = adminYn;
		}
		public String getOrderType() {
			return orderType;
		}
		public void setOrderType(String orderType) {
			this.orderType = orderType;
		}
		public Integer getRaceNum() {
			return raceNum;
		}
		public void setRaceNum(Integer raceNum) {
			this.raceNum = raceNum;
		}
		public Integer getDayRaceNum() {
			return dayRaceNum;
		}
		public void setDayRaceNum(Integer dayRaceNum) {
			this.dayRaceNum = dayRaceNum;
		}
		public String getEventName() {
			return eventName;
		}
		public void setEventName(String eventName) {
			this.eventName = eventName;
		}
		public String getRaceDate() {
			return raceDate;
		}
		public void setRaceDate(String raceDate) {
			this.raceDate = raceDate;
		}
		public String getRoundType() {
			return roundType;
		}
		public void setRoundType(String roundType) {
			this.roundType = roundType;
		}
		public String getStartTime() {
			return startTime;
		}
		public void setStartTime(String startTime) {
			this.startTime = startTime;
		}
		public String getStopTime() {
			return stopTime;
		}
		public void setStopTime(String stopTime) {
			this.stopTime = stopTime;
		}
		public String getCheckOnoff() {
			return checkOnoff;
		}
		public void setCheckOnoff(String checkOnoff) {
			this.checkOnoff = checkOnoff;
		}
		public String getProgression() {
			return progression;
		}
		public void setProgression(String progression) {
			this.progression = progression;
		}
		public Integer getRecordNum() {
			return recordNum;
		}
		public void setRecordNum(Integer recordNum) {
			this.recordNum = recordNum;
		}
		public Integer getTeamNum() {
			return teamNum;
		}
		public void setTeamNum(Integer teamNum) {
			this.teamNum = teamNum;
		}
		public Integer getRank() {
			return rank;
		}
		public void setRank(Integer rank) {
			this.rank = rank;
		}
		public Integer getBowNum() {
			return bowNum;
		}
		public void setBowNum(Integer bowNum) {
			this.bowNum = bowNum;
		}
		public String getfinish_time() {
			return finish_time;
		}
		public void setfinish_time(String finish_time) {
			this.finish_time = finish_time;
		}
		public String gethTime() {
			return hTime;
		}
		public void sethTime(String hTime) {
			this.hTime = hTime;
		}
		public String getHtTime() {
			return htTime;
		}
		public void setHtTime(String htTime) {
			this.htTime = htTime;
		}
		public String getFinishTime() {
			return finishTime;
		}
		public void setFinishTime(String finishTime) {
			this.finishTime = finishTime;
		}
		public Integer getPrNum() {
			return prNum;
		}
		public void setPrNum(Integer prNum) {
			this.prNum = prNum;
		}
		public Integer getPlayerNum() {
			return playerNum;
		}
		public void setPlayerNum(Integer playerNum) {
			this.playerNum = playerNum;
		}
		public String getTeamName() {
			return teamName;
		}
		public void setTeamName(String teamName) {
			this.teamName = teamName;
		}
		public String getTeamCountry() {
			return teamCountry;
		}
		public void setTeamCountry(String teamCountry) {
			this.teamCountry = teamCountry;
		}
		public String getPlayerName() {
			return playerName;
		}
		public void setPlayerName(String playerName) {
			this.playerName = playerName;
		}
		public String getSex() {
			return sex;
		}
		public void setSex(String sex) {
			this.sex = sex;
		}
		public String getBirth() {
			return birth;
		}
		public void setBirth(String birth) {
			this.birth = birth;
		}
		public String getNationality() {
			return nationality;
		}
		public void setNationality(String nationality) {
			this.nationality = nationality;
		}

	    
	    
}
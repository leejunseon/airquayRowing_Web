<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Rowing Airquay</title>
<link type="text/css" rel="stylesheet" href="http://localhost:8080/airquayRowing/resources/css/rowingCommon.css?ver=1">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css?ver=1">

<script src="http://localhost:8080/airquayRowing/resources/js/rowingCommon.js?ver=1"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js?ver=1"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js?ver=1"></script>
<script type="text/javascript">
	var raceList;
	var raceInfo;
	var bowInfo;
	var start_time; // starting time
	var stopwatch; // timer ID
	var output; //  output string
	var count; // number of record
	var flag=0;
	var polingStatus = "start"; // polling으로 가져올 url선택옵션 start : 시작전, 500m :500m전, 1000m :1000m전, 1500m :1500m전, finish :2000m전
	
	$(document).ready(function() {
		console.log("main.jsp Start")
		realTimeClock();//시간
		setInterval(realTimeClock, 1000);//1초마다 시간 업뎃
		doResize();
		dateInput();//날짜
		common.getRaceInfo();
		raceList = ${raceList};
		setInterval(common.RacePoling , 1000);//서버의 타이머 켜짐의 유무를 나타내는 값인 isOn 테이블의 onOrOff값이 1이면 서버의 타이머도 시작
// 		$( "#datepicker" ).datepicker({
// 			dateFormat: "yy-mm-dd",
// 		});
	});
	
function doResize(){
	var windowWidth = $(window).width();
	if(windowWidth>1680){
		$("#bodyArea").css("margin-left", (windowWidth-1676)/2)
		$("#btnArea").css("margin-right", (windowWidth-1676)/2)
	}
}
function realTimeClock() {
	var time = getDateStamp();
	$("#time").text(time);
}
function dateInput(){
	var date = getTimeStamp();
	$("#toDay").text(date);
	//common.getRaceInfo();
}
function getDateStamp() {
	var d = new Date();
	var date = leadingZeros(d.getHours(), 2) + ':'
	+ leadingZeros(d.getMinutes(), 2) + ':'
	+ leadingZeros(d.getSeconds(), 2);
	return date;
}
function getTimeStamp() {
	var d2 = new Date();
	var time = leadingZeros(d2.getFullYear(), 4) + '-'
	+ leadingZeros(d2.getMonth() + 1, 2) + '-'
	+ leadingZeros(d2.getDate(), 2);
	return time;
}
function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();
	
	if (n.length < digits) {
		for (i = 0; i < digits - n.length; i++){
			zero += '0';
		}
	}
	return zero + n;
}
</script>
</head>

<!-- <body onload="realTimeClock();init();"> -->
<body id="bodyArea" style="margin-top: 25px; min-width: 1680px;">
    <div class="container" style="width: 100%; height: 35px; line-height: 35px; font-size: 25px; margin-top: 10px; float: left;">
    	<div style="float: left; height: 35px; background-color: white; border: 1px solid;">
    		<select id="infrontrace_num" style="font-size: 25px; background-color: white; color: black; margin-top: 3px; border: 0px;" onchange="javascript:common.dispRaceInfo(); common.getBowInfo();">
    			<option value="-">No data</option>
    		</select>
    	</div>
<!--     	<div style="float: left; margin-left: 10px; text-align: center;" id="date"> -->
    		<div type="text" style="float: left; margin-left: 10px; text-align: center; background-color: transparent; border: none; width: 200px; height: 35px; font-size: 32px; font-weight: bold; color: white;" id="toDay"></div>
<!--     	</div> -->
    	<div style="float: left; margin-left: 10px; text-align: center; font-size: 32px;" id="time"></div>
    	<div style="float: left; margin-left: 10px; width: 120px; text-align: center; font-weight: bold; color: white;" id="raceStatus">경기종료</div>
    </div>
    <div style="float: left; border: 1px solid white; margin-top: 20px; width: 1675px;">
    	<div style="float: left; width: 100%;">
    		<div id="watchtime" style="margin-left: 30px; float: left; width: 800px;">00:00:00.00</div>
	    	<div style="float: left; width: 800px; margin-top: 25px;">
		    	<div style="width: 100%; float: left; font-size: 23px; color: white; margin-left: 30px; font-weight: bold;">
		    		<div style="float: left;">
			    		<div style="float: left; width: 120px; text-align: center;">1</div>
		    		</div>
		    		<div style="float: left; margin-left: 10px;">
			    		<div style="float: left; width: 120px; text-align: center;">2</div>
		    		</div>
		    		<div style="float: left; margin-left: 10px;">
			    		<div style="float: left; width: 120px; text-align: center;">3</div>
		    		</div>
		    		<div style="float: left;">
			    		<div style="float: left; width: 120px; text-align: center;">4</div>
		    		</div>
		    		<div style="float: left; margin-left: 10px;">
			    		<div style="float: left; width: 120px; text-align: center;">5</div>
		    		</div>
		    		<div style="float: left; margin-left: 10px;">
			    		<div style="float: left; width: 120px; text-align: center;">6</div>
		    		</div>
		    	</div>
		    	<div style="width: 100%; float: left; font-size: 23px; color: white; margin-left: 30px; font-weight: bold;">
		    		<div style="float: left;">
			    		<div id="bowNum1" style="float: left; width: 120px; text-align: center;">-</div>
		    		</div>
		    		<div style="float: left; margin-left: 10px;">
			    		<div id="bowNum2" style="float: left; width: 120px; text-align: center;">-</div>
		    		</div>
		    		<div style="float: left; margin-left: 10px;">
			    		<div id="bowNum3" style="float: left; width: 120px; text-align: center;">-</div>
		    		</div>
		    		<div style="float: left;">
			    		<div id="bowNum4" style="float: left; width: 120px; text-align: center;">-</div>
		    		</div>
		    		<div style="float: left; margin-left: 10px;">
			    		<div id="bowNum5" style="float: left; width: 120px; text-align: center;">-</div>
		    		</div>
		    		<div style="float: left; margin-left: 10px;">
			    		<div id="bowNum6" style="float: left; width: 120px; text-align: center;">-</div>
		    		</div>
		    	</div>
	    	</div>
    	</div>
		<div style="float: left; min-height: 75px; width: 100%;">
			<div style="float: left; width: 100%;">
		    	<div style="width: 100%; float: left; font-size: 23px; color: white; margin-left: 47px; font-weight: bold;">
		    		<div style="float: left;">
			    		<div style="float: left;">Start time : </div>
		    			<div style="float: left; min-width: 60px; margin-left: 5px;" id="racestart_time"></div>
		    		</div>
		    		<div style="float: left; margin-left: 10px;">
			    		<div style="float: left;">/ Event : </div>
		    			<div style="float: left; min-width: 60px; margin-left: 5px;" id="event_name"></div>
		    		</div>
		    		<div style="float: left; margin-left: 10px;">
			    		<div style="float: left;">/ Round : </div>
		    			<div style="float: left; min-width: 60px; margin-left: 5px;" id="roundName"></div>
		    		</div>
		    	</div>
			</div>
	    	<div style="width: 100%; float: left; font-size: 23px; color: white; margin-left: 47px; font-weight: bold;">
	    		<div style="float: left;">
		    		<div style="float: left;">Progression : </div>
		    		<div id="prog" style="float: left; margin-left: 5px;"></div>
	    		</div>
	    		<div style="float: left; margin-left: 10px;">
			    	<div style="float: left;">/ Finish time : </div>
		    		<div style="float: left; min-width: 60px; margin-left: 5px;" id="racefinish_time"></div>
		    	</div>
	    	</div>
		</div>
    	<div style="margin-bottom: 30px;">
    		<div style="display: inline-block; margin-left: 47px;">
	            <table id="raceRecord500" cellpadding="12" style="float: left; width: 300px;">
	                <tr>
	                    <th colspan="3" style="text-align: center; width: 180px;">500 m</th>
	                </tr>
	                <tr>
	                    <td class="bow_num">1</td>
	                    <td id="raceRecord500_1">00:00:00.00</td>
	                    <td id="rank500_1">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">2</td>
	                    <td id="raceRecord500_2">00:00:00.00</td>
	                    <td id="rank500_2">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">3</td>
	                    <td id="raceRecord500_3">00:00:00.00</td>
	                    <td id="rank500_3">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">4</td>
	                    <td id="raceRecord500_4">00:00:00.00</td>
	                    <td id="rank500_4">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">5</td>
	                    <td id="raceRecord500_5">00:00:00.00</td>
	                    <td id="rank500_5">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">6</td>
	                    <td id="raceRecord500_6">00:00:00.00</td>
	                    <td id="rank500_6">(-)</td>
	                </tr>
	            </table>
	            <table id="raceRecord1000" cellpadding="12" style="float: left; margin-left: 5px; width: 300px;">
	                <tr>
	                    <th colspan="3" style="text-align: center; width: 180px;">1000 m</th>
	                </tr>
	                <tr>
	                    <td class="bow_num">1</td>
	                    <td id="raceRecord1000_1">00:00:00.00</td>
	                    <td id="rank1000_1">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">2</td>
	                    <td id="raceRecord1000_2">00:00:00.00</td>
	                    <td id="rank1000_2">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">3</td>
	                    <td id="raceRecord1000_3">00:00:00.00</td>
	                    <td id="rank1000_3">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">4</td>
	                    <td id="raceRecord1000_4">00:00:00.00</td>
	                    <td id="rank1000_4">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">5</td>
	                    <td id="raceRecord1000_5">00:00:00.00</td>
	                    <td id="rank1000_5">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">6</td>
	                    <td id="raceRecord1000_6">00:00:00.00</td>
	                    <td id="rank1000_6">(-)</td>
	                </tr>
	            </table>
	            <table id="raceRecord1500" cellpadding="12" style="float: left; margin-left: 5px; width: 300px;">
	                <tr>
	                    <th colspan="3" style="text-align: center; width: 180px;">1500 m</th>
	                </tr>
	                <tr>
	                    <td class="bow_num">1</td>
	                    <td id="raceRecord1500_1">00:00:00.00</td>
	                    <td id="rank1500_1">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">2</td>
	                    <td id="raceRecord1500_2">00:00:00.00</td>
	                    <td id="rank1500_2">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">3</td>
	                    <td id="raceRecord1500_3">00:00:00.00</td>
	                    <td id="rank1500_3">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">4</td>
	                    <td id="raceRecord1500_4">00:00:00.00</td>
	                    <td id="rank1500_4">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">5</td>
	                    <td id="raceRecord1500_5">00:00:00.00</td>
	                    <td id="rank1500_5">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">6</td>
	                    <td id="raceRecord1500_6">00:00:00.00</td>
	                    <td id="rank1500_6">(-)</td>
	                </tr>
	            </table>
	            <table id="raceRecord2000" cellpadding="12" style="float: left; margin-left: 5px; width: 300px;">
	                <tr>
	                    <th colspan="3" style="text-align: center; width: 180px;">2000 m</th>
	                </tr>
	                <tr>
	                    <td class="bow_num">1</td>
	                    <td id="raceRecord2000_1">00:00:00.00</td>
	                    <td id="rank2000_1">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">2</td>
	                    <td id="raceRecord2000_2">00:00:00.00</td>
	                    <td id="rank2000_2">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">3</td>
	                    <td id="raceRecord2000_3">00:00:00.00</td>
	                    <td id="rank2000_3">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">4</td>
	                    <td id="raceRecord2000_4">00:00:00.00</td>
	                    <td id="rank2000_4">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">5</td>
	                    <td id="raceRecord2000_5">00:00:00.00</td>
	                    <td id="rank2000_5">(-)</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">6</td>
	                    <td id="raceRecord2000_6">00:00:00.00</td>
	                    <td id="rank2000_6">(-)</td>
	                </tr>
	            </table>
	            <table id="rankArea" cellpadding="12" style="float: left; margin-left: 5px; width: 355px;">
	                <tr>
	                    <th colspan="3" style="text-align: center; width: 180px;">Rank</th>
	                </tr>
	                <tr>
	                    <td class="bow_num">1</td>
	                    <td id="1rankTeamName">-</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">2</td>
	                    <td id="2rankTeamName">-</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">3</td>
	                    <td id="3rankTeamName">-</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">4</td>
	                    <td id="4rankTeamName">-</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">5</td>
	                    <td id="5rankTeamName">-</td>
	                </tr>
	                <tr>
	                    <td class="bow_num">6</td>
	                    <td id="6rankTeamName">-</td>
	                </tr>
	            </table>
	        </div>
    	</div>
    </div>
</body>
</html>
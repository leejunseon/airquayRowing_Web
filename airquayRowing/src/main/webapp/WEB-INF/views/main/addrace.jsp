<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Airquay rowing management system</title>
<link type="text/css" rel="stylesheet" href="http://13.209.161.83:8080/airquayRowing/resources/css/rowingCommon.css?ver=2">
<link type="text/css" rel="stylesheet" href="http://13.209.161.83:8080/airquayRowing/resources/css/rowingAddrace.css?ver=2">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css?ver=2">

<script src="http://13.209.161.83:8080/airquayRowing/resources/js/rowingCommon.js?ver=2"></script>
<script src="https://code.jquery.com/jquery-3.0.0.min.js?ver=2"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js?ver=2"></script>
<script type="text/javascript">

$(document).ready(function() {
	doResize();
	dispSignupPage();
});

function doResize(){
	var windowHeight = $(window).height();
	var headerAreaHeight = $("#headerArea").height();
	var bottomAreaHeight = $("#bottomArea").height();
	$("#bodyArea").css("height", windowHeight-headerAreaHeight-bottomAreaHeight);
	//$("#bodyArea",parent.document).css("height",776)//임시방편
}
function dispSignupPage(){
	$("#bodyArea").css("display", "block");
}
function addrace(){
	var json_data = "event_name="+($("#event_name").val());
		json_data += "&year="+($("#year").val());
		json_data += "&month="+($("#month").val());
		json_data += "&day="+($("#day").val());
		json_data += "&round_type="+($("#round_type").val());
		json_data += "&progression="+($("#progression").val());
		json_data += "&LaneOne="+($("#LaneOne").val());
		json_data += "&LaneTwo="+($("#LaneTwo").val());
		json_data += "&LaneThree="+($("#LaneThree").val());
		json_data += "&LaneFour="+($("#LaneFour").val());
		json_data += "&LaneFive="+($("#LaneFive").val());
		json_data += "&LaneSix="+($("#LaneSix").val());
	var url = 'http://13.209.161.83:8080/airquayRowing/main/addRace';
	console.log("addUser")
	$.ajax({
		url:url,
		type : 'GET',
		cache: false,
		contentType: false,
		processData: false,
		data : json_data,
		success : function(data){		
			resultAddrace(true);
		},
		error : function(data){
			resultAddrace(false);
		}
	});
}
function resultAddrace(data){
	/* var innerHtml = "";
	if(data==true){
		innerHtml = "<iframe src='http://13.209.161.83:8080/airquayRowing/afteraddrace' style='width: 100%; height: 100%; border: none;'></iframe>"
			$("#bodyArea").empty();
			$("#bodyArea").append(innerHtml)
			$("#bodyArea").css("display", "block");
	}else{
		alert("Fill in all the contents");
	} */
	location.href="select";
}
</script>
</head>

<body style="margin: 0px; background-color: #3e6699; overflow: hidden;">
	<div id="headerArea">
		<div id="titleArea">Rowing Management System</div>
	</div>
	<div id="bodyArea" style="display: none;">
	<img alt="" id="LoginImage" src="http://13.209.161.83:8080/airquayRowing/resources/img/main_visual_01.jpg" style="width:100%;">
		<div id="addraceArea">
			<div style="float: left; width: 100%; height: 50px; font-size: 30px; text-indent: 30px; font-weight: bold; margin-top: 20px;">Race info</div>
			<div style="float: left; width: 100%;">
				<div style="float: left; width: 65%;">
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Event name</div>
						<div class="inputText"><input id="event_name" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Year</div>
						<div class="inputText"><input id="year" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Month</div>
						<div class="inputText"><input id="month" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Day</div>
						<div class="inputText"><input id="day" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Round type</div>
						<div class="inputText"><input id="round_type" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Progression</div>
						<div class="inputText"><input id="progression" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Lane 1</div>
						<div class="inputText"><input id="LaneOne" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Lane 2</div>
						<div class="inputText"><input id="LaneTwo" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Lane 3</div>
						<div class="inputText"><input id="LaneThree" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Lane 4</div>
						<div class="inputText"><input id="LaneFour" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Lane 5</div>
						<div class="inputText"><input id="LaneFive" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="raceLabel">Lane 6</div>
						<div class="inputText"><input id="LaneSix" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
				</div>
				<div style="float: left;" onclick="javascript:addrace();">
					<div id="SignupBtn">Submit</div>
				</div>
			</div>
		</div>
	</div>
	<div id="bottomArea"></div>
</body>
</html>

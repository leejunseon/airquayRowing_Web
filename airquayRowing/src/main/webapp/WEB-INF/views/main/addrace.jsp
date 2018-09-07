<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Airquay rowing management system</title>
<link type="text/css" rel="stylesheet" href="http://localhost:8080/airquayRowing/resources/css/rowingCommon.css?ver=1">
<link type="text/css" rel="stylesheet" href="http://localhost:8080/airquayRowing/resources/css/rowingAddrace.css?ver=1">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css?ver=1">

<script src="http://localhost:8080/airquayRowing/resources/js/rowingCommon.js?ver=1"></script>
<script src="https://code.jquery.com/jquery-3.0.0.min.js?ver=1"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js?ver=1"></script>
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
}
function dispSignupPage(){
	$("#bodyArea").css("display", "block");
}
function adduser(){
	var json_data = "user_id="+($("#user_id").val());
		json_data += "&user_pw="+($("#user_pw").val());
		json_data += "&user_name="+($("#user_name").val());
		json_data += "&sex="+($("#sex").val());
		json_data += "&birthday="+($("#birthday").val());
		json_data += "&nationality="+($("#nationality").val());
		json_data += "&team_num="+($("#team_num").val());
	var url = 'http://localhost:8080/airquayRowing/main/addUser';
	console.log("addUser")
	$.ajax({
		url:url,
		type : 'GET',
		cache: false,
		contentType: false,
		processData: false,
		data : json_data,
		success : function(data){		
			resultSignup(true);
		},
		error : function(data){
			resultSignup(false);
		}
	});
}
function resultSignup(data){
	var innerHtml = "";
	if(data==true){
		innerHtml = "<iframe src='http://localhost:8080/airquayRowing/aftersignup' style='width: 100%; height: 100%; border: none;'></iframe>"
			$("#bodyArea").empty();
			$("#bodyArea").append(innerHtml)
			$("#bodyArea").css("display", "block");
	}else{
		alert("Fill in all the contents");
	}
}
</script>
</head>

<body style="margin: 0px; background-color: #3e6699; overflow: hidden;">
	<div id="bodyArea" style="display: none;">
	<img alt="" id="LoginImage" src="http://localhost:8080/airquayRowing/resources/img/main_visual_01.jpg" style="width:100%;">
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
						<div class="inputText"><input id="year" type="password" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
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
				<div style="float: left;" onclick="javascript:adduser();">
					<div id="SignupBtn">Submit</div>
				</div>
			</div>
		</div>
	</div>
	<div id="bottomArea"></div>
</body>
</html>

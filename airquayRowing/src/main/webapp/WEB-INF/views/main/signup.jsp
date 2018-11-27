<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Airquay rowing management system</title>
<link type="text/css" rel="stylesheet" href="http://localhost:8080/airquayRowing/resources/css/rowingCommon.css?ver=1">
<link type="text/css" rel="stylesheet" href="http://localhost:8080/airquayRowing/resources/css/rowingSignup.css?ver=1">
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
	var windowHeight = $(window,parent.Document).height();
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
			alert("Fill in all the contents");
		}
	});
}
function resultSignup(data){
	/* var innerHtml = "";
	if(data==true){
		innerHtml = "<iframe src='http://localhost:8080/airquayRowing/aftersignup' style='width: 100%; height: 100%; border: none;'></iframe>"
			$("#bodyArea").empty();
			$("#bodyArea").append(innerHtml)
			$("#bodyArea").css("display", "block");
	}else{
		alert("Fill in all the contents");
	} */
	
	location.href="main";
}
</script>
</head>

<body style="margin: 0px; background-color: #3e6699; overflow: hidden;">
	<div id="headerArea">
		<div id="titleArea">Rowing Management System</div>
	</div>
	<div id="bodyArea" style="display: none;">
	<img alt="" id="LoginImage" src="http://localhost:8080/airquayRowing/resources/img/main_visual_01.jpg" style="width:100%;">
		<div id="SignupArea">
			<div style="float: left; width: 100%; height: 50px; font-size: 30px; text-indent: 30px; font-weight: bold; margin-top: 20px;">Sign Up</div>
			<div style="float: left; width: 100%;">
				<div style="float: left; width: 65%;">
					<div style="float: left; width: 100%; height: 50px;">
						<div class="loginLabel">ID</div>
						<div class="inputText"><input id="user_id" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="loginLabel">PW</div>
						<div class="inputText"><input id="user_pw" type="password" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="loginLabel">Name</div>
						<div class="inputText"><input id="user_name" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="loginLabel">sex</div>
						<div class="inputText"><input id="sex" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="loginLabel">Birthday</div>
						<div class="inputText"><input id="birthday" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="loginLabel">Nationality</div>
						<div class="inputText"><input id="nationality" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
					<div style="float: left; width: 100%; height: 50px;">
						<div class="loginLabel">TeamNum</div>
						<div class="inputText"><input id="team_num" type="text" style="width: 100%; height: 100%;" onKeyDown="if(event.keyCode==13) {login();}"/></div>
					</div>
				</div>
				<div style="float: left;" onclick="javascript:adduser();">
					<div id="SignupBtn">Sign up</div>
				</div>
			</div>
		</div>
	</div>
	<div id="bottomArea"></div>
</body>
</html>

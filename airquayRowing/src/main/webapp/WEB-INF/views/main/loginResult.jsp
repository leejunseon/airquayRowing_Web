<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Airquay rowing management system</title>
<link type="text/css" rel="stylesheet" href="http://localhost:8080/airquayRowing/resources/css/rowingCommon.css?ver=2">
<link type="text/css" rel="stylesheet" href="http://localhost:8080/airquayRowing/resources/css/rowingLogin.css?ver=2">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css?ver=2">

<script src="http://localhost:8080/airquayRowing/resources/js/rowingCommon.js?ver=2"></script>
<script src="https://code.jquery.com/jquery-3.0.0.min.js?ver=2"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js?ver=2"></script>
<script type="text/javascript">
var loginCheck;

$(document).ready(function() {
	loginCheck = "${loginCheck}";
	console.log("loginCheck : "+loginCheck)
	doResize();
	dispLoginPage();
});

function doResize(){
	/* var windowHeight = $(window).height();
	var headerAreaHeight = $("#headerArea").height();
	var bottomAreaHeight = $("#bottomArea").height();
	$("#bodyArea").css("height", windowHeight-headerAreaHeight-bottomAreaHeight); */
	$("#bodyArea",parent.document).css("height",800)//임시방편
}
function dispLoginPage(){
	if(loginCheck=="true"){
		resultLogin(true);
	}else{
		$("#bodyArea").css("display", "block");
	}
}
function login(){
	var json_data = "user_id="+($("#user_id").val());
		json_data += "&user_pw="+($("#user_pw").val());
	var url = 'http://localhost:8080/airquayRowing/login';
	console.log("login")
	$.ajax({
		url:url,
		type : 'GET',
		cache: false,
		contentType: false,
		processData: false,
		data : json_data,
		dataType : 'json',
		success : function(data){
			resultLogin(data[1]);
			userInfo=data[0];			
		},
		error : function(data){
		}//data에 controller의 /login의 리턴값 저장됨.
	});
}
function signup(){
	var innerHtml="";
	innerHtml = "<iframe src='http://localhost:8080/airquayRowing/signup' style='width: 100%; height: 100%; border: none;'></iframe>"
	$("#bodyArea").empty();
	$("#bodyArea").append(innerHtml)
	$("#bodyArea").css("display", "block");
}
function resultLogin(data){
	var innerHtml = "";
	if(data==true){
		innerHtml = "<iframe src='http://localhost:8080/airquayRowing/select' style='width: 100%; height: 100%; border: none;'></iframe>"
			$("#bodyArea").empty();
			$("#bodyArea").append(innerHtml)
			$("#bodyArea").css("display", "block");
	}else{
		alert("Please check ID or Password");
	}
}
</script>
</head>

<body style="margin: 0px; background-color: #3e6699; overflow: hidden;">
	<div id="bodyArea" style="display: none;">
		<img alt="" id="LoginImage" src="http://localhost:8080/airquayRowing/resources/img/main_visual_01.jpg" style="width:100%;">
		<div id="loginArea">
			<div style="float: left; width: 100%; height: 50px; font-size: 30px; text-indent: 30px; font-weight: bold; margin-top: 20px;">Login</div>
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
				</div>
				<div style="float: left;" onclick="javascript:login();">
					<div id="loginBtn">Login</div>
				</div>
			</div>
			<div style="float: left; width: 100%;">
				<div style="float: left; color: #5b87bd; font-size: 13px; margin-left: 100px; cursor: pointer;"onclick="javascript:signup();">Sign Up</div>
				<div style="float: left; color: #5b87bd; font-size: 13px; margin-left: 15px;">/</div>
				<div style="float: left; color: #5b87bd; font-size: 13px; margin-left: 15px; cursor: pointer;">Find ID</div>
				<div style="float: left; color: #5b87bd; font-size: 13px; margin-left: 15px;">/</div>
				<div style="float: left; color: #5b87bd; font-size: 13px; margin-left: 15px; cursor: pointer;">Find PW</div>
			</div>
		</div>
	</div>
	<div id="bottomArea"></div>
</body>
</html>

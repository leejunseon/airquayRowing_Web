<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Rowing Airquay</title>
<link type="text/css" rel="stylesheet" href="http://localhost:8080/airquayRowing/resources/css/rowingCommon.css?ver=2">
<link type="text/css" rel="stylesheet" href="http://localhost:8080/airquayRowing/resources/css/rowingRecordview.css?ver=2">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css?ver=2">
<script src="http://localhost:8080/airquayRowing/resources/js/rowingCommon.js?ver=2"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js?ver=2"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js?ver=2"></script>
<script type="text/javascript">
	var teamInfo;
	var Records;
	
	$(document).ready(function() {
		doResize();
		common.getTeamInfo();
	});
	
function doResize(){
	var windowWidth = $(window).width();
	if(windowWidth>1680){
		$("#bodyArea").css("margin-left", (windowWidth-1676)/2)
	}
	//$("#bodyArea",parent.document).css("height",776)//임시방편
}

</script>
</head>

<body id="bodyArea"style="margin: 0px; background-color: #3e6699; overflow: hidden;">
	<div id="headerArea">
		<div id="titleArea">Rowing Management System</div>
	</div>
    <div class="container" style="width: 100%; height: 35px; line-height: 35px; font-size: 25px; margin-top: 10px; float: left;">
    	<div style="float: left; height: 35px; background-color: white; border: 1px solid;">
    		<select id="teams" style="font-size: 25px; background-color: white; color: black; margin-top: 3px; border: 0px;">
    			<option value="-">No data</option>
    		</select>
    	</div>
    	<input type="button"value="조회"style="font-size:20px;float: right; margin-right:80px;width:100px;height: 50px;"onclick="javascript:common.displayRecord();"/>
    </div>
    <div id="records"style="font-size:25px; color:white;float: left; border: 1px solid white; margin-top: 20px; width: 1675px;">
   		<div style="margin-bottom: 30px; margin-top:30px;">
   			<div style="margin-left:67px; float: left; width: 380px; text-align: center;">-- Info --</div>
   			<div style="margin-left:43px; float: left; width: 200px; text-align: center;">-- 500m --</div>
   			<div style="margin-left:43px; float: left; width: 200px; text-align: center;">-- 1000m --</div>
   			<div style="margin-left:43px; float: left; width: 200px; text-align: center;">-- 1500m --</div>
   			<div style="margin-left:43px; float: left; width: 200px; text-align: center;">-- Finish --</div>
   		 	<div style="margin-left:43px; float: left; width: 150px; text-align: center;">-- Rank --</div>
   		
    		<div style="display: inline-block; margin-top: 20px; margin-left: 47px;">
    			<div id="recordinfo" style="padding:20px;float: left;text-align:center; width: 380px;border:white 1px solid">
    			</div>
	            <div id="record500" style="padding:20px;float: left;text-align:center; width: 200px;border:white 1px solid">
	     	    </div>
	    		<div id="record1000" style="padding:20px;float: left;text-align:center; width: 200px;border:white 1px solid">
	     	    </div>
	     	    <div id="record1500" style="padding:20px;float: left;text-align:center; width: 200px;border:white 1px solid">
	     	    </div>
	     	    <div id="finish" style="padding:20px;float: left;text-align:center; width: 200px;border:white 1px solid">
	     	    </div>
	     	     <div id="rank" style="padding:20px;float: left;text-align:center; width: 150px;border:white 1px solid">
	     	    </div>
	        </div>
    	</div>
    </div>
</body>
</html>
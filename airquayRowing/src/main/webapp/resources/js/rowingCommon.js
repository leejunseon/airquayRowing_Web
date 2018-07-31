var common={
		
	RacePoling : function(){
		console.log("Race poling, raceInfo : "+raceInfo)
		if(raceInfo != undefined){
			console.log("poling status: "+polingStatus)
			if(polingStatus=="start"){
				common.startPoling();
			}else{
				common.beforeStartPolling();
			}
		}else{
			common.getRaceInfo();
		}
	},
	
	startPoling : function(){
		console.log("startPoling");
		var json_data = "raceNum="+($("#infrontRaceNum").val()+1);
		var url = 'http://localhost:8080/airquayRowing/main/raceStartPoling';//onoff 값 확인
		$.ajax({
			url:url,
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
			success : function(data){
				if(data==1){//onoff가 1이면
					console.log("data = "+data)
					common.onOffinish_timer(data);
					polingStatus = "500m";
				}else if(data==2){//onoff가 2이면
					console.log("data = "+data)
					common.onOffinish_timer(data);
				}
				else{//onoff가 0이면
					console.log("data = "+data)
					common.onOffinish_timer(data);
				}
			},
			error : function(data){
			}
		});
	},
	
	beforeStartPolling : function(){
		console.log("beforeStartPolling")
		var json_data = "raceNum="+($("#infrontRaceNum").val()+1)+"&";
		if(polingStatus=="500m"){
			json_data += "orderType=finish_time";
		}else if(polingStatus=="1000m"){
			json_data += "orderType=hTime";
		}else if(polingStatus=="1500m"){
			json_data += "orderType=hfinish_time";
		}else if(polingStatus=="finish"){
			json_data += "orderType=finishTime";
		}
		console.log("json_data : "+json_data);
		
		var url = 'http://localhost:8080/airquayRowing/main/beforeStartPolling';
		$.ajax({
			url:url,
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
			success : function(data){
				common.dispRank(data);
			},
			error : function(data){
			}
		});
	},
	
	dispRank : function(rankList){
		console.log("dispRank")
		var dispRankCnt = 0;
		if(polingStatus=="500m"){
			for(var i=0; i<rankList.length; i++){
				if(rankList[i].finish_time!=null){
					$("#raceRecord500_"+rankList[i].bowNum).text(rankList[i].finish_time);
					$("#rank500_"+rankList[i].bowNum).text("("+(i+1)+")");
					dispRankCnt++;
				}
			}
			if(dispRankCnt == 6){
				polingStatus = "1000m";
			}
		}else if(polingStatus=="1000m"){
			for(var i=0; i<rankList.length; i++){
				if(rankList[i].hTime!=null){
					$("#raceRecord1000_"+rankList[i].bowNum).text(rankList[i].hTime);
					$("#rank1000_"+rankList[i].bowNum).text("("+(i+1)+")");
					dispRankCnt++;
				}
			}
			if(dispRankCnt == 6){
				polingStatus = "1500m";
			}
		}else if(polingStatus=="1500m"){
			for(var i=0; i<rankList.length; i++){
				if(rankList[i].fhTime!=null){
					$("#raceRecord1500_"+rankList[i].bowNum).text(rankList[i].fhTime);
					$("#rank1500_"+rankList[i].bowNum).text("("+(i+1)+")");
					dispRankCnt++;
				}
			}
			if(dispRankCnt == 6){
				polingStatus = "finish";
			}
		}else if(polingStatus=="finish"){
			for(var i=0; i<rankList.length; i++){
				if(rankList[i].finishTime!=null){
					$("#raceRecord2000_"+rankList[i].bowNum).text(rankList[i].finishTime);
					$("#rank2000_"+rankList[i].bowNum).text("("+(i+1)+")");
					dispRankCnt++;
				}
			}
			if(dispRankCnt == 6){
				polingStatus = "start";
			}
		}
	},
	
	getRaceInfo : function(){
		console.log("getRaceInfo")
		var json_data = "raceDate="+$("#toDay").text();//toDay를 raceDate파라미터로 넘김
		$.ajax({
			url:'http://localhost:8080/airquayRowing/main/getRaceInfo',
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
			success : function(data){
				console.log("getRaceInfo Success")
				if(data.length>0){
					raceInfo = data;
					common.dispRaceList();
				}
			},
			error : function(data){
				console.log("getRaceInfo error")
			}
		});
	},
	
	getBowInfo : function(){
		console.log("getBowInfo")
		var json_data = "raceNum="+($("#infrontRaceNum").val()+1);
		$.ajax({
			url:'http://localhost:8080/airquayRowing/main/getBowInfo',
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
			success : function(data){
				console.log("getBowInfo success")
				if(data.length>0){
					bowInfo = data;
					common.dispBowList();
				}else{
					$("#bowNum1").text("-");
					$("#bowNum2").text("-");
					$("#bowNum3").text("-");
					$("#bowNum4").text("-");
					$("#bowNum5").text("-");
					$("#bowNum6").text("-");
				}
			},
			error : function(data){
				console.log("getBowInfo error")
			}
		});
	},
	
	dispBowList : function(){
		console.log("dispBowList")
		if(bowInfo.length>0){
			for(var i=0; i<bowInfo.length; i++){
				for(var j=0; j<6; j++){
					if(j==(bowInfo[i].bowNum-1)){
						$("#bowNum"+(j+1)).text(bowInfo[i].teamName);
					}
				}
			}
			polingStatus = "start";
		}else{
			$("#bowNum1").text("-");
			$("#bowNum2").text("-");
			$("#bowNum3").text("-");
			$("#bowNum4").text("-");
			$("#bowNum5").text("-");
			$("#bowNum6").text("-");
		}

	},
	
	dispRaceList : function(){
		console.log("dispRaceList")
		var innerHtml = "";
		for(var i=0; i<raceInfo.length; i++){
			innerHtml += "<option value="+i+"> Race "+raceInfo[i].raceNum+"</option>"
		}
		$("#infrontRaceNum").empty().append(innerHtml);
		common.dispRaceInfo();
		common.getBowInfo();
	},
	
	dispRaceInfo : function(){
		console.log("dispRaceInfo")
		var raceNum = $("#infrontRaceNum").val();
		if(raceInfo[raceNum].startTime == null){
			$("#raceStartTime").text("Not started yet.");
		}else{
			$("#raceStartTime").text(raceInfo[raceNum].startTime);
		}
		$("#eventName").text(raceInfo[raceNum].eventName);
		$("#roundName").text(raceInfo[raceNum].roundType);
		$("#prog").text(raceInfo[raceNum].progression);
	},
	
	refresh : function(){
		$("#watchtime").text("00:00:00.00");
	},
	
	onOffinish_timer : function(num){
		console.log("onOffinish_timer, num : "+num)
		if (num==1) {
			common.start(false);
			flag=1;
		}else if(num==2){
			common.start(true);
			flag=2;
		}else{
			common.stop();
			flag=0;
			common.PastTimeReceive();
		}
	},
	
	process : function(){
		var now = new Date();
		var nowTime = now.getTime();
		var time = nowTime - startTime;
		common.showTime(time);
	},
	
	showTime : function(time){
		var totalsec = parseInt(time / 1000, 10);
		var tinysec = time % 100;
		if(tinysec < 10){
			tinysec += ""+tinysec;
		}
		var totalmin = parseInt(totalsec / 60, 10);
		var sec = totalsec % 60;
		var hour = parseInt(totalmin / 60, 10);
		var min = totalmin % 60;
		output = leadingZeros(hour,2) + ":" + leadingZeros(min,2) + ":" + leadingZeros(sec,2) + "." + tinysec;
		$("#watchtime").text(output)
	},
	
	start : function(twoYn){
		console.log("start, twoYn : "+twoYn)
		var now = new Date();
		if(twoYn==true){
			$("#raceStatus").text("Two minutes");
			$("#raceStatus").css("background-color", "#FF0000");
		}else{
			startTime = now.getTime();
			stopwatch = setInterval(common.process, 10);
			$("#raceStatus").text("경기중");
			$("#raceStatus").css("background-color", "#FF0000");
			count = 0;
		}

	},
	
	stop : function(){
		console.log("stop")
		clearInterval(stopwatch);
		$("#raceStatus").text("경기종료");
		$("#raceStatus").css("background-color", "#969696");
	},
	
	PastTimeReceive : function(){
		console.log("PastTimeReceive")
		$.ajax({
			url:'http://localhost:8080/airquayRowing/main/passTimer',
			type : 'POST',
			cache: false,
			contentType: false,
			processData: false,
			success : function(data){
				var time = data[0].pastHour +":"+ data[0].pastMinute +":"+ data[0].pastSecond +"."+ data[0].pastMiliSecond
		       $("#watchtime").val(time);
			}
		});
	},
	
}
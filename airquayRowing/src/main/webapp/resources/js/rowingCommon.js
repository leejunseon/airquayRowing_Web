var common={
	
	//onoff값 확인
	RacePoling : function(){
		console.log("Race poling, raceInfo : "+raceInfo)
		if(raceInfo != undefined){
			var json_data = "race_num="+(Number($("#infrontrace_num").val())+1);
			var url = 'http://localhost:8080/airquayRowing/main/raceStartPoling';
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
						if(flag!=1)
						{
							console.log("data = "+data)
							common.starttimeSend();
							common.onOffinish_timer(data);
							polingStatus = "500m";
						}
					}else if(data==2){//onoff가 2이면
						console.log("data = "+data)
						common.onOffinish_timer(data);
					}
					else if(data==3){
						console.log("data = "+data)
						common.onOffinish_timer(data);
					}
					else if(data==4){//reset, 다음경기
						console.log("data="+data)
						common.refresh();
					}
					else{//onoff가 0이면
						console.log("data = "+data)
						if(flag!=0)
							common.finishtimeSend();
						common.onOffinish_timer(data);
					}
				},
				error : function(data){
				}
			});
		}else{
			common.getRaceInfo();
		}
	},
	
	//경기 시작시간 데이터베이스에 업로드
	starttimeSend : function(){
		console.log("starttimeSend")
		var json_data="start_time="+($("#time").text())+"&";
		json_data+="race_num="+($("#infrontrace_num").val()+1);
		
		var url = 'http://localhost:8080/airquayRowing/main/startTimeSend';
		$.ajax({
			url:url,
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
			success : function(data){
				$("#racestart_time").text($("#time").text());
			},
			error : function(data){
			}
		});
	},
	
	//경기 끝난 시간 데이터베이스에 업로드
	finishtimeSend : function(){
		console.log("finishtimeSend")
		var json_data="stop_time="+($("#time").text())+"&";
		json_data+="race_num="+($("#infrontrace_num").val()+1);
		
		var url = 'http://localhost:8080/airquayRowing/main/finishTimeSend';
		$.ajax({
			url:url,
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
			success : function(data){
				$("#racefinish_time").text($("#time").text());
			},
			error : function(data){
			}
		});
	},
	
	//bowinfo 가져옴
	beforeStartPolling : function(){
		console.log("beforeStartPolling")
		var json_data = "race_num="+($("#infrontrace_num").val()+1)+"&";
		if(polingStatus=="500m"){
			json_data += "orderType=fivehundred_time";
		}else if(polingStatus=="1000m"){
			json_data += "orderType=thousand_time";
		}else if(polingStatus=="1500m"){
			json_data += "orderType=thousandfivehundred_time";
		}else if(polingStatus=="finish"){
			json_data += "orderType=finish_time";
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
	
	//랭크 화면에 출력
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
				if(rankList[i].Fivehundred_Time!=null){
					$("#raceRecord1000_"+rankList[i].bowNum).text(rankList[i].Fivehundred_Time);
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
	
	//경기정보 가져옴
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
	
	//bowinfo 가져옴
	getBowInfo : function(){
		console.log("getBowInfo")
		var json_data = "race_num="+($("#infrontrace_num").val()+1);
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
	
	//bowlist 화면에 출력
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
	
	//race번호 출력
	dispRaceList : function(){
		console.log("dispRaceList")
		var innerHtml = "";
		for(var i=0; i<raceInfo.length; i++){
			innerHtml += "<option value="+i+"> Race "+raceInfo[i].race_num+"</option>"
		}
		$("#infrontrace_num").empty().append(innerHtml);
		common.dispRaceInfo();
		common.getBowInfo();
	},
	
	//경기정보 출력
	dispRaceInfo : function(){
		console.log("dispRaceInfo")
		var race_num = $("#infrontrace_num").val();
		if(raceInfo[race_num].start_time == null){
			$("#racestart_time").text("Not started yet.");
		}else{
			$("#racestart_time").text(raceInfo[race_num].start_time);
		}
		if(raceInfo[race_num].stop_time==null){
			$("#racefinish_time").text("Not finished yet.");
		}else{
			$("#racefinish_time").text(raceInfo[race_num].stop_time);
		}
		$("#event_name").text(raceInfo[race_num].event_name);
		$("#roundName").text(raceInfo[race_num].round_type);
		$("#prog").text(raceInfo[race_num].progression);
	},
	
	refresh : function(){
		$("#watchtime").text("00:00:00.00");
	},
	
	//타이머 제어
	onOffinish_timer : function(num){
		console.log("onOffinish_timer, num : "+num)
		if (num==1) {//시작
			common.start(1);
			flag=1;
		}else if(num==2){//2분선
			common.start(2);
			flag=2;
		}
		else if(num==3){//false 
			common.stop(3);
			flag=3;
			common.PastTimeReceive();
		}
		else{//종료
			common.stop(0);
			flag=0;
			common.PastTimeReceive();
		}
	},
	
	process : function(){
		var now = new Date();
		var nowTime = now.getTime();
		var time = nowTime - start_time;
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
	
	start : function(num){
		console.log("start, twoYn : "+num)
		var now = new Date();
		if(num==2){
			$("#raceStatus").text("2 분전");
			$("#raceStatus").css("background-color", "#FF0000");
		}else if(num==1){
			start_time = now.getTime();
			stopwatch = setInterval(common.process, 10);
			$("#raceStatus").text("경기중");
			$("#raceStatus").css("background-color", "#FF0000");
			count = 0;
		}
	},
	
	stop : function(num){
		if(num==0){
			console.log("stop(0)")
			clearInterval(stopwatch);
			$("#raceStatus").text("경기종료");
			$("#raceStatus").css("background-color", "#969696");
		}
		else if(num==3){
			console.log("stop(3)")
			clearInterval(stopwatch);
			$("#raceStatus").text("대기");
			$("#raceStatus").css("background-color", "#969696");
		}
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
				
				if(data[0].pastHour<10)
					data[0].pastHour="0"+data[0].pastHour;
				if(data[0].pastMinute<10)
					data[0].pastMinute="0"+data[0].pastMinute;
				if(data[0].pastSecond<10)
					data[0].pastSecond="0"+data[0].pastSecond;
				if(data[0].pastMiliSecond<10)
					data[0].pastMiliSecond="0"+data[0].pastMiliSecond;
				
				var time = data[0].pastHour +":"+ data[0].pastMinute +":"+ data[0].pastSecond +"."+ data[0].pastMiliSecond
		       $("#watchtime").text(time);
			}
		});
	},
}
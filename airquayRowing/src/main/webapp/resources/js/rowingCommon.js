var common={
	
	//onoff값 확인
	RacePoling : function(){
		console.log("Race poling, raceInfo : "+raceInfo)
		common.beforeStartPolling();
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
							common.onOffinish_timer(data);
							//polingStatus = "500m";
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

	
	//bowinfo 가져옴
	beforeStartPolling : function(){
		console.log("beforeStartPolling")
		var json_data = "race_num="+(Number($("#infrontrace_num").val())+1);
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
		
		for(var i=0; i<rankList.length; i++){
			if(rankList[i].fivehundred_time!=null)
				$("#raceRecord500_"+rankList[i].bow_num).text(rankList[i].fivehundred_time);
			else
				$("#raceRecord500_"+rankList[i].bow_num).text("00:00:00.00");
			if(rankList[i].fivehundred_rank!=null)
				$("#rank500_"+rankList[i].bow_num).text(rankList[i].fivehundred_rank);
			else
				$("#rank500_"+rankList[i].bow_num).text("-");
			if(rankList[i].thousand_time!=null)
				$("#raceRecord1000_"+rankList[i].bow_num).text(rankList[i].thousand_time);
			else
				$("#raceRecord1000_"+rankList[i].bow_num).text("00:00:00.00");
			if(rankList[i].thousand_rank!=null)
				$("#rank1000_"+rankList[i].bow_num).text(rankList[i].thousand_rank);
			else
				$("#rank1000_"+rankList[i].bow_num).text("-");
			if(rankList[i].thousandfivehundred_time!=null)
				$("#raceRecord1500_"+rankList[i].bow_num).text(rankList[i].thousandfivehundred_time);
			else
				$("#raceRecord1500_"+rankList[i].bow_num).text("00:00:00.00");
			if(rankList[i].thousandfivehundred_rank!=null)
				$("#rank1500_"+rankList[i].bow_num).text(rankList[i].thousandfivehundred_rank);
			else
				$("#rank1500_"+rankList[i].bow_num).text("-");
			if(rankList[i].finish_time!=null)
				$("#raceRecord2000_"+rankList[i].bow_num).text(rankList[i].finish_time);
			else
				$("#raceRecord2000_"+rankList[i].bow_num).text("00:00:00.00");
			if(rankList[i].finish_rank!=null)
				$("#rank2000_"+rankList[i].bow_num).text(rankList[i].finish_rank);
			else
				$("#rank2000_"+rankList[i].bow_num).text("-");
			for(var j=0;j<rankList.length;j++){
				if(rankList[j].finish_rank==i+1&&rankList[j].finish_rank!=null)
					$("#"+(i+1)+"rankTeamName").text(rankList[j].team_name);
				if(rankList[j].finish_rank==null)
					$("#"+(i+1)+"rankTeamName").text("-");
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
		var json_data = "race_num="+(Number($("#infrontrace_num").val())+1);
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
					if(j==(bowInfo[i].bow_num-1)){
						$("#bowNum"+(j+1)).text(bowInfo[i].team_name);
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
			common.setStarttime();
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
			common.setFinishtime();
			flag=0;
			common.PastTimeReceive();
		}
	},
	
	process : function(){
		var now = new Date();
		var nowTime = now.getTime();
		var fullstartTime = now.getFullYear() + "-" + (now.getMonth()+1) + "-" +now.getDate() + " " + start_time;
		var starttime = new Date(fullstartTime);
		var startTime=starttime.getTime();
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
		if(output.indexOf("-")==-1&&output.indexOf("NaN")==-1)
			$("#watchtime").text(output)
	},
	
	start : function(num){
		console.log("start, twoYn : "+num)
		var now = new Date();
		if(num==2){
			$("#raceStatus").text("2 분전");
			$("#raceStatus").css("background-color", "#FF0000");
		}else if(num==1){
			var json_data = "race_num="+(Number($("#infrontrace_num").val())+1);
			$.ajax({
				url:'http://localhost:8080/airquayRowing/main/getStartTime',
				type : 'GET',
				cache: false,
				contentType: false,
				processData: false,
				data : json_data,
				dataType : 'json',
				success : function(data){
					start_time = data[0].start_time;
				},
				error : function(data){
					console.log("error");
				}
			});
			stopwatch = setInterval(common.process, 10);
			$("#raceStatus").text("경기중");
			$("#raceStatus").css("background-color", "#FF0000");
			count = 0;
		}
	},
	
	setStarttime : function(){
		var json_data = "race_num="+(Number($("#infrontrace_num").val())+1);
		$.ajax({
			url:'http://localhost:8080/airquayRowing/main/getStartTime',
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
			success : function(data){
				$("#racestart_time").text(data[0].start_time);
			},
			error : function(data){

			}
		});
	},
	
	setFinishtime : function(){
		var json_data = "race_num="+(Number($("#infrontrace_num").val())+1);
		$.ajax({
			url:'http://localhost:8080/airquayRowing/main/getFinishTime',
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
			success : function(data){
				$("#racefinish_time").text(data[0].stop_time);
			},
			error : function(data){

			}
		});
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
		var json_data = "race_num="+(Number($("#infrontrace_num").val())+1);
		$.ajax({
			url:'http://localhost:8080/airquayRowing/main/passTimer',
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
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
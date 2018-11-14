var common={
	
	//onoff값 확인
	RacePoling : function(){
		console.log("Race poling, raceInfo : "+raceInfo)
		common.beforeStartPolling();
		common.setStarttime();
		common.setFinishtime();
		common.raceYN();
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
						}
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
								start_time=data[0].start_time;
								common.process();
							},
							error : function(data){

							}
						});
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
					else if((data==0)&&raceYN=="true"){//경기시작 전
						console.log("data="+data)
						$("#raceStatus").text(" ");
					}
					else if((data==0||data==5)&&raceYN=="false"){//경기종료
						console.log("data="+data)
						common.onOffinish_timer(data);
						flag=0;
					}
					
				},
				error : function(data){
				}
			});
		}else{
			common.getRaceInfo();
		}
	},

	raceYN : function(){
		var json_data = "race_num="+(Number($("#infrontrace_num").val())+1);
		var url = 'http://localhost:8080/airquayRowing/main/fiveNull';
		$.ajax({
			url:url,
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
			success : function(data){
				if(data==true)
					
					raceYN="true";
				else
					raceYN="false";
			},
			error : function(){
			}
		});
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
				if(rankList[j].finish_rank==i+1&&rankList[j].finish_rank!=null){
					$("#"+(i+1)+"rankTeamName").text(rankList[j].team_name);
					break;
				}
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
	
	//팀 정보 가져옴
	getTeamInfo : function(){
		console.log("getTeamInfo")
		var json_data = " ";//toDay를 raceDate파라미터로 넘김
		$.ajax({
			url:'http://localhost:8080/airquayRowing/main/getTeamInfo',
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
			success : function(data){
				console.log("getTeamInfo Success")
				if(data.length>0){
					teamInfo = data;
					var innerHtml = "";
					for(var i=0; i<teamInfo.length; i++){
						innerHtml += "<option value="+(teamInfo[i].team_num)+">"+teamInfo[i].team_name+"</option>"
					}
					$("#teams").empty().append(innerHtml);
				}
			},
			error : function(data){
				console.log("getTeamInfo error")
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
			innerHtml += "<option value="+(raceInfo[i].race_num-1)+"> Race "+raceInfo[i].day_race_num+"</option>"
		}
		$("#infrontrace_num").empty().append(innerHtml);
		common.dispRaceInfo();
		common.getBowInfo();
	},
	
	//경기정보 출력
	dispRaceInfo : function(){
		console.log("dispRaceInfo")
		var race_num = $("#infrontrace_num").val()-raceInfo[0].race_num+1;
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
	
	displayRecord : function(){
		console.log("displayRecord")
		var json_data = "team_num="+($("#teams").val());
		$.ajax({
			url:'http://localhost:8080/airquayRowing/main/getRecord',
			type : 'GET',
			cache: false,
			contentType: false,
			processData: false,
			data : json_data,
			dataType : 'json',
			success : function(data){
				records=data;
				var innerHtmlInfo = "";
				var innerHtml500 = "";
				var innerHtml1000 = "";
				var innerHtml1500 = "";
				var innerHtmlFinish = "";
				var innerHtmlRank="";
				for(var i=0; i<records.length; i++){
					if(records[i].finish_time!=null){
						innerHtmlInfo+=records[i].event_name+"  <"+records[i].race_date+"><hr>";
						innerHtmlRank+=records[i].finish_rank+"<hr>";
						if(records[i].fivehundred_time!=null)
							innerHtml500 += records[i].fivehundred_time+"<hr>";
						else
							innerHtml500 += "-"+"<hr>";
						if(records[i].thousand_time!=null)
							innerHtml1000 += records[i].thousand_time+"<hr>";
						else
							innerHtml1000 += "-"+"<hr>";
						if(records[i].thousandfivehundred_time!=null)
							innerHtml1500 +=records[i].thousandfivehundred_time+"<hr>";
						else
							innerHtml1500 += "-"+"<hr>";
						if(records[i].finish_time!=null)
							innerHtmlFinish +=records[i].finish_time+"<hr>";
						else
							innerHtmlFinish += "-"+"<hr>";
					}
				}
				$("#recordinfo").empty().append(innerHtmlInfo);
				$("#record500").empty().append(innerHtml500);
				$("#record1000").empty().append(innerHtml1000);
				$("#record1500").empty().append(innerHtml1500);
				$("#finish").empty().append(innerHtmlFinish);
				$("#rank").empty().append(innerHtmlRank);
			},
			error : function(data){
				console.log("displayRecord error")
			}
		});
	},
	
	//타이머 제어
	onOffinish_timer : function(num){
		console.log("onOffinish_timer, num : "+num)
		if (num==1) {//시작
			common.start(1);
			flag=1;
		}else if(num==2){//2분선
			clearInterval(stopwatch);
			common.PastTimeReceive();
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
	
		var fullstartTime = now.getFullYear() + "-" + (now.getMonth()+1) + "-" +now.getDate() + " " + start_time;
		var starttime = new Date(fullstartTime);
		var startTime=starttime.getTime();
		var time = nowTime - startTime;
		if(time>=0)
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
		
	/*	var xmlHttp;
		function srvTime(){
		    try {
		        //FF, Opera, Safari, Chrome
		        xmlHttp = new XMLHttpRequest();
		    }
		    catch (err1) {
		        //IE
		        try {
		            xmlHttp = new ActiveXObject('Msxml2.XMLHTTP');
		        }
		        catch (err2) {
		            try {
		                xmlHttp = new ActiveXObject('Microsoft.XMLHTTP');
		            }
		            catch (eerr3) {
		                //AJAX not supported, use CPU time.
		                alert("AJAX not supported");
		            }
		        }
		    }
		    xmlHttp.open('HEAD',window.location.href.toString(),false);
		    xmlHttp.setRequestHeader("Content-Type", "text/html");
		    xmlHttp.send('');
		    return xmlHttp.getResponseHeader("Date");
		}

		var st = srvTime();
		var now = new Date(st);*/
		
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
				if(data[0]!=null)
					$("#racestart_time").text(data[0].start_time);
				else
					$("#racestart_time").text("Not started yet.");
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
				if(data[0]!=null)
					$("#racefinish_time").text(data[0].stop_time);
				else
					$("#racefinish_time").text("Not finished yet.");
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
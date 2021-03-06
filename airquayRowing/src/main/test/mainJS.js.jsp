 		var start_time; // starting time
                var stopwatch; // timer ID
                var output; //  output string
                var count; // number of record
                var modal = document.getElementById("myModal");

                // Get the button that opens the modal
                var btn1 = document.getElementById("connectButtonStart");
                var btn2 = document.getElementById("connectButton500");
                var btn3 = document.getElementById("connectButton1000");
                var btn4 = document.getElementById("connectButton1500");
                var btn5 = document.getElementById("connectButtonFinish");

                // Get the <span> element that closes the modal
                var span = document.getElementsByClassName("close")[0];

                // When the user clicks on the button, open the modal
                btn2.onclick = function() {
                        modal.style.display = "block";
                }
                btn1.onclick = function() {
                        modal.style.display = "block";
                }
 		btn3.onclick = function() {
                        modal.style.display = "block";
                }
                btn4.onclick = function() {
                        modal.style.display = "block";
                }
                btn5.onclick = function() {
                        modal.style.display = "block";
                }

                // When the user clicks on <span> (x), close the modal
                span.onclick = function() {
                        modal.style.display = "none";
                }

                // When the user clicks anywhere outside of the modal, close it
                window.onclick = function(event) {
                        if (event.target == modal) {
                                modal.style.display = "none";
                        }
                }
		function onOffinish_timer(num) {
                        if (num  == 1) {
                                start();
                        } else {
                                stop();
                        }
                }

                function start() {
                        var now = new Date();
                        start_time = now.getTime();
                        stopwatch = window.setInterval(process, 1);
                        count = 0;
                }

                function stop() {
                        window.clearInterval(stopwatch);
                }

                function process() {
                        var now = new Date();
                        var nowTime = now.getTime();
                        var time = nowTime - start_time;
			showTime(time);
                }

                function showTime(time) {
                        var totalsec = parseInt(time / 1000, 10);
                        var tinysec = time % 100;
                        var totalmin = parseInt(totalsec / 60, 10);
                        var sec = totalsec % 60;
                        var hour = parseInt(totalmin / 60, 10);
                        var min = totalmin % 60;
                        output = leadingZeros(hour,2) + ":" + leadingZeros(min,2) + ":" + leadingZeros(sec,2) + "." + tinysec;
                        document.getElementById("watchtime").value = output;
                }

                function init() {
                        count = 0;
                }

                function refresh(){
                        document.getElementById("watchtime").value='00:00:00.00';
                }
		function realTimeClock() {
                        document.rtcForm.rtcInput.value = getTimeStamp();
                        document.rtcForm.rdcInput.value = getDateStamp();
                        setTimeout("realTimeClock()", 1000);
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
                        var time = leadingZeros(d2.getFullYear(), 4) + '.'
                                        + leadingZeros(d2.getMonth() + 1, 2) + '.'
                                        + leadingZeros(d2.getDate(), 2);
 			return time;
                }
                function leadingZeros(n, digits) {
                        var zero = '';
                        n = n.toString();

                        if (n.length < digits) {
                                for (i = 0; i < digits - n.length; i++)
                                        zero += '0';
                        }
                        return zero + n;
                }
                function AjaxCall() {
                        $.ajax({
                                cache : false,
                                url : 'http://localhost:8080/timerIsOn.jsp',
                                success : function(data) {
                                        $("#raceRecord500_1").html(data);
                                }
                        });
                }
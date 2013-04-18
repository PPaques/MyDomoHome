function updateTime() {
	var currentTime = new Date();
	var hours       = currentTime.getHours();
	var minutes     = currentTime.getMinutes();
	var seconds     = currentTime.getSeconds();
	if (minutes < 10) {
		minutes = "0" + minutes;
	}
	if (seconds < 10) {
		seconds = "0" + seconds;
	}
	var now = hours + ":" + minutes + ":" + seconds + " ";
	setTimeout("updateTime()",1000);	/*Update each second (each 1000 ms)*/
	document.getElementById('time').innerHTML = now;
}
updateTime();
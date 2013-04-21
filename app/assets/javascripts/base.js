$(document).ready(function() {

    // Graphe des mesures récentes
	var t = (new Date()).getTime();
	var options = {
        grid : {
                color: "#AAA",
                backgroundColor: { colors: ["#444", "#333"] },
                hoverable: true,
                borderWidth: 1
            },
		legend: {
				position: "sw",
                backgroundColor: "#aaaaaa",
                backgroundOpacity: 0.3
			},
		xaxis: {
				mode: "time",
				timeformat: "%H:%M",
                color: "#666"
			},
        yaxis: {
                color: "#888"
        }
	};
	$.ajax({
		url: "/getRecentJSON",
		method: 'GET',
		dataType: 'json',
		success: function(json){
			data = json;
			$("#recentTemps").plot(data, options);
		}
	});
	$("aside .btn-collapse").click(function(){
		$("aside .submenu-collapse").stop().slideToggle('fast');
	});
});
$(window).resize(function() {
	if(window.innerWidth > 480){
		$("aside .submenu-collapse").css('display','');
	}
});
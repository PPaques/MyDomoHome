$(document).ready(function() {
	// if($('#recentTemps').is(*)){
	    // Graphe des mesures récentes
		var t = (new Date()).getTime();
		var options = {
	        grid : {
	                color: "#AAA",
	                backgroundColor: { colors: ["#444", "#333"] },
	                hoverable: true,
	                borderWidth: 1
	            },
	        tooltip: true,
	        tooltipOpts: {
	        	content: "<strong>%s :</strong> %x - %y°C"
	        },
			legend: {
					position: "sw",
	                backgroundColor: "#aaaaaa",
	                backgroundOpacity: 0.3
				},
			xaxis: {
					mode: "time",
					timeformat: "%H:%M",
					timezone: "browser",
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
	// }
	$('.checkbox-room').click(function(){
		var id = $(this).attr('id');
		if($(this).hasClass('active')){
			$("." + id).hide();
		}else{
			$("." + id).show();
		}
	});
});
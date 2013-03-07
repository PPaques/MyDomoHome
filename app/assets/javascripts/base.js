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
				timeformat: "%Y/%m/%d",
                color: "#666"
			},
        yaxis: {
                color: "#888"
        }
	};
	var data = [ 
		{ label: "Chambre", color: "#FF9900", data: [ [t, 1], [t+100000, -14], [t+200000, 5] ] },
  		{ label: "Cuisine", color: "#C8F000", data: [ [t, 13], [t+100000, 11], [t+200000, -7] ] },
        { label: "Salle de bain", color: "#EE3C19", data: [ [t, 5], [t+100000, -2], [t+200000, 12] ] },
        { label: "Extérieur", color: "#006CFF", data: [ [t, -2], [t+100000, 3], [t+200000, -2] ] }
	];
	$("#placeholder").plot(data, options);

	$("aside .btn-collapse").click(function(){
		$("aside .submenu-collapse").stop().slideToggle('fast');
	});
});

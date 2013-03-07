//Every resize of window
$(window).resize(sizeClontent);

$(document).ready(function() {
    // Griser toute la hauteur de la zone "content"
	sizeContent();

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

function sizeContent() {

	// Dynamically assign height
    var newHeight = $(window).height() - $("header").height()- $("section").css("margin-top").replace(/\D/g, '');
    var innerHeight = parseInt($("section .container-fluid").css("height").replace(/\D/g, '')) + parseInt($("section .container-fluid").css("padding-top").replace(/\D/g, '')) + parseInt($("section .container-fluid").css("padding-bottom").replace(/\D/g, ''));
    if(newHeight > innerHeight ){
    	$("section").css("height", newHeight);
    }else{
    	$("section").css("height", innerHeight);
    }

    // Always show submenu when width > 480px
    if($('body').width() + scrollbar_width() > 480){
    	if($("aside .submenu-collapse").is(':hidden'))
    		$("aside .submenu-collapse").show();
    }else{
    	if($("aside .submenu-collapse").is(':visible'))
    		$("aside .submenu-collapse").hide();
    }
}

function scrollbar_width() {
    if( jQuery('body').height() > jQuery(window).height()) {
         
        /* Modified from: http://jdsharp.us/jQuery/minute/calculate-scrollbar-width.php */
        var calculation_content = jQuery('<div style="width:50px;height:50px;overflow:hidden;position:absolute;top:-200px;left:-200px;"><div style="height:100px;"></div>');
        jQuery('body').append( calculation_content );
        var width_one = jQuery('div', calculation_content).innerWidth();
        calculation_content.css('overflow-y', 'scroll');
        var width_two = jQuery('div', calculation_content).innerWidth();
        jQuery(calculation_content).remove();
        return ( width_one - width_two );
    }
    return 0;
}
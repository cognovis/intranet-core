/*   START: NEW SIDEBAR */

var isExtended = 1;
var height = 600;
var width = 243;
var slideDuration = 750;
var opacityDuration = 1500;


function extendContract(){
	if(isExtended == 0){
		sideBarSlide(0, height, 0, width);
		sideBarOpacity(0, 1);
		isExtended = 1;
		// move main part
		jQuery(".fullwidth-list").animate({marginLeft: "288px"}, slideDuration );
		// make expand tab arrow image face left (inwards)
		$('#sideBarTab').children().get(0).src = $('#sideBarTab').children().get(0).src.replace(/(\.[^.]+)$/, '-active$1');
	}
	else{
		sideBarSlide(height, 0, width, 0);
		sideBarOpacity(1, 0);
		isExtended = 0;
		jQuery(".fullwidth-list").animate({marginLeft: "24px"}, slideDuration );
		// make expand tab arrow image face right (outwards)
		$('#sideBarTab').children().get(0).src = $('#sideBarTab').children().get(0).src.replace(/-active(\.[^.]+)$/, '$1');
	}
}

function sideBarSlide(fromHeight, toHeight, fromWidth, toWidth) {
	 // alert('in: sideBarSlide');
	// $("sideBarContents").css ({'height': fromHeight, 'width': fromWidth});
	// $("#sideBarContents").animate( { 'height': toHeight, 'width': toWidth }, { 'queue': false, 'duration': slideDuration }, "linear" );
	$("sidbar").css ({'height': fromHeight, 'width': fromWidth});
	$("#sidebar").animate( { 'height': toHeight, 'width': toWidth }, { 'queue': false, 'duration': slideDuration }, "linear" );

}

function sideBarOpacity(from, to){
	// $("#sideBarContents").animate( { 'opacity': to }, opacityDuration, "linear" );
	$("#filter").animate( { 'opacity': to }, opacityDuration, "linear" );

}

$(function(){
  	// Document is ready
	// $('#sideBarTab').click( function() { extendContract(); return false; }); 
	$('#sideBarTab').click( function() { extendContract(); return false; });
});
/*   END: NEW SIDEBAR */

/*

    jQuery("#header_skin_select > form > select").change(function(){
       jQuery("#header_skin_select > form").submit();
    });
*/





// check this http://www.nabble.com/%22$(document).ready(function()-%7B%22-giving-error-%22$-is-not-a-function%22----what-am-I-doing-wrong--td17139297s27240.html
// jQuery.noConflict();
jQuery().ready(function(){
	
	jQuery("#header_skin_select > form > select").change(function(){
	jQuery("#header_skin_select > form").submit();
	});
	
	jQuery(".component-parking div").click(function(){	
	jQuery(".component-parking ul").slideToggle();
	});
	
	/*In order to make this work we need to re-order DIVs*/
	var node_insert_after=document.getElementById("slave");
	var node_to_move=document.getElementById("fullwidth-list");
	document.getElementById("monitor_frame").insertBefore(node_to_move, node_insert_after.nextSibling);

    jQuery(".component_icons").css("opacity","0.1");
    jQuery(".component_header").hover(function(){
       jQuery(".component_icons",this).stop().fadeTo("fast",1);
    },function(){
       jQuery(".component_icons",this).stop().fadeTo("normal",0.1);
    });

    jQuery(".component-parking div").click(function(){
       jQuery(".component-parking ul").slideToggle();
    });


});



function poGetCookie(c_name)
{
if (document.cookie.length>0)
  {
  c_start=document.cookie.indexOf(c_name + "=")
  if (c_start!=-1)
    {
    c_start=c_start + c_name.length+1
    c_end=document.cookie.indexOf(";",c_start)
    if (c_end==-1) c_end=document.cookie.length
    return unescape(document.cookie.substring(c_start,c_end))
    }
  }
return ""
}

function poSetCookie(c_name,value,expiredays)
{
var exdate=new Date()
exdate.setDate(exdate.getDate()+expiredays)
document.cookie=c_name+ "=" +escape(value)+
((expiredays==null) ? "" : ";expires="+exdate.toGMTString())
}




 


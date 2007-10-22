jQuery.noConflict();

jQuery().ready(function(){
    /* sliding filters */

    jQuery(".filter > .filter-block:first").prepend('<div class="filter-button"></div>');

    if (getCookie("filterState")=="hidden") {
       jQuery(".filter").css("right","-260px");
       jQuery(".fullwidth-list").css("marginRight","0px");
       jQuery(".filter-button").css(
          "background","url('/intranet/images/navbar_default/arrow_comp_left.png') no-repeat"
       );
    } else {
       jQuery(".filter-button").css(
          "background","url('/intranet/images/navbar_default/arrow_comp_right.png') no-repeat"
       );
    }

  
    jQuery(".filter-button").click(function(){  
	if (getCookie("filterState")=="hidden") {
	   jQuery(".fullwidth-list").animate({ 
	      marginRight: "260px"
	      }, 1000 );
           jQuery(".filter").animate({ 
	      right: "0px"
	      }, 1000 );

           jQuery(".filter-button").css(
             "background","url('/intranet/images/navbar_default/arrow_comp_right.png') no-repeat"
           );

	   setCookie("filterState","",20); 
        } else {

           jQuery(".filter").animate({ 
	      right: "-260px"
     	   }, 1000 );
           jQuery(".fullwidth-list").animate({ 
	      marginRight: "0px"
	   }, 1000 );

           jQuery(".filter-button").css(
             "background","url('/intranet/images/navbar_default/arrow_comp_left.png') no-repeat"
           );

	   setCookie("filterState","hidden",20);
	}
    });

    
    jQuery("#header_skin_select > form > select").change(function(){
       jQuery("#header_skin_select > form").submit();
    });

    jQuery(".component_icons").css("opacity","0.1");

    jQuery(".component_icons").hover(function(){
       jQuery(this).fadeTo("normal",1);
    },function(){
       jQuery(this).fadeTo("normal",0.1);
    });


    /* rounded corners **********************************/

    settings = {
      tl: { radius: 10 },
      tr: { radius: 10 },
      bl: false,
      br: false,
      antiAlias: true,
      autoPad: true
    }

    var cornersObj = new curvyCorners(settings, 
       document.getElementById("header_class")
    );


    settings = {
      tl: { radius: 5 },
      tr: { radius: 5 },
      bl: false,
      br: false,
      antiAlias: true,
      autoPad: false
    }

    var cornersObj = new curvyCorners(settings, 
       "navbar_selected"
    );
    cornersObj.applyCornersToAll();

    if (document.getElementById("header_logout_tab")) {

    settings = {
      tl: false,
      tr: false,
      bl: { radius: 10 },
      br: { radius: 10 },  
      antiAlias: true,
      autoPad: false
    };

    var cornersObj = new curvyCorners(settings, 
       document.getElementById("header_logout_tab"),
       document.getElementById("header_settings_tab")
    );
    cornersObj.applyCornersToAll();
    }


  settings = {
      tl: { radius: 10 },
      tr: { radius: 10 }, 
      bl: { radius: 10 },
      br: { radius: 10 },
      antiAlias: true,
      autoPad: false
    };

    var cornersObj = new curvyCorners(settings, 
       "filter"
    );
/*    cornersObj.applyCornersToAll(); */

});

function getCookie(c_name)
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

function setCookie(c_name,value,expiredays)
{
var exdate=new Date()
exdate.setDate(exdate.getDate()+expiredays)
document.cookie=c_name+ "=" +escape(value)+
((expiredays==null) ? "" : ";expires="+exdate.toGMTString())
}




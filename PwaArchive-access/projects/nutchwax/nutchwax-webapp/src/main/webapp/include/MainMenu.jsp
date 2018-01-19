<script type="text/javascript">
/*Arquivo.pt specific functions and js code, such as loading constants, cookies, custom html code, etc*/
var MENU = MENU || (function(){
    return {
        init : function() {
        	document.write(''+
				'<div class="swiper-container">'+
					'<div class="swiper-wrapper">'+
						'<div class="swiper-slide content"><div id="mainMask"></div>');
                        /*
						'<div id="mainMenu" class="swiper-slide menu closed">'+
							'<a onclick="ga(\'send\', \'event\', \'MainMenu\', \'Home click\', \''+window.location.href+'\');" href="/index.jsp?l=<%=language%>"><h4><i class="fa fa-home" aria-hidden="true"></i> <fmt:message key='topbar.leftmenu.home'/></h4></a>'+
							'<a onclick="ga(\'send\', \'event\', \'MainMenu\', \' Advanced search click\', \''+window.location.href+'\');" href="/advanced.jsp?l=<%=language%>"><h4><i class="fa fa-search-plus" aria-hidden="true"></i> <fmt:message key='topbar.leftmenu.advanced'/></h4></a>'+
							'<a onclick="ga(\'send\', \'event\', \'MainMenu\', \' Video click\', \''+window.location.href+'\');" href="<fmt:message key='topbar.leftmenu.video.href'/>"><h4><i class="fa fa-youtube-play" aria-hidden="true"></i> <fmt:message key='topbar.leftmenu.video'/></h4></a>'+
							'<a onclick="ga(\'send\', \'event\', \'MainMenu\', \' Examples click\', \''+window.location.href+'\');" href="<fmt:message key='topbar.leftmenu.examples.href'/>"><h4><i class="fa fa-globe" aria-hidden="true"></i> <fmt:message key='topbar.leftmenu.examples'/></h4></a>'+
							'<a onclick="ga(\'send\', \'event\', \'MainMenu\', \' Help click\', \''+window.location.href+'\');" href="<fmt:message key='topbar.leftmenu.help.href'/>"><h4><i class="fa fa-question-circle" aria-hidden="true"></i> <fmt:message key='topbar.leftmenu.help'/></h4></a>'+
							'<a onclick="ga(\'send\', \'event\', \'MainMenu\', \' About click\', \''+window.location.href+'\');" href="<fmt:message key='topbar.leftmenu.about.href'/>"><h4><i class="fa fa-info-circle" aria-hidden="true"></i> <fmt:message key='topbar.leftmenu.about'/></h4></a>'+
						'</div>' */ 	      
        	this.attachMask();

        },
        close: function(){
        	document.write( '</div></div></div>');
        	$('.swiper-wrapper').append(
			            	'<div class="swiper-slide menu swiper-slide-prev">' +       
	          					'<a href="/index.jsp?l=<%=language%>" onclick=""><h4><i class="fa fa-search padding-right-menu-icon" aria-hidden="true"></i> <fmt:message key='topbar.menu.home'/></h4></a>' +
	          					'<a href="/advanced.jsp?l=<%=language%>" onclick=""><h4><i class="fa fa-search-plus padding-right-menu-icon" aria-hidden="true"></i> <fmt:message key='topbar.menu.advanced'/></h4></a>' +
	          					'<a id="shareMenu"><h4><i class="fa fa-share-alt padding-right-menu-icon" aria-hidden="true"></i> <fmt:message key='topbar.menu.share'/><i id="shareCarret" class="fa fa-caret-down iCarret shareCarret pull-right" aria-hidden="true"></i></h4></a>'+
	          					'<div id="shareOptions">'+
	          						'<a class="addthis_button_facebook" onclick="" href=""><h4 class="submenu"><i class="fa fa-facebook padding-right-menu-icon" aria-hidden="true"></i> Facebook</h4></a>'+
	          						'<a class="addthis_button_twitter" onclick="" ><h4 class="submenu"><i class="fa fa-twitter padding-right-menu-icon" aria-hidden="true"></i> Twitter</h4></a>'+
	        /*  ' 			<a title="EmailTitle" href="mailto:?subject=EmailMessage [sub]" onclick="this.href = this.href.replace(\'[sub]\',document.title + \'%0D%0A'+ encodeURIComponent(this.getDatets()) +'%0D%0A %0D%0A\' + encodeURIComponent(window.location.href) ); ga(\'send\', \'event\', \'ReplayBarFunctions\', \'EmailShareClick\', \'http://arquivo.pt/'+_ts+'/'+_url+'\');""><h4 class="submenu"><i class="fa fa-envelope" aria-hidden="true"></i> '+Content.email+'</h4></a>'+*/
			  					'</div>'+   
	          					'<a href="http://sobre.arquivo.pt/<%=language%>" onclick=""><h4><i class="fa fa-info-circle padding-right-menu-icon" aria-hidden="true"></i> <fmt:message key='topbar.menu.about'/></h4></a>'+			  					          
	          					'<a href="<fmt:message key='topbar.menu.help.href'/>" onclick=""><h4><i class="fa fa-question-circle padding-right-menu-icon" aria-hidden="true"></i> <fmt:message key='topbar.menu.help'/></h4></a>'+
	          					'<a id="changeLanguage" onclick=""><h4><i class="fa fa-flag padding-right-menu-icon" aria-hidden="true"></i> <fmt:message key='topbar.menu.otherLanguage'/></h4></a>'+
	          				'</div>');
        	this.attachChangeLanguage();
        	this.attachShare();
        },
		toggleLanguage: function() {
			/*returns current window href without the specified parameter*/
			key="l"; /*language parameter*/
			sourceURL = window.location.href;
			var foundParameter = false;
		    var rtn = sourceURL.split("?")[0],
		        param,
		        params_arr = [],
		        queryString = (sourceURL.indexOf("?") !== -1) ? sourceURL.split("?")[1] : "";
		    if (queryString !== "") {
		        params_arr = queryString.split("&");
		        for (var i = params_arr.length - 1; i >= 0; i -= 1) {
		            param = params_arr[i].split("=")[0];
		            if (param === key) {
		                params_arr.splice(i, 1);
		                foundParameter = true;
		            }
		        }
		        rtn = rtn + "?" + params_arr.join("&");
		        if(foundParameter){
		        	if( rtn.substr(rtn.length - 1) ==="?"){
		        		rtn = rtn.substr(0, rtn.length-1);
		        	}
		        }
		        else{
		        	rtn = rtn +"&l=en";
		        }
		    }
		    else{
		    	rtn=rtn +"?&l=en"
		    }
		    return rtn;
		},
 		attachShare: function(){
		  $('#shareMenu').on('click', function(e){
		  	//ga('send', 'event', 'ReplayBarFunctions', 'ShareMenuClick', 'http://arquivo.pt/'+_ts+'/'+_url);
		    $('#shareCarret').toggleClass('fa-caret-up fa-caret-down');
		    $('#shareOptions').slideToggle( "fast", "linear" );
		  }); 	 			
 		}, 			
		attachChangeLanguage: function(){
			$('#changeLanguage').click( function(e) {
					e.preventDefault();
					window.location = toggleLanguage(); 
					return false; } );
		},
        attachMask: function(){       
		  $('#mainMask').on('click', function(e){
		    document.querySelector('.swiper-container').swiper.slideNext();
		  }); 	         	
        },	 									 		
    };
}());	
</script>
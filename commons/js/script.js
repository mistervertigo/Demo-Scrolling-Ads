var allvar = 'foo'; 

	 function inserth1Text(){
			page = $('.scroll a:last').attr('title');
			console.log(page);
			// Waypoints
         $("section").waypoint(
                 function(direction) {
                         //console.log(direction);
                         if (direction ==='down') {
                                 var wayID = $(this).attr('id');
										
                         } else {
										
                         		  
										  var previous = $(this).parent().prev().children();
										  
                                 var wayID = $(previous).attr('id');
										  
										 
                         }
								
								console.log(wayID);

                        $('li.active').removeClass('active');
                         $('li.'+wayID+'').addClass('active');

                 }, { offset: '40%' });    
	
		   
			
			history.replaceState('foo', page, page+'.html');
			
	
			
	  }
	  
 	 $('.inside li a').click(function(){  
		 
 		element = $(this).attr('href').replace('#', '');
		
 		history.replaceState('foo', element, element+'.html');
 		
		$( '#resultados' ).load( element+'.html' );
		 
  		 $(this).parent().addClass('active'); 
 		 $(this).parent().siblings().removeClass('active'); 
		 $(this).parent().parent().siblings().removeClass('active'); 
		
 	 });
	
	 
	 $('.scroll').jscroll({
    	 loadingHtml: '<div class="progress"><div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 100%"><span class="sr-only">Cargando</span></div></div>',
		 autoTrigger: true,
		 padding: 100,
		 callback: inserth1Text
});



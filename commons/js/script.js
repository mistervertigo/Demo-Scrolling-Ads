
	
	
/////////////// 



	 function inserth1Text(){
			page = $('.scroll a:last').attr('title');
			
			/*console.log(page);
			$(".inside li").siblings().removeClass('active');
   		$("."+page+"").addClass('active'); 
  		 	//$("."+page+"").siblings().removeClass('active');
			//$("."+page+"").prev().siblings().removeClass('active');
			
			console.log($(".inside li").siblings().text()); */
			
			/*var url = window.location.pathname;
			var filename = url.substring(url.lastIndexOf('/')+1);
			console.log(filename);
			
		
							$('.nav li a[href^="/' + filename. + '"]').addClass('active');
						   $('.nav li a').not($('.nav li a[href^="/' + filename. + '"]')).removeClass('active'); 
							
							
							$('.masdeporte').removeClass('active');   */
			
			// Waypoints
			$("#"+page+"").waypoint(
				function(direction) {
					console.log(direction);
					if (direction ==='down') {
						var wayID = $(this).attr('id');
					} else {
						
						var wayID = $(this).attr('id');
					}
					console.log(wayID);
					$('li.'+wayID+'').siblings().removeClass('active');
					$('li.'+wayID+'').addClass('active');
				}, { offset: '40%' });      
	
		   
			
			//history.replaceState('foo', page, page+'.html');
			
	
			
	  }
	  
 	 $('.inside li a').click(function(){  
		 
  		 $(this).parent().addClass('active'); 
 		 $(this).parent().siblings().removeClass('active'); 
		
 	 });
	 
	 
	$('.inside li a').click(function() {
		
		element = $(this).attr('href').replace('#', '');
		
		history.replaceState('foo', element, element+'.html');
		$( '#resultados' ).load( element+'.html' );

	});
	 
	 $('.scroll').jscroll({
    	 loadingHtml: '<div class="progress"><div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 100%"><span class="sr-only">Cargando</span></div></div>',
		 autoTrigger: true,
		 padding: 100,
		 callback: inserth1Text
});



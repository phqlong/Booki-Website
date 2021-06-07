$(function() {

	if ( $('.owl-2').length > 0 ) {
        $('.owl-2').owlCarousel({
            center: false,
            items: 1,
            loop: true,
            stagePadding: 0,
            margin: 20,
            smartSpeed: 1000,
            autoplay: true,
            nav: true,
            dots: true,
            pauseOnHover: false,
            responsive:{
                600:{
                    margin: 20,
                    nav: true,
                  items: 2
                },
                1000:{
                    margin: 20,
                    stagePadding: 0,
                    nav: true,
                  items: 3
                }
            }
        });            
    }

})

$(function() {

	// $('.owl-1').owlCarousel({

 //    loop:true,
 //    margin:0,
 //    nav:true,
 //    items: 1,
 //    smartSpeed: 1000,
 //    autoplay: true,
 //    autoplayHoverPause: true,
 //    navText: ['<span class="icon-keyboard_arrow_left">', '<span class="icon-keyboard_arrow_right">']
	// })


    if ( $('.slide-one-item').length > 0 ) {
            $('.slide-one-item').owlCarousel({
            items: 1,
            loop: true,
                stagePadding: 0,
            margin: 0,
            autoplay: true,
            animateOut: 'slideOutDown',
            animateIn: 'fadeIn',
            pauseOnHover: false,
            nav: true,
            navText: ['<span class="icon-arrow_back">', '<span class="icon-arrow_forward">']
          });
      }


	
})
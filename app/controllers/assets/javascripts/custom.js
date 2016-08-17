/* Custom JS */
$( document ).ready(function() {
	
	$(".profile-holder").css("max-height",$(".profile-holder").width());
    $(".my-images-holder").css("max-height",$(".my-images-holder").width());

	// Material UI
    $.material.init();
    // Select box style
    $(".selectDropdown").dropdown({ "autoinit" : ".select" });
    // Tooltip
    $('[data-toggle="tooltip"]').tooltip();

   
   if($(".profile-carousel img").length>1){
	    $('.profile-carousel').owlCarousel({
		    loop:true,
		    margin:10,
		    nav:false,
		    dots:true,
		    autoHeight:true,
		    items:1
		});
	}

    if($(".has-nicescroll").length>0){
    	$(".has-nicescroll").niceScroll();
    }

    if($(".request_scroll").length>0){
    	$(".request_scroll").niceScroll();
    }

    $('.datePicker').datepicker({
    	dateFormat: 'mm-dd-yy',
    	yearRange:'-90:-16',
		changeMonth: true,
		changeYear: true
    });

    $.validator.addMethod('mypassword', function(value, element) {
        return this.optional(element) || (value.match(/[a-z]/) && value.match(/[A-Z]/) && value.match(/[!@#$%^&*()_=\[\]{};':"\\|,.<>\/?+-]/) && value.match(/[0-9]/));
    },
    'Password must contain at least one numeric,one special character,one lower case character and one uppercase character.');



});
	// Message script
	$('.chat[data-chat=person2]').addClass('active-chat');
	$('.chat[data-chat=person2]').addClass('has-nicescroll');
	$('.person[data-chat=person2]').addClass('active');

	$('.msg-aside .person').mousedown(function() {
	    if ($(this).hasClass('.active')) {
	        return false;
	    } else {
	        var findChat = $(this).attr('data-chat');
	        var personName = $(this).find('.name').text();
	        $('.chat').removeClass('active-chat');
	        $('.chat').removeClass('has-nicescroll');
	        $('.msg-aside .person').removeClass('active');
	        $(this).addClass('active');
	        $('.chat[data-chat = ' + findChat + ']').addClass('active-chat');
	        $('.chat[data-chat = ' + findChat + ']').addClass('has-nicescroll');
	    }
	});

	$(".person").click(function() {
	    $('html, body').animate({
	        scrollTop: $(".msg-conversation").offset().top
	    }, 1500);
	});

$(function() {
	
	var cmap = cmap || {};
	cmap.calendar = cmap.calendar || {};
	
	var sendOriginal = XMLHttpRequest.prototype.send;
	XMLHttpRequest.prototype.send = function() {
	    var callback = this.onreadystatechange;
	    this.onreadystatechange = function() {             
	         if (this.readyState == 4) { // DONE
	        	 if (this.responseURL.indexOf('com_liferay_calendar_web_portlet_CalendarPortlet') > 0 && 
	        			 this.responseURL.indexOf('p_p_resource_id=calendarBookings') > 0) {
		        	 cmap.calendar.updateLayout();
	        	 }
	         }
	         callback.apply(this, arguments);
	    }
	    sendOriginal.apply(this, arguments);
	}
	
	$(document).arrive(".scheduler-view-table-events-overlay-node .scheduler-event", function() {
		$(this).attr('style','display: block; height: auto; left: 0px; position: relative; top: 0px; width: auto');
	});

	$(document).arrive('.scheduler-base-controls .scheduler-base-icon-prev', function() {
		$(this).find('.glyphicon-chevron-left')
			.removeClass('glyphicon glyphicon-chevron-left')
			.addClass('icon-cmap icon-nav-left-white');
	});
	
	$(document).arrive('.scheduler-base-controls .scheduler-base-icon-next', function() {
		$(this).find('.glyphicon-chevron-right')
			.removeClass('glyphicon glyphicon-chevron-right')
			.addClass('icon-cmap icon-nav-right-white');
	});

	$(document).arrive('.scheduler-view-table-header-col .scheduler-view-table-header-day', function() {
        $('.scheduler-view-table-header-day').each(function() { 
        	$('> div', $(this)).text($('> div', $(this)).text().slice(0,1)); 
        });
	});
	
	$(document).arrive('.modal-dialog modal', function() {
		console.log('arrived');
	});

	cmap.calendar.updateLayout = function() {

		$('.calendar-portlet-column-grid').removeClass('col-md-12');
		$('.scheduler-base-controls').removeClass('col-xs-7');
		
		if ($('.calendar-month-view-label').length) {
		    $('.calendar-month-view-label').text($('.scheduler-base-view-date').text());
		} else {
            $('.scheduler-base-controls')
                .find('.btn-group')
                .wrap('<div class="col-lg-4"/>');
            
            $('.scheduler-base-controls')
                .find('.col-lg-4')
                .before('<div class="col-lg-3"></div><div class="col-lg-6"><h2 class="calendar-month-view-label">' + $('.scheduler-base-view-date').text() + '</h2></div>');
            
            $('.scheduler-base-controls')
                .find('.col-lg-4')
                .after ('<div class="col-lg-3"/>'); 
		}

        $('.scheduler-base-view-date').hide();

		setTimeout(function(){ 
			$('.scheduler-event').removeAttr('style').fadeIn('fast'); 
		}, 100);
	}
});

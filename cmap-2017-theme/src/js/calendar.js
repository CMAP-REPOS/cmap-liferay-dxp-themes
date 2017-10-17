AUI().ready(function() {
	
//	var cmap = cmap || {};
//	cmap.calendar = cmap.calendar || {};
//	
//	// attach custom callback to AJAX requests
//	var sendOriginal = XMLHttpRequest.prototype.send;
//	XMLHttpRequest.prototype.send = function() {
//	    var callback = this.onreadystatechange;
//	    this.onreadystatechange = function() {             
//	         if (this.readyState == 4) { 
//	             if (this.responseURL.indexOf('com_liferay_calendar_web_portlet_CalendarPortlet') > 0 && 
//	        	     this.responseURL.indexOf('p_p_resource_id=calendarBookings') > 0) {
//		        	     cmap.calendar.updateLayout();
//	        	 }
//	         }
//	         if (callback) {
//		         callback.apply(this, arguments);
//	         }
//	    };
//	    sendOriginal.apply(this, arguments);
//	};
//			
//	cmap.calendar.updateLayout = function() {
//
//		// remove 12-column grid classes
//		$('.calendar-portlet-column-grid').removeClass('col-md-12');
//		$('.scheduler-base-controls').removeClass('col-xs-7');
//		
//		// build header with navigation
//		if ($('.calendar-month-view-label').length) {
//		    $('.calendar-month-view-label').text($('.scheduler-base-view-date').text());
//		} else {
//            $('.scheduler-base-controls')
//                .find('.btn-group')
//                .wrap('<div class="col-lg-4"/>');
//            
//            $('.scheduler-base-controls')
//                .find('.col-lg-4')
//                .before('<div class="col-lg-3"></div><div class="col-lg-6"><h2 class="calendar-month-view-label">' + $('.scheduler-base-view-date').text() + '</h2></div>');
//            
//            $('.scheduler-base-controls')
//                .find('.col-lg-4')
//                .after ('<div class="col-lg-3"/>'); 
//		}
//
//		// hide original month label
//        $('.scheduler-base-view-date').hide();
//
//		// replace "previous" link icon
//    	$('.scheduler-base-controls .scheduler-base-icon-prev')
//			.find('.glyphicon-chevron-left')
//			.removeClass('glyphicon glyphicon-chevron-left')
//			.addClass('icon-cmap icon-nav-left-white');
//		
//		// replace "next" link icon
//		$('.scheduler-base-controls .scheduler-base-icon-next')
//			.find('.glyphicon-chevron-right')
//			.removeClass('glyphicon glyphicon-chevron-right')
//			.addClass('icon-cmap icon-nav-right-white');
//		
//		// replace day headers with first letter of day
//		$('.scheduler-view-table-header-col')
//			.find('.scheduler-view-table-header-day').each(function() {
//				$('> div', $(this)).text($('> div', $(this)).text().slice(0,1)); 
//			});
//		
//		// hide visible event popover
//		if ($('.scheduler-event-recorder-popover:visible').length) {
//			$('.scheduler-event-recorder-popover').css('display', 'none');
//		}
//				
//		setTimeout(function(){ 
//			$('.scheduler-event').removeAttr('style').fadeIn('fast'); 
//		}, 200);
//	};
//	
//	cmap.calendar.formatEventTimes = function() {
//		
//		$('.scheduler-event-title').each(function() { 
//			var $this = $(this);
//			var $event = $this.closest('.scheduler-event');
//			var startTime = cmap.calendar.formatTime($event.data('starttime'));
//			var endTime = cmap.calendar.formatTime($event.data('endtime'));
//
//			$this.html(startTime + ' to ' + endTime);
//		});
//		
//		var re = /(\d{1,2}:\d{2})([APap][mM]) \- (\d{1,2}:\d{2})([APap][mM])/;
//		var popUpWhen = $('.scheduler-event-recorder-body .scheduler-event-recorder-date').text();
//		
//		popUpWhen = popUpWhen.replace(re, '$1 $2 to $3 $4')
//			.replace(' am', ' a.m.')
//			.replace(' pm', ' p.m.');
//		
//		$('.scheduler-event-recorder-body .scheduler-event-recorder-date').text(popUpWhen);
//	}
//
//	cmap.calendar.formatTime = function(time) {
//		if (time.startsWith('0')) {
//			time = time.substring(1);
//		}
//		time = time.replace('AM', 'a.m.').replace('PM', 'p.m.');
//		return time;
//	}
//	
//	// https://github.com/RickStrahl/jquery-watch
//	cmap.calendar.bindEvents = function() {
//
//		$('.scheduler-view-month > .yui3-overlay').watch({
//			properties: 'attr_style',
//			callback: function(data, i) {
//				$(this).find('.scheduler-event').attr('style','display: block; height: auto; left: 0px; position: relative; top: 0px; width: auto');
//			}
//		});
//
//		$('.calendar-portlet-wrapper').watch({
//		    properties: "prop_innerHTML",
//		    watchChildren: true,
//		    callback: function (data, i) {
//				cmap.calendar.formatEventTimes();
//		    }
//		});
//		
//		$('.portlet_com_liferay_calendar_web_portlet_CalendarPortlet').on('click', 'a.emailFriend', function() {
//			cmap.calendar.showEmailForm();
//		});
//	}
//
//	cmap.calendar.showEmailForm = function() {
//		if ($('#emailEventForm').length) {
//			$('.scheduler-event-recorder-body').html($('#emailEventForm').clone(true).removeClass('hidden'));
//		}
//	}
//
//	
//	cmap.calendar.updateLayout();
//	cmap.calendar.bindEvents();
});

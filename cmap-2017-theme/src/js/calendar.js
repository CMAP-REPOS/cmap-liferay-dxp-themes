$(function() {
	
	var cmap = cmap || {};
	
	var sendOriginal = XMLHttpRequest.prototype.send;
	XMLHttpRequest.prototype.send = function() {
	    var callback = this.onreadystatechange;
	    this.onreadystatechange = function() {             
	         if (this.readyState == 4) { // DONE
	        	 console.log(this);
	        	 if (this.responseURL.indexOf('com_liferay_calendar_web_portlet_CalendarPortlet') > 0 && 
	        			 this.responseURL.indexOf('p_p_resource_id=calendarBookings') > 0) {
		        	 cmap.updateCalendar(this.responseText);
	        	 }
	        	 
//	        	 http://localhost:8080/c/portal/layout?p_l_id=757528&p_p_cacheability=cacheLevelPage
//	        		 &p_p_id=com_liferay_calendar_web_portlet_CalendarPortlet&p_p_lifecycle=2
//	        		 &p_p_resource_id=calendarBookings
//	        		 &_com_liferay_calendar_web_portlet_CalendarPortlet_calendarIds=738411,738439
//	        		 &_com_liferay_calendar_web_portlet_CalendarPortlet_endTimeDay=8&_com_liferay_calendar_web_portlet_CalendarPortlet_endTimeHour=23&_com_liferay_calendar_web_portlet_CalendarPortlet_endTimeMinute=59&_com_liferay_calendar_web_portlet_CalendarPortlet_endTimeMonth=10&_com_liferay_calendar_web_portlet_CalendarPortlet_endTimeYear=2017&_com_liferay_calendar_web_portlet_CalendarPortlet_startTimeDay=24&_com_liferay_calendar_web_portlet_CalendarPortlet_startTimeHour=0&_com_liferay_calendar_web_portlet_CalendarPortlet_startTimeMinute=0&_com_liferay_calendar_web_portlet_CalendarPortlet_startTimeMonth=8&_com_liferay_calendar_web_portlet_CalendarPortlet_startTimeYear=2017&_com_liferay_calendar_web_portlet_CalendarPortlet_statuses=0,2,9,1
//	        	 
//	        	 http://localhost:8080/c/portal/layout?p_l_id=757528&p_p_cacheability=cacheLevelPage
//	        		 &p_p_id=com_liferay_calendar_web_portlet_CalendarPortlet&p_p_lifecycle=2
//	        		 &p_p_resource_id=calendarBookingInvitees
//	        		 &_com_liferay_calendar_web_portlet_CalendarPortlet_parentCalendarBookingId=753371
	        		 
	        	 
	         }
	         callback.apply(this, arguments);
	    }
	    sendOriginal.apply(this, arguments);
	}
	
	$(document).arrive(".scheduler-view-table-events-overlay-node .scheduler-event", function() {
		$(this).attr('style','display: block; height: auto; left: 0px; position: relative; top: 0px; width: auto');
	});
	
	
	
	cmap.updateCalendar = function(responseText) {

		var response = $.parseJSON(responseText);

		$('.scheduler-base-controls').removeClass('col-xs-7');
		$('.calendar-portlet-column-grid').removeClass('col-md-12');
		
		if (!$('.calendar-month-view-label').length) {
			$('.scheduler-base-today').after('<span class="calendar-month-view-label">' + $('.scheduler-base-view-date').text() + '</span>');
		} else {
			$('.calendar-month-view-label').text($('.scheduler-base-view-date').text());
		}
		
		$('.scheduler-base-view-date').hide();

		setTimeout(function(){ 

			$('.scheduler-view-table-more').each(function() {
				console.log('getting more...');
			});
			
			$('.scheduler-event').removeAttr('style').fadeIn('fast'); 
		}, 100);
	}
	
});

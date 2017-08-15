AUI().ready(function() {
	$('#site-search-button').on('click', function (e) {
		console.log('site-search-button click');
		e.preventDefault();
		document.location = "/search?q=" + escape($('#site-search-input').val());
	});

	$('#site-search-input').on('keypress', function (e) {
		console.log('site-search-input keypress');
	    var p = e.which;
	    if (p == 13) {
	    	document.location = "/search?q=" + escape($('#site-search-input').val());
	        $(this).blur();
	    }
	});	
});

Liferay.Portlet.ready(function(portletId, node) {
});

Liferay.on('allPortletsReady', function() {
});

var cmap = cmap || {};

cmap.initSocialShare = function(container) {
    var shareLinks = '<div class="addthis_toolbox"><ul class="list-unstyled">' + 
        '<li><a class="facebook addthis_button_facebook">Facebook</a>' +
        '<li><a class="twitter addthis_button_twitter" tw:via="GOTO2040">Twitter</a>' +
        '<li><a class="google addthis_button_google_plusone_share">Google+</a>' +
        '<li><a class="pinterest addthis_button_pinterest_share">Pinterest</a>' +
        '<li><a class="email addthis_button_email">Email</a></ul></div>';
    if (container.find('.share-wrapper').length) {
    	container.find('.share-wrapper').html(shareLinks);
    	container.find('.addthis_toolbox').hide();
    }

    container.find('.share a')
        .popover({
            html: true,
            placement: 'bottom'
        })
        .on('shown.bs.popover', function(){
            $('#social-bookmarks-container')
                .html(container.find('.addthis_toolbox')
                .clone()
                .show());
            var addthis_config = addthis_config||{};
            addthis_config.pubid = '5494611e5b33a7e7';
            addthis.init();
            addthis.toolbox('.addthis_toolbox');
        });
};

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

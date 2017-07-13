AUI().ready(

	/*
	This function gets loaded when all the HTML, not including the portlets, is
	loaded.
	*/

	function ( A ) {
		var customLayout = A.one( ".layout12_0212_0" );
		if ( customLayout ) {
			A.Do.before( function( option ) {
				if ( !option.placeHolder ) {
					option.placeHolder = A.Node.create("<div class='loading-animation'></div>");
				}
				option.placeHolder.prependTo("#column-3");
			},
			Liferay.Portlet, "add", Liferay.Portlet );
		}
	}
);

Liferay.Portlet.ready(

	/*
	This function gets loaded after each and every portlet on the page.

	portletId: the current portlet's id
	node: the Alloy Node object of the current portlet
	*/

	function(portletId, node) {
	}
);

Liferay.on(
	'allPortletsReady',

	/*
		This function gets loaded when everything, including the portlets, is on the page.
	*/

	function() {
	}
);
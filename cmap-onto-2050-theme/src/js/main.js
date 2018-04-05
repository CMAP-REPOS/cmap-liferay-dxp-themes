

window.cmap = window.cmap || {};
window.cmap.global = window.cmap.global || {};
window.cmap.global.init = window.cmap.global.init || function(){

	// alert('hello world');
	// console.log($);

	// $('.breadcrumb-cmap .close-button').addClass('hidden');

	// https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/tabindex
	$('a, button').each(function(){
		// http://api.jquery.com/attr/
		var tabindex = $(this).attr('tabindex');
		// console.log(this, tabindex);
		if(!tabindex){
			$(this).attr('tabindex', '0');
		}
	});

	$('input, textarea, select').each(function(){
		if($(this).val()){
			$(this).addClass('has-value');
		}
	});

	$('.share-button').click(function(){
		$('.close-button').removeClass('hidden');
		$('.share-menu').removeClass('hidden');
		$('.share-button').addClass('hidden');
	});
	$('.close-button').click(function(){
		$('.share-button').removeClass('hidden');
		$('.share-menu').addClass('hidden');
		$('.close-button').addClass('hidden');
	});
};
window.cmap.global.init




AUI().ready(

	/*
	This function gets loaded when all the HTML, not including the portlets, is
	loaded.
	*/

	function() {
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
	This function gets loaded when everything, including the portlets, is on
	the page.
	*/

	function() {

		window.cmap.global.init();
	}
);

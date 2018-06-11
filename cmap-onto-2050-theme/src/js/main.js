

window.cmap = window.cmap || {};
window.cmap.global = window.cmap.global || {};


window.cmap.global.anchors = window.cmap.global.anchors || {};
window.cmap.global.anchors.crawl = window.cmap.global.anchors.crawl || function(){
	var $this = $(this);
	var attr_name = $this.attr('name');
	var attr_id = $this.attr('id');
	var name = $this.text();

	var $button = $('<button class="page-anchor-button"><span class="sr-only">'+name+'</span><img class="page-anchor-icon" src="https://clarknelson.com/drop/ic_clipboard.svg" /></button>');
	var $link = $('<li><h4><a href="#'+attr_id+'">'+name+'</a></h4></li>');

	$link.click(function(e){
		e.preventDefault();

		var push = 0;
		if(window.Liferay.ThemeDisplay.isSignedIn()){
			push = push + $('.control-menu').innerHeight();
		}
		console.log(push, $('.control-menu').innerHeight());

		$('html,body').animate({
			scrollTop: $('#'+attr_id).offset().top - push
		}, 1000);
	});

	function copy_link_to_clipboard(){
		var $temp = $("<div>");
		$this.append($temp);
		$temp.attr("contenteditable", true)
				 .html(window.location.origin + window.location.pathname + '#' + attr_id).select()
				 .on("focus", function() { document.execCommand('selectAll',false,null) })
				 .focus();
		document.execCommand("copy");
		$temp.remove();
	}

	if(attr_name === attr_id){
		$('.page-nav .list-unstyled').append($link);
		$button.click(copy_link_to_clipboard);
		$this.click(copy_link_to_clipboard);
		$this.addClass('page-anchor');
		$this.prepend($button);
	}
}
window.cmap.global.anchors.init = window.cmap.global.anchors.init || function(){
	$('.onto2050-basic-web-content a').each(window.cmap.global.anchors.crawl);
};

window.cmap.global.init = window.cmap.global.init || function(){

	window.cmap.global.anchors.init();

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

/* This function gets loaded when all the HTML, not including the portlets, is loaded. */
AUI().ready(
	function() {
	}
);

/* This function gets loaded after each and every portlet on the page. */
Liferay.Portlet.ready(
	function(portletId, node) {
		// portletId: the current portlet's id
		// node: the Alloy Node object of the current portlet
	}
);

Liferay.on(
	'allPortletsReady',
	function() {
		window.cmap.global.init();
	}
);

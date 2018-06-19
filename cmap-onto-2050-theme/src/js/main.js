

window.cmap = window.cmap || {};
window.cmap.global = window.cmap.global || {};

window.cmap.global.anchors = window.cmap.global.anchors || {};
window.cmap.global.anchors.crawl = window.cmap.global.anchors.crawl || function(){
	var $this = $(this);
	var attr_name = $this.attr('name');
	var attr_id = $this.attr('id'); // should be == to previous if anchor
	var name = $this.text(); // actual text highlighted for anchor
	var url = window.location.origin + window.location.pathname + '#' + attr_id;

	var $button = $('<button class="page-anchor-button"><span class="sr-only">'+name+'</span><img class="page-anchor-icon" src="https://clarknelson.com/drop/ic_clipboard.svg" /></button>');
	var $link = $('<li><h4><a href="#'+attr_id+'">'+name+'</a></h4></li>');

	$link.click(function(e){
		e.preventDefault();

		var pull = 0; // we might need to pull the page a bit higher
		if(window.Liferay.ThemeDisplay.isSignedIn()){
			pull = pull + $('.control-menu').innerHeight();
		}

		history.replaceState({}, name, ('#' + attr_id));

		$('html,body').animate({
			scrollTop: $('#'+attr_id).offset().top - pull
		}, 1000);
	});

	if(attr_id !== undefined && attr_name !== undefined){
		if(attr_name === attr_id){
			$('.page-nav .list-unstyled').append($link);
			$button.click(()=>{
				window.cmap.global.copyToClipboard(url);
			});
			$this.click(()=>{
				window.cmap.global.copyToClipboard(url);
			});
			$this.addClass('page-anchor');
			$this.prepend($button);
		}
	}
}
window.cmap.global.anchors.init = window.cmap.global.anchors.init || function(){
	$('.onto2050-basic-web-content a').each(window.cmap.global.anchors.crawl);
};


window.cmap.global.scrollNav = window.cmap.global.scrollNav || {};
window.cmap.global.scrollNav.init = window.cmap.global.scrollNav.init || function(){

	var $banner = $('#banner'), $scroll_nav = $('#scroll-nav');
	if($banner.length && $scroll_nav.length){
		$(window).scroll(_.throttle(function(){
			var this_scroll = window.scrollY + $('#ControlMenu').innerHeight();
			var target_scroll = $banner.offset().top + $banner.innerHeight();
			if(this_scroll > target_scroll){
				$scroll_nav.addClass('active');
			} else {
				$scroll_nav.removeClass('active');
			}
		},100));
	}

	var $jumbo = $('.onto2050-basic-web-content .whitney-jumbo:first-of-type');
	var $huge = $('.onto2050-basic-web-content .whitney-huge:first-of-type');
	var $large = $('.onto2050-basic-web-content .whitney-large:first-of-type');

	function set_page_title(){
		$('#scroll-nav .page-title').text($(this).text());
	}
	if($jumbo.length){
		$jumbo.each(set_page_title);
	} else if ($huge.length) {
		$huge.each(set_page_title);
	} else if ($large.length) {
		$large.each(set_page_title);
	} else {
		console.log('No page title found for this page. Please use H1, H2, or Huge.');
	}


	$('.share-menu .page-url').val(window.location.href);

}

window.cmap.global.copyToClipboard = window.cmap.global.copyToClipboard || function(url){
	var $temp = $("<div>");
	$this.append($temp);
	$temp.attr("contenteditable", true)
			 .html(url).select()
			 .on("focus", function() { document.execCommand('selectAll',false,null) })
			 .focus();
	document.execCommand("copy");
	history.replaceState({}, name, ('#' + attr_id));
	$temp.remove();
}
window.cmap.global.setContentMinHeight = window.cmap.global.setContentMinHeight || function(){
	function compute(){
		var $banner_height = $('#banner').innerHeight();
		var $footer_height = $('#footer').innerHeight();
		$('#content').css('min-height', (window.innerHeight - ($banner_height + $footer_height)));
	}
	$(window).resize(_.throttle(compute));
	compute();
}
window.cmap.global.init = window.cmap.global.init || function(){

	window.cmap.global.setContentMinHeight();
	window.cmap.global.scrollNav.init();
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

	$('.jump-to-top-button').click(function(e){
		$('html,body').animate({
			scrollTop: 0
		}, 1000);
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

window.cmap = window.cmap || {};
window.cmap.global = window.cmap.global || {};

window.cmap.global.anchors = window.cmap.global.anchors || {};
window.cmap.global.anchors.crawl = window.cmap.global.anchors.crawl || function(){
	var $this = $(this);
	var attr_name = $this.attr('name');
	var attr_id = $this.attr('id'); // should be == to previous if anchor
	var name = $this.text(); // actual text highlighted for anchor
	var url = window.location.origin + window.location.pathname + '#' + attr_id;

	var $button = $('<button class="page-anchor-button"><span class="sr-only">'+name+'</span><img class="page-anchor-icon" src="/o/cmap-onto-2050-theme/images/icons/ic_clipboard.svg" /></button>');
	var $link = $('<li><span class="whitney-small bold"><a href="#'+attr_id+'">'+name+'</a></span></li>');

	$link.click(function(e){
		e.preventDefault();

		var pull = $('#scroll-nav').innerHeight(); // we might need to pull the page a bit higher
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
			$button.click(function(){
				copyToClipboard(url);
			});
			$this.click(function(){
				copyToClipboard(url);
			});
			$this.addClass('page-anchor');
			$this.prepend($button);
		}
	}

	function copyToClipboard(url){
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

	var $jumbo = $('.onto2050-basic-web-content .huge-headline:first-of-type');
	var $huge = $('.onto2050-basic-web-content .page-headline:first-of-type');

	function set_page_title(){
		$('#scroll-nav .page-title').text($(this).text());
	}
	if($jumbo.length){
		$jumbo.each(set_page_title);
	} else if ($huge.length) {
		$huge.each(set_page_title);
	} else {
		console.log('No page title found for this page. Please use H1, H2, or Huge.');
	}

	$('.share-menu .page-url').val(window.location.href);
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

window.cmap.global.headline_check = window.cmap.global.headline_check || function(){

	$('#breadcrumbs h1.hide-accessible').hide();

	var no_more_headlines = false, user_alerted = false;
	function check_for_el(name){
		var len = $(name).length;
		console.log(name + ' has ' + len + ' elements');
		if(len && no_more_headlines){
			if(!user_alerted){
				alert('There is a ' + name + ' headline breaking the accessibility rules. There is a larger headline to be used instead, please see the javascript console for more information')
				user_alerted = true; 
			}
		} else if (!len){
			no_more_headlines = true;
		}
		// $(name).each(function(){ console.log(this); });
	}

	check_for_el('h1');
	check_for_el('h2');
	check_for_el('h3');
	check_for_el('h4');
	check_for_el('h5');
	check_for_el('h6');

	if($('h1').length > 1){ alert('Two h1 elements are not allowed on the same page.'); }
}

window.cmap.pageCards = window.cmap.pageCards || {};
window.cmap.pageCards.init = window.cmap.pageCards.init || function(){

	$('.page-cards').each(function(){
		var $this = $(this);
		var $cards = $this.find('.page-card');
		var count = $cards.length;

		var $a = $($cards[0]);
		var $b = $($cards[1]);
		var $a_bot = $a.find('.bottom');
		var $b_bot = $b.find('.bottom');
		var $a_bot_h5 = $a_bot.find('h5');
		var $b_bot_h5 = $b_bot.find('h5');
		var a_bot_height, b_bot_height, padding;

		function calculate(){
			b_bot_height = $b_bot_h5.innerHeight();
			a_bot_height = $a_bot_h5.innerHeight();
			padding = parseInt($a.find('.bottom').css('padding'));
			if(a_bot_height > b_bot_height){
				$a_bot.css('height', a_bot_height + (padding * 2));
				$b_bot.css('height', a_bot_height + (padding * 2));
			} else {
				$a_bot.css('height', b_bot_height + (padding * 2));
				$b_bot.css('height', b_bot_height + (padding * 2));
			}
		}
		calculate();
		$(window).resize(_.throttle(calculate, 100));
	});
}

window.cmap.navigation = window.cmap.navigation || {};
window.cmap.navigation.menu_width = window.cmap.navigation.menu_width || null;
window.cmap.navigation.init = window.cmap.navigation.init || function(){
	var $menu = $('#mobile-navigation');

	function show_menu(){
		$menu.css('transform', 'translateX(0)');
		$menu.css('display', 'block');
	}
	function hide_menu(){
		$menu.css('transform', 'translateX(-'+window.cmap.navigation.menu_width+'px)');
		$menu.css('display', 'none');
	}
	function check_menu(){
		$menu.toggleClass('active');
		if($menu.hasClass('active')){
			show_menu();
		} else {
			hide_menu();
		}
	}

	function calculate(){
		var header_height = $('#heading').innerHeight();
		$('#mobile-navigation .header-row').css('height', header_height);

		$menu.css('width', 'auto');
		var expected_width = $menu.find('.site-nav').innerWidth();
		var menu_padding = parseInt($menu.css('padding-left'));
		window.cmap.navigation.menu_width = expected_width + (menu_padding * 2);
		$menu.css('width', window.cmap.navigation.menu_width);
	}

	calculate();
	$(window).resize(_.throttle(calculate, 100));

	$('#heading .hamburger').click(check_menu);
	$('#scroll-nav .hamburger').click(check_menu);
	$('#mobile-navigation .hamburger').click(check_menu);
	// hide_menu();
}

window.cmap.glossary = window.cmap.glossary || {};
window.cmap.glossary.init = window.cmap.glossary.init || function(){
	$('.glossary-term').each(function(){
		var $this = $(this);
		// console.log(this, $(this).parent('.glossary-term'), $(this).parents('.glossary-term').toggleClass('active'));
		$this.find('.term-name').click(function(){
			$this.toggleClass('active');
		});

		$this.find('.term-close').click(function(){
			$this.toggleClass('active');
		});
	}); 
}
window.cmap.global.check_images = window.cmap.global.check_images || function(){
	var bad_image_count = 0;
	$('img').each(function(){
		var $this = $(this), alt = $this.attr('alt');
		if(alt){
			console.log(this, ' has an alt tag of ', alt);
		} else {
			if($this.hasClass('company-logo')){ return true; } // this is only seen if logged in
			bad_image_count++;
			console.log("ALERT: ", this, ' does not have an alt tag');
		}
	});

	if(bad_image_count > 0){
		alert('There are ' + bad_image_count + ' images without alt tags on this page. See the javascript console for more information.');
	}
}


window.cmap.global.init = window.cmap.global.init || function(){

	window.cmap.global.check_images();
	window.cmap.global.headline_check();
	window.cmap.global.setContentMinHeight();
	window.cmap.global.scrollNav.init();
	window.cmap.global.anchors.init();
	window.cmap.navigation.init();
	window.cmap.pageCards.init();
	window.cmap.glossary.init();

	// $('.breadcrumb-cmap .close-button').addClass('hidden');

	// https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/tabindex
	$('a, button').each(function(){
		// http://api.jquery.com/attr/
		var tabindex = $(this).attr('tabindex');
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
		$('.breadcrumb-trail').addClass('hidden');
	});

	$('.close-button').click(function(){
		$('.share-button').removeClass('hidden');
		$('.share-menu').addClass('hidden');
		$('.close-button').addClass('hidden');
		$('.breadcrumb-trail').removeClass('hidden');
	});

	$('.jump-to-top-button').click(function(e){
		$('html,body').animate({
			scrollTop: 0
		}, 1000);
	});

	// removes empty paragraph tags
	$('p').each(function(){
		var $this = $(this);
		if($.trim($this.text()) == ''){ 
			if($this.find('img').length){ return; }
			console.log('removing empty paragraph tag', $this);
			$this.remove(); 
		}
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

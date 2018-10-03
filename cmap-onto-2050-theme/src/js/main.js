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
		console.log(attr_name, attr_id);
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
		var $a_bot = $a.find('.bottom-content');
		var $b_bot = $b.find('.bottom-content');
		var $a_bot_h5 = $a_bot.find('.normal-headline');
		var $b_bot_h5 = $b_bot.find('.normal-headline');
		var a_bot_height, b_bot_height, padding;
		

		for(var i=0; i<$cards.length; i=i+2){
			console.log(i);
		}

		function calculate(){
			b_bot_height = $b_bot_h5.innerHeight();
			a_bot_height = $a_bot_h5.innerHeight();
			padding = parseInt($a.find('.bottom').css('padding'));
			console.log(a_bot_height, b_bot_height, a_bot_height > b_bot_height)
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

window.cmap.hotspots = window.cmap.hotspots || function(){
	// what point does the caption flip around and open to the left
	var FLIP_CUTOFF = 0.5; // switch up there in the markup also

	$('.hotspot-widget').each(function(){
		var $hotspot = $(this);
		var $layers = $hotspot.find('.hotspot-layer');
		
		if($layers.length < 2){
			$hotspot.find('.hotspot-footer').css('display', 'none');
		}

		var $portlet_column = $hotspot.parents('.portlet-column');
		var $header = $hotspot.find('.hotspot-header');
		var $left = $header.find('.left');
		var $center = $header.find('.center');

		if($portlet_column.hasClass('col-md-8')){
			$center.addClass('col-md-10 col-sm-16');
			if($left.length){
				$left.addClass('col-md-3 col-sm-16');
			} else {
				$center.addClass('col-md-offset-3');
			}
		}

		if($portlet_column.hasClass('col-md-16')){
			$center.addClass('col-md-6 col-sm-16');
			if($left.length){
				$left.addClass('col-md-5 col-sm-16');
			} else {
				$center.addClass('col-sm-offset-5');
			}
		}

		$layers.each(function(i,el){
			var $el = $(el);
			var layer_name = $el.data('layer-name');
			var $nav_item = $('<div class="hotspot-layer-item" data-toggle="'+layer_name+'"><div class="whitney-normal bold">'+layer_name+'</div></div>');

			$nav_item.click(function(){
				var self = this;
				$('.hotspot-layer-item').removeClass('active');
				$(this).addClass('active');
				
				$('.mobile-hotspot-information ul').removeClass('active');
				$('.mobile-hotspot-information ul[data-layer-name="'+layer_name+'"]').addClass('active');

				$layers.each(function(i_b,el_b){
					if(el_b == el){
						$(el_b).removeClass('hidden');
					} else {
						$(el_b).addClass('hidden');
					}
				});
			});
			$hotspot.find('.hotspot-footer nav').append($nav_item);
		});


		$('.hotspot-spot').each(function(index){        
			var $this = $(this);

			var $background = $this.find('.caption-background');
			var $toggle = $this.find('.caption-toggle');
			$this.addClass('min');
			$background.css('width', $toggle.innerWidth());
			$background.css('height', $toggle.innerHeight());
			// the caption is too far to the left and we need to flip it

			if(parseInt($this.css('left')) / $hotspot.innerWidth() > FLIP_CUTOFF){
				$this.addClass('flipped');
			}
		});

		$hotspot.find('.mobile-hotspot-information ul').removeClass('active');      
		$hotspot.find('.mobile-hotspot-information ul:first-of-type').addClass('active');
		$layers.addClass('hidden');
		$hotspot.find('.hotspot-layer:first-of-type').removeClass('hidden');
		$hotspot.find('.hotspot-layer-item:first-of-type').addClass('active');
	});

	$('.caption-toggle').click(function(){
		var parent = $(this).parent().toggleClass('min');

		var toggle_width = $(this).innerWidth();
		var toggle_height = $(this).innerHeight();

		$('.hotspot-spot').each(function(index){
			var $this = $(this);
			var $background = $this.find('.caption-background');
			var $caption = $this.find('.caption-content');
			var $toggle = $this.find('.caption-toggle');

			if(this == parent[0]){
				if(parent.hasClass('min')){
					$background.css('width', toggle_width);
					$background.css('height', toggle_height);
				} else {
					var w = $this.hasClass('flipped') ? $caption.innerWidth() : $caption.innerWidth() + $toggle.innerWidth();
					$background.css('width', w);
					$background.css('height', $caption.innerHeight());
				}
			} else {
				$(this).addClass('min');
				$background.css('width', toggle_width);
				$background.css('height', toggle_height);
			}
		});
	});
}

window.cmap.global.check_images = window.cmap.global.check_images || function(){
	var bad_image_count = 0;
	$('img').each(function(){
		var $this = $(this), alt = $this.attr('alt'), src = $this.attr('src');
		
		if(!alt){
			if($this.hasClass('company-logo')){ return true; } // this is only seen if logged in
			if(src.search(/http(s)?/g)){
				console.log(src, src.search(/http(s)?/g));
				if(src.search(window.location.origin)){
					console.log(src, src.search(window.location.origin));
					bad_image_count++;
					return true; // the image is from a source that is not the current website
				}
			}
			// console.log("ALERT: ", this, ' does not have an alt tag');
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
	window.cmap.hotspots();

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

	$('.onto2050-endnote').each(function(i,el){
		var $el = $(el);
		
		var $page_title = $('#wrapper h1').clone();
		if(!$page_title.length){
			$page_title = $('#scroll-nav .desktop-row .page-title').clone();
		}
		console.log($page_title);
		$page_title.find('.section-sub-headline').remove();
		$page_title.find('br').remove();
		var page_title = $page_title.text().replace(/,/g,'').replace(/ /g,'-').replace(/\'/g, '');
		page_title = page_title.toLowerCase().trim();

		var reference = $el.attr('reference');
		var endnotes_page = $el.attr('endnote-page');
		if(!endnotes_page){
			endnotes_page = '/2050/endnotes';
		}

		$el.append('<span id="endnote-'+(i+1)+'" class="onto2050-endnote-anchor"></span>');
		$el.after('<a class="onto2050-endnote-dot" href="'+endnotes_page+'#'+page_title+'-endnote-'+(i+1)+'" title="'+reference+'" target="_blank">'+(i+1)+'</a>');
	});

	$('.onto2050-actions .mobile-headline').append('<span class="sr-only">:</span>');

	$('.advertisement').each(function(){
		var $this = $(this);
		$this.find('.col-md-8').removeClass('col-xs-16 col-sm-12').addClass('col-sm-16');

		var widget_height = $this.innerWidth() / 2, 
				background_height = $this.find('.background img').innerHeight(), 
				content_height = $this.find('.cmap-ad-content').innerHeight();
		var final_height = Math.max(widget_height, background_height, content_height);

		console.log(final_height, widget_height, background_height, content_height);
		$this.css('min-height', final_height);
		$(window).resize(_.throttle(function(){
			$this.css('min-height', final_height);
		}, 100));
	});

	var push = 0;
	if($('#scroll-nav').length){
		push += $('#scroll-nav').innerHeight();
	}
	if($('#ControlMenu').length){
		push += $('#ControlMenu').innerHeight();
	}

	$('.onto2050-endnote').each(function(){
		$(this).find('.onto2050-endnote-anchor').css('height', push + $(this).innerHeight());
	});

	
	$(window).load(function(){
		if(window.location.hash){
			var jump_to_hash = setInterval(function(){
				if($(window.location.hash).length){
					var offset = $(window.location.hash).offset().top;
					$('html,body').animate({
						scrollTop: offset
					}, 800);
					clearInterval(jump_to_hash);
				}
			}, 100);
		}
	});
};


window.youtube_url_parser = function(url){
	var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
	var match = url.match(regExp);
	return (match&&match[7].length==11)? match[7] : false;
}

window.set_iframe_video_size = function($iframe){

	var is_full_width = $iframe.parents('.portlet-layout').find('.col-md-16').length > 0 ? true : false;
	var iframe_width, iframe_height;

	function get_iframe_size(){
		iframe_width = $iframe.attr('width');
		iframe_height = $iframe.attr('height');
	}

	function set_iframe_size(){
		if(is_full_width){
			$iframe.css('width', window.innerWidth);
			$iframe.css('height', (window.innerWidth / iframe_width) * iframe_height);
			$iframe.parents('.onto2050-video-widget').find('.video-container').addClass('row');
		} else {
			var width = $iframe.parents('.portlet-layout').find('.col-md-8 .portlet-dropzone').innerWidth();
			$iframe.css('width', width);
			$iframe.css('height', (width / iframe_width) * iframe_height);
		}
	}
	
	get_iframe_size();
	set_iframe_size();

	$(window).resize(_.throttle(function(){
		get_iframe_size();
		set_iframe_size();
	}, 100));
}

window.onYouTubeIframeAPIReady = function(){

	for(var i in window.video_frames){
		var video_id = window.youtube_url_parser(window.video_frames[i]);

		if(video_id){
		
			var current_index = i;
			var final_options;
			var default_options = {
				controls: 1,
				modestbranding: 1,
				rel: 0,
				showinfo: 0,
			};

			if(window.video_autoplay[i]){
				final_options = Object.assign(default_options, {
					autoplay: 1,
				});
			}
			if(window.video_loop[i]){
				final_options = Object.assign(default_options, {
					loop: 1,
					playlist: video_id,
				});
			}
			final_options = Object.assign(default_options, {});

			window.video_player[i] = new YT.Player($(window.video_ids[i]+'video')[0], {
				width: 1280,
				height: 720,
				videoId: video_id,
				playerVars: final_options,
				events: {
					'onReady': function(event){
						window.set_iframe_video_size($(event.target.getIframe()));
					}
				}
			});
		}
	}
}

/* This function gets loaded when all the HTML, not including the portlets, is loaded. */
AUI().ready(function(){ });

/* This function gets loaded after each and every portlet on the page. */
Liferay.Portlet.ready(function(portletId, node){ });

Liferay.on('allPortletsReady', function(){ window.cmap.global.init(); });

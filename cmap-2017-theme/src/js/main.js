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



// I don't know what i'm doing...
// Lets put all the JS here!
Liferay.on('allPortletsReady', function() {




  // SIDE NAV WIDGET
  var sideNavOpen = false;

  var $sideNav = $('#side-nav');
  var $wrapper = $('#wrapper');

  function listenForSideNav($hamburger){
    $hamburger.on('click', ()=>{
      $hamburger.toggleClass('is-active');
      var sideNavWidth = $sideNav.outerWidth();

      $wrapper.toggleClass('side-nav-active');
      $sideNav.toggleClass('side-nav-active');

      if(sideNavOpen){
        $wrapper.css('left', '0');
        sideNavOpen = false;
      } else {
        $wrapper.css('left', `${sideNavWidth}px`);
        sideNavOpen = true;
      }
    });
  }

  listenForSideNav($('#main-header .hamburger'));
  listenForSideNav($('#scroll-nav .hamburger'));



  // TEXT SIZE WIDGET
  var $textSizeOptions = $('#side-nav .change-text-size .option');
  $textSizeOptions.click(function(){
    $textSizeOptions.removeClass('active');
    $(this).addClass('active')
  });



  // SCROLL NAV
  var headerHeight = $('#main-header .nav-row-one').innerHeight();
  console.log(headerHeight);
  var $scrollNav = $('#scroll-nav');

  function checkForScrollNav(){
    if(window.scrollY > headerHeight){
      $scrollNav.addClass('active');
    } else {
      $scrollNav.removeClass('active');
    }
  }
  checkForScrollNav();
  $(window).scroll(_.throttle(checkForScrollNav, 50));


  // Title with Sections - Jump to section

  $('.page-nav-item a').click(function(e){
    e.preventDefault();
    var push = $('#scroll-nav').innerHeight();
    console.log(this.href, this, push);
  });

  $('#jump-to-top').click(function(){
    $('html,body').animate({
      scrollTop: 0
    }, 800);
  });

  setUpYoutube();

});



function setUpYoutube(){
  $('.iframe-container iframe').each(function(){
    var $this = $(this);

    function addLodash(){
      var head = document.getElementsByTagName('head')[0];
      var script = document.createElement('script');
      script.type = 'text/javascript';
      script.src = 'https://raw.githubusercontent.com/lodash/lodash/4.17.4/dist/lodash.core.min.js';
      head.appendChild(script);
    }

    function setHeight(){
      var ratio = parseFloat($this.attr('longdesc'), 10);
      var width = $this.innerWidth();
      var height = Math.floor(width / ratio);
      $this.css('height', height);
    }

    function findID(src){
      var code_offset = src.indexOf('/embed/');
      if(code_offset >= 0){
        // remove the beginning of the URL
        var final = src.substring(code_offset + 7);

        // finds params if they are included
        var or = final.indexOf('?');
        var and = final.indexOf('&');
        var end = or > and ? and : or;

        // remove the end of the URL
        if(end){ final = final.substring(0,end); }
        return final;
      }
    }

    function addVideoTagline(data){
      var title = data.items[0].snippet.title;
      var link = `https://youtu.be/${data.items[0].id}`;
      var $container = $('<div class="video-tagline"></div>');
      var $icon = $('<div class="icon"> <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"> <g fill="#3C5976" fill-rule="evenodd"> <path fill-rule="nonzero" d="M9,17.5 C4.30585763,17.5 0.5,13.6941424 0.5,9 C0.5,4.30585763 4.30585763,0.5 9,0.5 C13.6941424,0.5 17.5,4.30585763 17.5,9 C17.5,13.6941424 13.6941424,17.5 9,17.5 Z M9,16.5 C13.1418576,16.5 16.5,13.1418576 16.5,9 C16.5,4.85814237 13.1418576,1.5 9,1.5 C4.85814237,1.5 1.5,4.85814237 1.5,9 C1.5,13.1418576 4.85814237,16.5 9,16.5 Z"/> <polygon points="6.8 5.75 6.8 12.25 12.8 8.75"/> </g> </svg> </div>');
      var $data = $('<div class="video-data"> <span class="whitney-normal"> Watch <a class="underline-link" href="'+link+'" target="_blank">'+title+'</a> on YouTube </span> </div>');
      $container.append($icon);
      $container.append($data);
      $this.parent().append($container);
    }

    function addVideoCaption(){
      var vid = findID($this.attr('src'));
      $.getJSON("https://www.googleapis.com/youtube/v3/videos", {
        key: "AIzaSyC7Ab6y-6mvks4oPwdc4vMkXoKFQXBsc5E",
        part: "snippet,statistics",
        id: vid
      }, function(data) {
        if (data.items.length === 0) {
          console.error('YOUTUBE: ', 'Problem finding the video you want.');
          return;
        }
        addVideoTagline(data);
      }).fail(function(jqXHR, textStatus, errorThrown) {
        console.error('YOUTUBE: ', 'Problem making a request to get video metadata.');
      });
    }

    addLodash();
    setHeight();
    $(window).resize(_.debounce(function(){
      setHeight();
    }, 100));

    addVideoCaption();

  });

}

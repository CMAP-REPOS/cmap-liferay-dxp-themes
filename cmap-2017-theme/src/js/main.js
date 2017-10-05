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


});

var cmap = cmap || {};
cmap.global = {};

cmap.global.share = function () {
  $('.close-button').hide();
  $('.share-menu .page-url').val(window.location.href);
  $('.share-menu .page-url').on('focus', function () {
    setTimeout(function () { this.select(); }, 100);
  });

  function toggleSocial(container, original) {
    var $container = $(container);
    var $sharebtn = $container.find('.share-button');
    var $closebtn = $container.find('.close-button');
    var $sharemenu = $container.find('.share-menu');
    var $original = $container.find(original);

    $sharebtn.click(function () {
      $sharemenu.addClass('active');
      $original.removeClass('active');
      $sharebtn.css('display', 'none');
      $closebtn.css('display', 'inline-flex');
    });
    $closebtn.click(function () {
      $original.addClass('active');
      $sharemenu.removeClass('active');
      $closebtn.css('display', 'none');
      $sharebtn.css('display', 'inline-flex');
    });
  }
  toggleSocial('nav.breadcrumb', '.breadcrumb-trail');
  toggleSocial('#scroll-nav', '.page-title');
  toggleSocial('#side-nav', '.dummy-div');

};

cmap.global.sidenav = function () {
  // SIDE NAV WIDGET
  var sideNavOpen = false;

  var $sideNav = $('#side-nav');
  var $wrapper = $('#wrapper');
  var $hamburgers = $('#main-header .hamburger, #scroll-nav .hamburger');

  $hamburgers.on('click', function() {
    var sideNavWidth = $sideNav.outerWidth();

    $hamburgers.toggleClass('is-active');
    $wrapper.toggleClass('side-nav-active');
    $sideNav.toggleClass('side-nav-active');
    $('#scroll-nav .logo').toggleClass('hidden');

    if (sideNavOpen) {
      $wrapper.css('left', '0');
      sideNavOpen = false;
    } else {
      $wrapper.css('left', sideNavWidth+'px');
      sideNavOpen = true;
    }
  });
};

cmap.global.scrollnav = function () {
  // SCROLL NAV
  var headerHeight = $('#main-header .nav-row-one').innerHeight();
  var $scrollNav = $('#scroll-nav');

  function checkForScrollNav() {
    if (window.scrollY > headerHeight) {
      $scrollNav.addClass('active');
    } else {
      $scrollNav.removeClass('active');
    }
  }
  checkForScrollNav();
  $(window).scroll(_.throttle(checkForScrollNav, 50));
};

cmap.global.footerjumptotop = function () {
  setTimeout(function () {
    $('.jump-to-top-button').on('click', function () {
      $('html,body').animate({
        scrollTop: 0
      }, 800);
    });
  }, 1000);
};

cmap.global.youtube = function () {
  $('.iframe-container iframe').each(function () {
    var $this = $(this);

    function setHeight() {
      // var ratio = parseFloat($this.attr('longdesc'), 10);
      var width = $this.innerWidth();
      var height = Math.floor((width / 16)*9);

      setTimeout(function(){
        $this.attr('height', height+'px');
        $this.css('height', height);
      }, 500);
    }

    function findID(src) {
      var re = /^.*(youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
      var match = src.match(re);
      var videoId = '';
      if (match && match.length === 3 && match[2].length === 11) {
        videoId = match[2];
      }
      return videoId;
    }

    // Builds the tagline in the DOM based on the API response
    function addVideoTagline(data) {
      var title = data.items[0].snippet.title;
      var link = 'https://youtu.be/{id}'.replace('{id}', data.items[0].id);
      var $container = $('<div class="video-tagline"></div>');
      var $icon = $('<div class="icon"> <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"> <g fill="#3C5976" fill-rule="evenodd"> <path fill-rule="nonzero" d="M9,17.5 C4.30585763,17.5 0.5,13.6941424 0.5,9 C0.5,4.30585763 4.30585763,0.5 9,0.5 C13.6941424,0.5 17.5,4.30585763 17.5,9 C17.5,13.6941424 13.6941424,17.5 9,17.5 Z M9,16.5 C13.1418576,16.5 16.5,13.1418576 16.5,9 C16.5,4.85814237 13.1418576,1.5 9,1.5 C4.85814237,1.5 1.5,4.85814237 1.5,9 C1.5,13.1418576 4.85814237,16.5 9,16.5 Z"/> <polygon points="6.8 5.75 6.8 12.25 12.8 8.75"/> </g> </svg> </div>');
      var $data = $('<div class="video-data"> <span class="whitney-small__bold"> Watch <a class="underline-link" href="' + link + '" target="_blank">' + title + '</a> on YouTube </span> </div>');
      $container.append($icon);
      $container.append($data);

      var $grid = $('<div class="row"> <div class="col-xl-3 col-sm-16"></div> <div class="col-xl-10 col-sm-12 col-xs-16"></div> <div class="col-xl-3 col-sm-16"></div> </div>');

      if($this.parents('.portlet-full-width').length){
        $grid.find('.col-xl-10').append($container);
        $this.parent().append($grid);
      } else {
        $this.parent().append($container);
      }
      // $this.parent().append($container);
    }

    // Searches for information about the video like title and url
    function addVideoCaption() {
      var vid = findID($this.attr('src'));
      $.getJSON("https://www.googleapis.com/youtube/v3/videos", {
        key: "AIzaSyC7Ab6y-6mvks4oPwdc4vMkXoKFQXBsc5E",
        part: "snippet,statistics",
        id: vid
      }, function (data) {
        if (data.items.length === 0) {
          console.error('YOUTUBE: ', 'Problem finding the video you want.');
          return;
        }
        addVideoTagline(data);
        setHeight();
      }).fail(function (jqXHR, textStatus, errorThrown) {
        console.error('YOUTUBE: ', 'Problem making a request to get video metadata.');
      });
    }

    $this.on('load', function(){
      setHeight();
    });
    $this.on('ready', function(){
      setHeight();
    });

    $(window).resize(_.debounce(function () {
      setHeight();
    }, 100));

    addVideoCaption();

  });
};

cmap.global.loginpage = function () {
  // LOGIN PAGE
  if ($('.portlet-login').length) {
    $('body').addClass('login-page');

    var $container = $('.login-page #main-content > .row > .col-md-12');
    $container.removeClass('col-md-12');
    $container.addClass('col-xl-10 col-xl-push-3 col-sm-12 col-sm-push-2 col-xs-16 col-xs-push-0');
  }
};

cmap.global.checkforh1 = function () {

  // there should only be one h1 tag per page for SEO reasons
  // we are going to take some liferay h1s and convert them to <div>
  function convertToDiv(element) {
    var $this = $(element);
    var classes = $this.attr('class');
    var content = $this.text();
    $this.replaceWith('<div class="' + classes + '">' + content + '</div>');
  }

  $('h1').each(function () {
    if ($(this).hasClass('hide-accessible')) {
      convertToDiv(this);
    } else {
      console.log(this);
      cmap.global.scrollnavTitle($(this).text());
    }
  });
};
cmap.global.updateSlider = function() {
  // TODO: Insert the code from the JSP component
}

cmap.global.scrollnavTitle = function (text) {
  if (window.location.pathname === '/' ||
    window.location.pathname === '/home' ||
    window.location.pathname === '/home/' ||
    window.location.pathname === '/web/guest/') { return; }
  // there is already a page title!
  if ($('#scroll-nav .col-xl-10 .page-title').length) { return; }
  $('#scroll-nav .col-xl-10').append('<h4 class="page-title active">' + text + '</h4>');
};

cmap.global.addpageclass = function () {
  var rawPath = Liferay.currentURL.substring(1);
  var noWebGuest = rawPath.replace(/web\/guest\//g, '');
  var noSlash = noWebGuest.replace(/\//g, '-');
  var final = '';

  if (noSlash === '') {
    final = 'home-page';
  } else {
    final = noSlash + '-page';
  }

  console.log(rawPath, noWebGuest, noSlash, final);
  $('body').addClass(final);
};

cmap.forms = {};

cmap.forms.contactus = function () {

  var $contact_form = $('.contact-page');
  if ($contact_form.length) {

    // add section headers to form
    var $info_header = $('<header><hr><h3 class="whitney-normal__bold">Information</h3></header>');
    $contact_form.find('.lfr-ddm-form-page').before($info_header);

    var $message_header = $('<header><hr><h3 class="whitney-normal__bold">Message</h3></header>');
    $contact_form.find('.row:nth-of-type(3)').after($message_header);

    $contact_form.find('.col-md-6').removeClass('col-md-6').addClass('col-xl-8 col-sm-16');

    // var $captcha = $contact_form.find('.lfr-ddm-form-page .row:last-of-type .form-group');
    // $contact_form.find('.row:nth-of-type(4) .col-xl-8:last-of-type').append($captcha);

    $('.lfr-ddm-form-submit').removeClass('pull-right');
    $('.lfr-ddm-form-submit').text('Send');

  }
};

cmap.forms.global = function () {

  var $form = $('.portlet-forms');
  console.log($form);
  if ($form.length) {

    $form.find('.ddl-form-builder-app').removeClass('container-fluid-1280');

    var $form_info = $form.find('.ddl-form-basic-info');
    if ($form_info.length) {

      $form_title = $form_info.find('.ddl-form-name');
      if ($form_title.length) {
        $form_title.unwrap();
        $form_title.addClass('whitney-huge');
      }
      $form_description = $form_info.find('.ddl-form-description');
      if ($form_description.length) {
        $form_description.unwrap();
        $form_description.addClass('presna-normal');
      }
    }

    var $form_body = $form.find('.lfr-ddm-form-content');
    if ($form_body.length) {

      var $form_pages = $form_body.find('.lfr-ddm-form-page');
      $form_pages.each(function () {
        var $page = $(this);
        var $required_warning = $page.find('.required-warning').remove();

        $page.after($required_warning);
      });
    }
  }

  $('input').change(function () {
    if ($(this).val() !== '') {
      $(this).addClass('has-value');
    }
  });
};

cmap.forms.replaceAst = function () {
  var $foo = $('.lexicon-icon-asterisk');
  if ($foo.length) {
    var p = $foo.parent();
    $foo.remove();
    p.append('●');
  }
};

cmap.footer = {};
cmap.footer.checkForLayoutChange = function () {

  var $footer = $('#footer'), $row = $footer.find('.row');
  var $jump = $footer.find('.footer-jump-to-top');
  var $pages = $footer.find('.footer-page-links');
  var $social = $footer.find('.footer-social-links');

  function clean() {
    $jump.remove();
    $pages.remove();
    $social.remove();
  }
  function desktop() {
    clean();
    $row.append($jump);
    $row.append($pages);
    $row.append($social);
  }
  function mobile() {
    clean();
    $row.append($pages);
    $row.append($jump);
    $row.append($social);
  }
  function check() {
    if (window.innerWidth < 1000) {
      mobile();
    } else {
      desktop();
    }
  }
  check();
  $(window).resize(_.throttle(check, 100));
};

// Runs when.. all the portlets are loaded and ready
Liferay.on('allPortletsReady', function () {

  cmap.global.addpageclass();
  cmap.global.sidenav();
  cmap.global.scrollnav();
  cmap.global.footerjumptotop();
  cmap.global.checkforh1();
  cmap.global.updateSlider();
  cmap.global.youtube();
  cmap.global.loginpage();
  cmap.global.share();

  cmap.forms.contactus();
  cmap.forms.global();
  cmap.forms.replaceAst();

  cmap.footer.checkForLayoutChange();

  $('table *').removeAttr('valign');
  $('table').removeAttr('align');
});

// Runs once for each portlet on the page, with info about that portlet
Liferay.Portlet.ready(function (portletId, node) {
  // console.log(portletId, node);
});

// Runs once the DOM is finished. Better to use "allPortletsReady"
$(document).ready(function () { });

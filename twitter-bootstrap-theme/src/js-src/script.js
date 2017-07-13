
(function( window, $ ) {
  $.fn.responsiveArrowDropdown = function(options) {
    var settings = $.extend({
      triggerSelector: ''
    }, options );
    return this.each(function(id,el) {
      var $trigger = $(options.triggerSelector);
      var $this = $(el);
      $this.wrap('<div class="rad-wrapper" style="display: none"></div>');
      var $dropdown = $this.closest('.rad-wrapper');
      $dropdown.prepend('<div class="rad-arrow-holder"></div>');
      var $arrowHolder = $dropdown.children('.rad-arrow-holder');

      $(window).resize(function(e) {
        if ($trigger.hasClass('open')) {

          console.log($this);
          console.log($trigger.attr('id'));
        	$dropdown.css('top', ($trigger.position().top + $trigger.innerHeight()) + 'px');
    	    var thisPageCenter = $trigger.offset().left + ($trigger.innerWidth()/2);
    	    var thisContainerCenter = $trigger.position().left + ($trigger.innerWidth()/2);
    	    var dropdownParentPageLeft = $dropdown.parent().offset().left;
          var dropdownPageLeft = $dropdown.offset().left;
          var dropdownPageRight = dropdownPageLeft + $dropdown.innerWidth();
          var windowWidth = $(window).width();
    	    var dropdownParentContainerLeft = $dropdown.parent().position().left;
    	    var dropdownParentContainerLeftDistance = dropdownParentPageLeft - 0;
    	    if ($(window).width() > 420) {
    	      $dropdown.css('min-width', '260px');
            $dropdown.css('width', 'auto');
    	      $dropdown.css('left', 'auto');
            $dropdown.children().css('padding-left', '0px');
            $dropdown.children().css('padding-right', '0px');
            var leftMargin = ((thisPageCenter-dropdownParentContainerLeftDistance)- ($dropdown.innerWidth()/2));
            $dropdown.css('margin-left', leftMargin + 'px');
            dropdownPageLeft = $dropdown.offset().left;
            dropdownPageRight = dropdownPageLeft + $dropdown.innerWidth();
            if (dropdownPageLeft + leftMargin < 0) {
              console.log("ADJUSTING MARGIN L: ");
              console.log("old margin: " + leftMargin);
              console.log("dropdown page left: " + dropdownPageLeft);
              leftMargin = 0;//-= (dropdownPageLeft + leftMargin);
              console.log("new margin: " + leftMargin);
            } else if (dropdownPageRight > windowWidth) {
              console.log("ADJUSTING MARGIN R: ");
              console.log("old margin: " + leftMargin);
              console.log("dropdown width: " + $dropdown.width());
              console.log("dropdown page right: " + dropdownPageRight);
              console.log("window width: " + windowWidth);
              leftMargin = (windowWidth - dropdownPageRight) + leftMargin;
              console.log("new margin: " + leftMargin);
            }
    	      $dropdown.css('margin-left', leftMargin + 'px');
            var dropdownPageCenter = $dropdown.offset().left + ($dropdown.innerWidth()/2);
            if (dropdownPageCenter != thisPageCenter) {
              console.log("ADJUSTING ARROW: ");
              console.log("triggerCenter: " + thisPageCenter);
              console.log("dropdownCenter: " + dropdownPageCenter);
              $arrowHolder.css('margin-left', 2*(thisPageCenter - dropdownPageCenter) + 'px');
            } else if (dropdownPageCenter < thisPageCenter) {
              console.log("ADJUSTING ARROW: ");
              console.log("triggerCenter: " + thisPageCenter);
              console.log("dropdownCenter: " + dropdownPageCenter);
              $arrowHolder.css('margin-left', 2*(thisPageCenter - dropdownPageCenter) + 'px');
            } else {
              $arrowHolder.css('margin-left', '0');
            }
    	    } else {
    	      var displacementLeft = thisPageCenter;
    	      var displacementRight = $(window).width() - thisPageCenter;
            $arrowHolder.css('margin-left', '0');
    	      if (displacementLeft >= displacementRight) {
    	      	$dropdown.css('width', (displacementLeft*2)+'px');
    	        $dropdown.css('left', 'auto');
    	        $dropdown.css('margin-left', (-dropdownParentContainerLeftDistance) + 'px');
    	        $dropdown.children().css('padding-left', '0px');
    	        $dropdown.children().css('padding-right', (displacementLeft - displacementRight) + 'px');
    	      } else {
    	      	$dropdown.css('width', (displacementRight*2)+'px');
    	        $dropdown.css('left', 'auto');
    	        $dropdown.css('margin-left', (-((displacementRight - displacementLeft) + dropdownParentContainerLeftDistance)) + 'px');
    	        $dropdown.children().css('padding-left', (displacementRight - displacementLeft) + 'px');
    	        $dropdown.children().css('padding-right', '0px');
    	      }
    	    }
        }
      });

    $trigger.click(function(e) {
      e.preventDefault();
      $dropdown.toggle();
      $trigger.toggleClass('open');
      $(window).resize();
    });

	  });


    return this;
  };
}( window, jQuery ));


(function($) {

$.fn.randomizeInGroups = function(parentSelector, childSelector) {
	  return this.each(function() {
	      var $this = $(this);
	      var parentElems = $this.find(parentSelector);
	      var childElems = $this.find(childSelector);
	      var parentCount = parentElems.length;
	      var childCount = childElems.length;
	      var numPerParent = Math.round(childCount/parentCount);

	      childElems.sort(function() { return (Math.round(Math.random())-0.5); });

	      $this.remove(childSelector);
	      var counter = 0;
	      for(var i=0; i < parentCount; i++) {
	    	  for (j=0;j<numPerParent;j++) {
	    		  if (counter >= childCount) break;
	    		  $(parentElems[i]).append(childElems[counter++]);
	    	  }
	      }

	  });


}

jQuery.fn.triggerEmailForm = function(eventId, eventTimestamp) {
		jQuery('input[id*="_EventId"]').val(eventId);
		jQuery('input[id*="_EventTimestamp"]').val(eventTimestamp);
		jQuery('#p_p_id_1_WAR_EmailFormportlet_').dialog({
		      modal: true,
		      width: '360px',
		      dialogClass: 'event-email-popover'
		    });
		jQuery('.event-email-popover').css({'position': 'absolute'});
		jQuery('#p_p_id_1_WAR_EmailFormportlet_').dialog({
		      modal: true,
		      width: '360px',
		      dialogClass: 'event-email-popover'
		    });
		jQuery('.event-email-popover').css({'position': 'absolute'});
		jQuery('.ui-dialog-titlebar-close').focus();
		return false;
}

})(jQuery);

(function($) {
  // NOTES
  // getting the last pathname via js - window.location.pathname.split('/').pop()

  // Vars
  var $secondary = $('.secondary');
  var $primary = $('.primary');
  $(function() {

    var leadText, typeAheadSource, typeAheadSelect;

    // on mobileSize/desktopSize events, remove/add classes in the #footer
    if ( $('body').hasClass('homepage') || $('.eventslayout').length ) {
      $('#footer .row-fluid').children().removeClass('span9 pull-right');
    } else {
      $('#footer').on({
        mobileSize: function () {
            $('#footer .row-fluid').children().removeClass('span9 pull-right');
        },
        desktopSize: function () {
          $('#footer .row-fluid').children().addClass('span9 pull-right');
        }
      });
    }

    // on mobileSize/desktopSize events, remove/add .constrain class
    $('.portlet-boundary').on({
      mobileSize: function () {
        $('.portlet-boundary.constrain').removeClass('constrain').addClass('no-constrain');
      },
      desktopSize: function() {
        $('.portlet-boundary.no-constrain').addClass('constrain').removeClass('no-constrain');
      }
    });

    // on mobileSize/desktopSize events, remove/add mobile fade to homepage featured slider
    $('.slider-featuring .slide').on({
      mobileSize: function () {
        $(this).find('.mobile-fade').show();
      },
      desktopSize: function() {
        $(this).find('.mobile-fade').hide();
      }
    });

    // Clone breadcrumbs to the primary block
    $breadcrumbs = $(this).find('.portlet-breadcrumb').clone(true);
    $('.primary').find('.portlet-dropzone').prepend($breadcrumbs);

    // add event link to the main navigation list
    var eventLink = $('.header-main .events').clone(true);
    $('.mega-menu.items').append(eventLink.addClass('root-cat-li'));
    // add search bar to the main navigation list\
    desktopSearchItem = $('#_lookaheadsearch_WAR_CustomPortletsportlet_fm');
    mobileSearchItem = $('<li />', {'class': 'root-cat-li search'}).append(desktopSearchItem.clone(true));
    $('.mega-menu.items').append(mobileSearchItem);
    var startMobileSearchScrollTop = jQuery('.taxonomynav-portlet').offset().top;
    mobileSearchItem.find('.look-ahead-keyword').focus(function(e) {
        var eventTarget = $(e.target);
        if (jQuery(window).width() <= 768) {
        	setTimeout(function() {
              window.scrollTo(0, 0);
              document.body.scrollTop = 0;
	            var metaData = jQuery('.header-main');
	            var metaDataHeight = metaData.height();
	            //var newScrollTop = eventTarget.offset().top - (10 + metaDataHeight + metaData.position().top); //metaData.position().top + metaData.height() + eventTarget.position().top - 10;
	            //var newScrollTop = eventTarget.position().top - 10;
	            var newScrollTop = $('ul.mega-menu').children('li.search').offset().top - metaDataHeight;
	            console.log("newScrollTop:"+newScrollTop);
	            var curScrollTop = jQuery('.nav-main').offset().top;
	            console.log("curScrollTop:"+curScrollTop);
	            if (curScrollTop != newScrollTop) {
	              var duration = Math.abs(newScrollTop - curScrollTop)*2;
	              if (duration > 500) duration = 500;
	              jQuery('.nav-main').animate({
	                      top: (-newScrollTop) + "px"
	                  }, duration
	              );
	            }
	        }, 0);
        }
    }).blur(function(e) {
    	var eventTarget = $(e.target);
        if (jQuery(window).width() <= 768) {
          var metaData = jQuery('.header-main');
          var metaDataHeight = -6;
          if (metaData.css('position') != 'fixed')
            metaDataHeight = metaData.height();
          var curScrollTop = eventTarget.offset().top;
          console.log("curScrollTop:"+curScrollTop);
          var newScrollTop = 0;
          console.log("newScrollTop:"+newScrollTop);
          if (curScrollTop != newScrollTop) {
            var duration = Math.abs(newScrollTop - curScrollTop)*2;
            if (duration > 500) duration = 500;
            jQuery('.nav-main').animate({
                    top: (newScrollTop) + "px"
                }, duration
            );
          }
        }
    });

    if ($(window).width() <= 768) {
    	mobileSearchItem.find('.look-ahead-keyword')
    		.attr('placeholder', 'Search')
    		.autocomplete({
	            minLength: 2,
	            source: typeAheadSource,
	            select: typeAheadSelect,
	            position: {
	                  my: "center top+10",
	                  at: "center bottom",
                  collision: "none"
	            }

    	});
    } else {
    	desktopSearchItem.find('.look-ahead-keyword')
		.autocomplete({
            minLength: 2,
            source: typeAheadSource,
            select: typeAheadSelect
	});
    }




    // mobile remove class for the share block
    $('.meta-data .share-this-block').on({
      mobileSize: function() {
        $(this).removeClass('span2');
      },
      desktopSize: function() {
        $(this).addClass('span2');
      }
    });

    // Check if there are any secondary nav items
    if ( !$('.secondary .nav-menu li').length ) {
      $('.secondary .menu-heading').hide();
    } else {
    	$('.secondary .menu-heading').show();
    }

    // Accordion lists
    $('.accordion-list').accordionList();

    if(!document.getElementsByClassName) {
        document.getElementsByClassName = function(className) {
            return this.querySelectorAll("." + className);
        };
        Element.prototype.getElementsByClassName = document.getElementsByClassName;
    }

    // Search link and bar
      $('.nav-meta .search').on('click', 'a', function () {
        $('.page').toggleClass('searchbar-active');
        $("#_lookaheadsearch_WAR_CustomPortletsportlet_keyword").focus();
        return false;
      });
    /* ! Search link and bar */

    // Main menu active item via Breadcrumb
    var mainMenuItemCurrent = function() {
      var $breadCrumb = $('.breadcrumbs-horizontal');
      if ($breadCrumb.length > 0) {
        var menuName = $breadCrumb.find('li').first().text();
        var $menuItems = $('.nav-main').first().find('a');
        for (var i = 0; i < $menuItems.length; i++) {
          if ($menuItems.eq(i).text() === menuName) {
            $menuItems.eq(i).parent().addClass('current');
          }
        }
      }
    };
    mainMenuItemCurrent();

    // AddThis Widget
    // TODO: Pull all those styles in a sheet and do for tablet only
    var $shareModule = $('<div id="shareModule" class="row-fluid"><div class="span10"></div><div class="share-this-block span2"><label for="share-this-toggle" id="share-this-label" class="share"><span class="icon">Share</span></label><div class="share-wrapper drilldown"></div></div></div>');
    if ( $('.homepage').length > 0 ) {
      $('#layout-column_column-1').css('position', 'relative').prepend($shareModule);
    } else if ( $('.site-main .portlet-search').length ) {
      $('.site-main .portlet-search form .aui-fieldset').css('position', 'relative').append($shareModule.addClass('span2'));
    }
    /*var shareLinks = '<div><a class="addthis_button_twitter" tw:via="GOTO2040"></a>' +
           '<a class="addthis_button_facebook"></a>' +
           '<a class="addthis_button_google_plusone_share"></a>' +
           '<a class="addthis_button_pinterest_share"></a>' +
           '<a class="addthis_button_email"></a></div>';
    */
    var shareLinks = '<ul class="social-bookmarks"> <li class="facebook"> <a class="facebook addthis_button_facebook">Facebook</a></li>' +
    '<li class="twitter"> <a class="twitter addthis_button_twitter" tw:via="GOTO2040">Twitter</a></li> ' +
    '<li class="google"> <a class="google addthis_button_google_plusone_share">Google+</a></li> ' +
    '<li class="pinterest"> <a class="pinterest addthis_button_pinterest_share">Pinterest</a></li> ' +
    '<li class="email"> <a class="email addthis_button_email">Email</a></li></ul>';

    if ( $('.share-wrapper').length == 1 ) {
      $('.share-wrapper').empty().html(shareLinks);
      $('.share-wrapper').responsiveArrowDropdown({triggerSelector: '#share-this-label'});
      /*$('.share-container').on('click', 'a', function(e) {
        $('#share-this-toggle').trigger('click');
      });*/
    }

    // restore markup that is stripped elsewhere
    if (!$('#share-this-label .icon').length) {
      $('#share-this-label').html('<span class="icon">Share</span>');
    };

    // restore markup that is stripped elsewhere
    if (!$('#share-this-label').hasClass('share')) {
      $('#share-this-label').addClass('share');
    };
    /* ! AddThis Widget */

    // In-page Anchors
    function animateTo( target ) {
      $('html,body').animate({
        scrollTop: $(target).offset().top
      }, 800);
      return this;
    }
    $('.in-page-anchors').on('click', 'a', function(e) {
      e.preventDefault();
      var href = $(this).attr('href');
      animateTo(href);
    });
    $('.in-page-anchors').stickyNav();
    /* ! In-page Anchors */

    /* Main Navigation */
      $('.mega-menu > li > ul').each(function() {
        $(this).find('ul').each(function() {
          $(this).parent().addClass('nmsw-sub');
        });
        $($(this).wrap('<div class="nav-main-sub-wrap"/>')).wrap('<div class="width-limit"/>');
      });

      // show the menu items of the categories
      $('.mega-menu .root-cat-li').on('click', 'a', function (e) {
        var $this = $(this);
        var $parent = $this.parent();
        var thisHasLink = !/^(\#)$/i.test($this.attr('href'));

        if ( $(window).width() > 768 && $parent.hasClass('root-cat-li') ) {
          console.log($parent);
          if (thisHasLink) {
            $parent.siblings().removeClass('active');
            $parent.toggleClass('active');
          } else {
            $('.nmsw-sub').trigger('click');
          }
          return false;
        } else if (thisHasLink) {
          e.stopPropagation();
        }
      });

      // expand the nested items
      $('.mega-menu .root-cat-li').on('click', '.nmsw-sub', function () {
        var $this = $(this);
        $this.siblings().removeClass('active');
        $this.toggleClass('active');
      });
    /* ! Main Navigation */

  });
  /* ! Document Ready */

  $(window).on('load', function() {
	$.assetCategoryPreEllipsisClick = function() {
    	$(this).next().toggle();
    	$(this).toggleClass('expanded');
    };
    $.assetCategoryPostEllipsisClick = function() {
    	$(this).hide();
    	$(this).prev().removeClass('expanded');
    }

	$('.asset-category-pre-ellipsis').off('click', $.assetCategoryPreEllipsisClick).on('click', $.assetCategoryPreEllipsisClick).find('a').click(function(e) {
		e.stopPropagation();
	});
    $('.asset-category-post-ellipsis').off('click', $.assetCategoryPostEllipsisClick).on('click', $.assetCategoryPostEllipsisClick).find('a').click(function(e) {
		e.stopPropagation();
	});


    $('.slider-hero.slider-tabs .slides').slick({
    	infinite: false,
    	slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        dots: true,
        fade: true,
        customPaging: function(slider, i) {
          return '<h3>' + $(slider.$slides[i]).find('.slide-title').text() + '</h3>';
        },
        responsive: [
        {
          breakpoint: 769,
          settings: {
            dots: true,
            customPaging: function(slider, i) {
                return '<button type="button" data-role="none">' + (i + 1) + '</button>';
            }
          }
        }]

    });

    $('.slider-hero.slider-no-tabs .slides').on('init', function(e, slick) {
      slick.$list.find('.photo-credit').each(function(index, element) {
        var el = $(element);
        var target = el.closest('.slides').find('.slick-dots');
        var targetRight = 0;
        if (target.length > 0) {
          targetRight = target.offset().left + target.width() + 10;
          el.css({'left': targetRight + 'px'});
        } else {
           el.css({'left': 'auto'});
        }
      });
    });
    $('.slider-hero.slider-no-tabs .slides').slick({
    	infinite: false,
    	slidesToShow: 1,
        slidesToScroll: 1,
        arrows: true,
        dots: false,
        responsive: [
        {
          breakpoint: 769,
          settings: {
            arrows: false,
            dots: true
          }
        }]
    });
    var mobileDotSliderInit = function(e, slick) {
        $(e.target).closest('.slider').next('.view-all-x-updates-link').each(function(index, element) {
            var target = $(element).prev('.slider').find('.slick-dots');
            console.log("logging first target");
            console.log(target);
            var targetRight = 0;
            if (target.length > 0) {
  	            slick.slickFilter(':lt(4)');
  	            target = $(element).prev('.slider').find('.slick-dots');
  	            console.log("logging second target");
  	            console.log(target);
            	targetRight = target.offset().left + target.width() + 10;
              $(this).css({'left': targetRight + 'px'});
            } else {
	          slick.slickUnfilter();
              target = $(element).prev('.slider');
              if (target.length > 0) {
            	  $(this).css({'left': target.css('margin-left')});
              }
            }
        });
    }
    $('.slider-partner-spotlight .slider .slides').on('init', mobileDotSliderInit);
      $('.slider-partner-spotlight .slider').randomizeInGroups('li.slide', 'div.slide-inner');
      $('.slider-partner-spotlight .slider div.slide-inner:odd').removeClass('slide-left').addClass('slide-right');
      $('.slider-partner-spotlight .slider div.slide-inner:even').removeClass('slide-right').addClass('slide-left');
      $('.slider-partner-spotlight .slider .slides').slick({
    	  infinite: false,
      	  slidesToShow: 2,
          slidesToScroll: 2,
          arrows: true,
          dots: false,
		  responsive: [
	       {
	         breakpoint: 769,
	         settings: {
               slidesToShow: 1,
               slidesToScroll: 1,
	           arrows: false,
	           dots: true
	         }
	       }]
      });
      if ( $('.portlet-asset-publisher.slider').length ) {
          var getSliderWidth = function(slider) {
            return slider.innerWidth();
          };

          $assetPublisherSlider = $('.portlet-asset-publisher.slider');
          $assetPublisherSlider.each(function() {
            var portletTitle = $(this).find('.portlet-body .portlet-topper .portlet-title .portlet-title-text').text();
            var $titleContainer = '<h2 class="slider-title" title="' + portletTitle + '">' + portletTitle + '</h2>';

            $(this).prepend($titleContainer);
            $(this).find('.asset-abstract').wrapAll('<div class="slider" />').wrapAll('<div class="slides" />').css('display', 'block');
          });
          $('.portlet-asset-publisher.slider .slider .slides').on('init', mobileDotSliderInit);
          $('.portlet-asset-publisher.slider .slider .slides').slick({
        	  infinite: false,
              slidesToShow: 3,
              slidesToScroll: 3,
              arrows: true,
              dots: false,
              responsive: [
              {
                breakpoint: 769,
                settings: {
                  slidesToShow: 1,
                  slidesToScroll: 1,
                  arrows: false,
                  dots: true
                }
              }]
          });

        }
      });
      var mobileSearchItem = null;
      var desktopSearchItem = null;
      /* ! On window load */
  	  var prevWidth = $(window).width();
  	  var firstLoad = true;
  	 $(window).on('load resize', function() {

  	      // trigger mobileSize/desktopSize events based on window width
  	      if ( $(window).width() <= 768 && (prevWidth > 768 || firstLoad)) {
  	        //var width = ((parseInt($('.slider-carousel').innerWidth())-(48*2)-(24*2))) + 'px';
  	        //console.log("setting mobile width" + width);
  	        //$('.slider-carousel .asset-abstract').css('width', width);
  	        //console.log('actual width: ' + $('.slider-carousel .asset-abstract').width());
  	        $('#footer').trigger('mobileSize');
  	        $('.portlet-boundary').trigger('mobileSize');
  	        $('.slider-featuring .slide').trigger('mobileSize');
  	        $('.mega-menu.items').trigger('mobileSize');
  	        $('.calendar').trigger('mobileSize');
  	        $('.meta-data .more-in-section, .meta-data .breadcrumbs-wrap').trigger('mobileSize');
  	        $('.meta-data .share-this-block').trigger('mobileSize');
  	        $('.mobile-secondary-menu').trigger('mobileSize');
  	        $('.mobile-nav-main-label').trigger('mobileSize');
  	        $('.slider-tabs .slide').each(function(index, element) {
  	          $(element).css('background-image', 'url('+$(element).data('mobileimage')+')');
  	        });
  	        if (typeof mobileSearchItem != 'undefined') {
  	      	  try {
  			          $('input.look-ahead-keyword')
  				  		.autocomplete('destroy');
  	      	  } catch (e) {
  	      	  }
  	      	  try {
  		          mobileSearchItem.find('.look-ahead-keyword')
  			  		.autocomplete({
  				            minLength: 2,
  				            source: typeAheadSource,
  				            select: typeAheadSelect,
  				            position: {
  				                  my: "center top+10",
  				                  at: "center bottom",
  			                  collision: "none"
  				            }
  			  		});
  	      	  } catch (e) {}
  	        }
  	      } else if ($(window).width() > 768 && (prevWidth <= 768 || firstLoad)) {
  	        //var width = ((parseInt($('.slider-carousel').innerWidth())-(48*2)-(24*2))/3) + 'px'
  	        //console.log("setting desktop width" + width);
  	        //$('.slider-carousel .asset-abstract').css('width', width);
  	        //console.log('actual width: ' + $('.slider-carousel .asset-abstract').width());
  	        $('#footer').trigger('desktopSize');
  	        $('.portlet-boundary').trigger('desktopSize');
  	        $('.slider-featuring .slide').trigger('desktopSize');
  	        $('.mega-menu.items').trigger('desktopSize');
  	        $('.calendar').trigger('desktopSize');
  	        $('.meta-data .more-in-section, .meta-data .breadcrumbs-wrap').trigger('desktopSize');
  	        $('.meta-data .share-this-block').trigger('desktopSize');
  	        $('.mobile-secondary-menu').trigger('desktopSize');
  	        $('.mobile-nav-main-label').trigger('desktopSize');
  	        $('.slider-tabs .slide').each(function(index, element) {
  	          $(element).css('background-image', 'url('+$(element).data('image')+')');
  	        });
  	        if (typeof desktopSearchItem != 'undefined') {
  	      	  try {
  			          $('input.look-ahead-keyword')
  				  		.autocomplete('destroy');
  	      	  } catch (e) {
  	      	  }
  	      	  try {
  		          desktopSearchItem.find('.look-ahead-keyword')
  			  		.autocomplete({
  			              minLength: 2,
  			              source: typeAheadSource,
  			              select: typeAheadSelect
  			  		});
  	      	  } catch(e) {}
  	        }
  	      }
  	      firstLoad = false;
  	      prevWidth = $(window).width();
  	  if (typeof $primary !== 'undefined') {
  	    if ( $(this).width() > 767 ) {
  	      $primary.css('min-height', 800);
  	    } else {
  	      $primary.css('min-height', 0);
  	    }
  	  }

  	});

})(jQuery);


(function ($, window, undefined) {
  'use strict';
  var cmapApp = {

    settings: {
          primary: $('.primary')
      ,   secondary: $('.secondary')
      ,   mainNavigation: $('.mega-menu')
      ,   secondaryNavigation: $('.secondary .nav-menu')
      ,   moreInSection: $('.more-in-section')
      ,   breadcrumbSection: $('.breadcrumbs-wrap')
      ,   calendar: $('.calendar')
      ,   leadText: $('.lead')
      ,   pageMetaBar: $('.page-meta-data')
    },

    init: function ( settings ) {
      $.extend( {}, this.settings, settings );
      this.bindEvents();
      $.each(this.settings.leadText, $.proxy(function ( index, textContainer ) {
        this.attachAnchor_More( textContainer, '.constrain', 'bg-intro');
      }, this));
    },

    bindEvents: function () {
      console.debug('binding events....???');
      if ( this.settings.secondaryNavigation.length > 0 ) {
        ($.proxy(this.buildSecondaryMobileNav, this))();
        this.settings.moreInSection.on('change', 'select', function () {
          window.location = $(this).find('option:selected').val();
        });
      }

      if ( this.settings.calendar.length > 0 ) {
        $('a.calendar-event-detail-link').on('click', this.calendarEventDetailClick);
      }

      this.settings.leadText.on('click', '.more', function () {
        cmapApp.animateToAnchor(this, '.portlet-boundary', 64);
        return false;
      });

      $(window).on('scroll', function () {
        cmapApp.fixedSelector( this, '#main-content' );
      });

      $('.mobile-nav-main-label').on('click', function ( event ) {
          $('body').toggleClass('main-mobile-active');
          if ($('body').hasClass('main-mobile-active')) {
            $('body').height($(window).innerHeight());
            $('#page').height($('#navigation').height()+120+72);
          } else {
        	  $('body').css('height', 'auto');
        	  $('#page').css('height', 'auto');
          }
          return false;
        });

    },

    buildSecondaryMobileNav: function () {
      var   $mobileSecondaryNavWrap = $('<div class="mobile-secondary-menu" />')
        ,   $mobileSelect_frag = $("<select class='nav-secondary-mobile' />")
        ,   $mobileOption_frag = function (selected, value, text) {
              return $('<option />').attr({
                'selected': selected,
                'value': value
              }).text(text);
            }
        ,   navigationItems = this.settings.secondaryNavigation.find('a')
        ,   navItemsNum = navigationItems.length;
      $mobileSelect_frag.append($mobileOption_frag('selected', '', 'More in this section'), $mobileOption_frag(false, '', '---'));

      $.each(navigationItems, $.proxy( function ( index, links ) {
        $mobileSelect_frag.append($mobileOption_frag(false, $(links).attr('href'), $(links).text()));

        if ( !--navItemsNum ) {
          $mobileSecondaryNavWrap.append($mobileSelect_frag);
          this.settings.moreInSection.append($mobileSecondaryNavWrap);
        }
      }, this));
    },

    calendarEventDetailClick: function (event) {
      event.preventDefault();
      var anchor = $(this);
      if (anchor.attr('popover')==null) {
        var href = $(this).attr('href');
        var eventId = href.match(/\d+$/)[0];
        var date = $(this).attr('date');
        var timestamp = $(this).attr('timestamp');

        $.ajax({
          type: "GET",
          url: href,
          success: function(data){
            data = data.substring(data.indexOf('<body'), data.indexOf('</html')).replace(/\s+/g, ' ');
            var doc = $(data).find('.portlet-calendar').wrapAll('<div></div>').parent();
            var exportLink = doc.find('a[id$="export"]');
            var exportLinkHref = exportLink.attr('href');
            var ppIdRegex = /p\_p\_id=(\d+)/;
            var ppId = exportLinkHref.match(ppIdRegex)[1];
            exportLinkHref += '&_' + ppId + '_exportFileName=event.ics';
            var link = doc.find('[id*="_link"]').text();
            doc.find('.event-content>div:eq(1),.event-content p,.header-back-to,.portlet-topper,.taglib-custom-attributes-list').remove();
            var details = doc.find('.property-list dt');
            var detailArr = new Object();
            var detailStr = '';
            details.each(function(index, element) {
              var dt = $(element);
              var dd = dt.next();
              detailArr[dt.text()] = dd.text();
              detailStr += dt.text() + dd.text() + '\n\n';
            });

            var eventName = anchor.text();
            var address = doc.find('.location').text();
            var mailHref = 'mailto:?subject=CMAP EVENT-'+eventName+'&body=You\'ve been sent an event announcement from the Chicago Metropolitan Agency for Planning event calendar.%0A%0A';
            mailHref += 'Event Name: '+eventName+'%0A%0A';
            mailHref += escape(detailStr);
            if (address != null && address.length > 0) mailHref += escape('%0ADirections: http://maps.google.com/maps?f=q&hl=en&q=to+'+address+'%0A%0A');
            mailHref += 'For more info on CMAP see http://www.cmap.illinois.gov/%0AFor more events see http://www.cmap.illinois.gov/events';
            var learnMoreLink = '';
            if (link != null && link != '') learnMoreLink = '<div><a class="calendar-learn-more-link" target="_blank" href="'+link+'">Learn More</a></div>';
            var mapLink = '';
            if (address != null && address.length > 0) mapLink = '<div class="calendar-item-ctas"><a class="calendar-map-link" target="_blank" href="http://maps.google.com/maps?f=q&amp;hl=en&amp;q=to+'+escape(address)+'">Get Directions</a>';
            var calendarLink = '<a class="calendar-add-to-calendar-link" href="'+exportLinkHref+'">Add to Calendar</a>';
            var mailLink = '<a class="calendar-mail-link" href="#" onclick="return jQuery.fn.triggerEmailForm('+eventId+','+timestamp+');">Email to Friend</a></div>';
            doc.find('.property-list').after($(learnMoreLink+mapLink+calendarLink+mailLink));

            // remove aui-w75 class because it sets a width
            doc.find('.aui-w75').removeClass('aui-w75');

            var eventStartDate = doc.find('dd.event-start-date').text().trim();
            var eventDuration = doc.find('dd.event-duration').text().trim();
            var eventLocation = doc.find('dd.event-location').text().trim();

            // reorder and clean up the properties retrieved from the detail page
            doc.find('.property-list').before('<div class="event-property event-start-date">' + date + '</div>')
                .before('<div class="event-property event-duration">' + eventDuration + '</div>')
                .before('<div class="event-property event-location">' + eventLocation + '</div>')
              doc.find('.property-list').remove();
              //doc.find('.calendar-learn-more-link').remove();

            anchor.attr('popover', doc.html());

            $('.event-detail-popover .ui-dialog-content:visible').dialog('close');
            // position's "at" bottom is offset by 30 to account for the arrow
            $(anchor.attr('popover')).dialog({position: { my: "left top", at: "left bottom+30", of: anchor }, dialogClass: 'event-detail-popover', width: 'auto'}).dialog('open');
          }
        });
      } else {
        $('.event-detail-popover .ui-dialog-content:visible').dialog('close');
        $(anchor.attr('popover')).dialog({position: { my: "left top", at: "left bottom+30", of: anchor }, dialogClass: 'event-detail-popover', width: 'auto'}).dialog('open');
      }
    },

    attachAnchor_More: function ( el, closestSelector, hasClass ) {
      if ( $(el).closest(closestSelector).hasClass(hasClass) ) {
        var moreAnchorLink_frag = $('<a />').attr('href', '#more').addClass('more').text('More');
        $(el).append( moreAnchorLink_frag );
      }
    },

    animateToAnchor: function ( el, animateToSelector, topOffset ) {
      var next = $(el).closest(animateToSelector).next();

      $('html,body').animate({
        scrollTop: next.offset().top - topOffset
      }, 800);
    },

    getSelectorOffset: function ( selector ) {
      return $(selector).offset()
    },

    fixedSelector: function ( baseSelector, selector ) {
      baseSelector = typeof baseSelector !== 'undefined' ? baseSelector === window ? { top: $(window).scrollTop(), left: 0 } : cmapApp.getSelectorOffset( baseSelector ) : { top: 0, left: 0 };

      var   baseOffset = baseSelector
        ,   elOffset = cmapApp.getSelectorOffset( selector )
        ,   $el = $(selector);

      if ( baseOffset.top > elOffset.top ) {
        $el.addClass('fixed');
      } else {
        $el.removeClass('fixed');
      }
    }

  };

  $(function () {
    cmapApp.init();
  });

})(jQuery, window);

jQuery.fn.labelOver = function(overClass) {
	return jQuery(this).each(function(){
		var label = jQuery(this);
		var f = label.attr('for');
		if (f) {
			var input = jQuery('#' + f);
			if (label.width() > input.width()) {
				input.attr('style', 'max-width: 1000px !important; width:' + (label.width() + 40).toString() + 'px !important;');
			}
			label.hide = function() {
			  label.css({ textIndent: '-10000px' })
			}

			label.show = function() {
			  if (input.val() == null || input.val() == '') label.css({ textIndent: 0 });
			}

			// handlers
			input.focus(label.hide);
			input.blur(label.show);
		  label.addClass(overClass).click(function(){ input.focus() });

			if (input.val() != '') label.hide();
		}
	})
}

jQuery(document).ready(function() {
	$(".web-form-portlet label.aui-field-label").filter(
		    function() {return $(this).parents('.web-form-portlet-radio-group').length < 1;}).labelOver('over');
	$('.drilldown').drilldown();
	$('.nav-secondary-mobile, #jumpToSelect, #resultTypeSelect').simpleselect();
	$('#jumpToSelect').on('change', $.taglibOnJump);
});

;(function ($) {

    $(window).on('resize load', function() {
        mainNav.init();
    });

    $(function () {

        var eventLink = $('.header-main .events').clone(true);
        $('.mega-menu.items').append(eventLink.addClass('root-cat-li'));
        var searchItem = $('<li />', {'class': 'root-cat-li search'}).append($('#_lookaheadsearch_WAR_CustomPortletsportlet_fm').clone(true));
        $('.mega-menu.items').append(searchItem);
        $('.site-header .search').on('click', 'a', function() {
            $('body').toggleClass('search-toggle');
            $("#_lookaheadsearch_WAR_CustomPortletsportlet_keyword").focus();
            return false;
        });

        if ( $('.portlet-asset-publisher.slider').length ) {
            
            $assetPublisherSlider = $('.portlet-asset-publisher.slider');
            $assetPublisherSlider.each(function() {
                var portletTitle = $(this).find('.portlet-body .portlet-topper .portlet-title .portlet-title-text').text();
                var $titleContainer = '<h2 class="slider-title" title="' + portletTitle + '">' + portletTitle + '</h2>';

                $(this).prepend($titleContainer);
                $(this).find('.asset-abstract').wrapAll('<div class="slider-carousel" />').wrapAll('<div class="slides" />');
            });

            $('.slider-carousel').flexslider({
                selector: ".slides > .asset-abstract",
                animation: 'slide',
                slideshow: false,
                directionNav: false,
                itemWidth: ((1200-(48*2)-(24*2))/3),
                itemMargin: 24,
                minItems: 1,
                maxItems: 3,
                start: function(slider) {
                    $('.view-all-x-updates-link').each(function(i, el) {
                        var $this = $(el);
                        var $slider = $this.siblings('.slider-carousel');
                        $slider.append($this);
                    });
                }
            });
        }

        $('.slider-hero.slider-tabs').flexslider({
            animation: 'fade',
            slideshow: true,
            slideshowSpeed: 8000,
            animationSpeed: 500,
            controlNav: true,
            directionNav: false,
            manualControls: '.slide-tabs li'
        });

        $('.slider-hero.slider-no-tabs').flexslider({
            animation: 'fade',
            slideshow: false,
            slideshowSpeed: 8000,
            animationSpeed: 500,
            controlNav: true,
            directionNav: false
        });

        $('.slider-partner-spotlight .slider').flexslider({
            animation: 'fade',
            slideshow: false,
            slideshowSpeed: 8000,
            animationSpeed: 500,
            controlNav: true,
            directionNav: false
        });



        var $shareModule = $('<div class="share-this-block"><label for="share-this-toggle" id="share-this-label" class="share"><span class="icon">Share</span></label><input type="checkbox" id="share-this-toggle" name="share-this-toggle" class="share-this-toggle hidden" /><div class="share-container"><div class="addthis_sharing_toolbox"></div></div></div>');
        var shareLinks = '<a class="addthis_button_twitter" tw:via="GOTO2040"></a>' +
               '<a class="addthis_button_facebook"></a>' +
               '<a class="addthis_button_google_plusone_share"></a>' +
               '<a class="addthis_button_pinterest_share"></a>' +
               '<a class="addthis_button_email"></a>';

        if ( $('.tbs-1-1-1-2-columns-hero-slider-container').length > 0 ) {
          $('.hero-slider > .row-fluid').css('position', 'relative').prepend($shareModule);
			          //$('.share-container').append(shareLinks);
        }
        $('.share-container').on('click', 'a', function(e) {
            $('#share-this-toggle').trigger('click');
          });



    });

})(jQuery);
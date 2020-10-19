(function( window, $ ) {
    
    $.fn.stickyNav = function() {
        var $getElement = $($(this).selector);

        if ( $getElement.length > 0 ) {
            var elementPosTop = $getElement.offset().top;
            var elementHeight = $getElement.outerHeight();
            var $elementParent = $getElement.parent();
            var elementParentHeight = $elementParent.outerHeight();
            var elementParentPosTop = $elementParent.offset().top;
            var elementParentPosBottom = elementParentHeight + elementParentPosTop
            
            $(window).scroll(function() {
                var windowPosTop = $(window).scrollTop();
                var elementPosTop_temp = $getElement.offset().top;
                var elementParentPosTop_temp = $getElement.parent().offset().top
                
                if ( windowPosTop > elementPosTop && windowPosTop + elementHeight < elementParentPosBottom ) {
                    $getElement.css({
                        position: 'relative',
                        top: windowPosTop - elementParentPosTop_temp
                    }).addClass('sticky');
                } else if ( windowPosTop < elementPosTop ) {
                    $getElement.css({
                        top: 0
                    }).removeClass('sticky');
                }
            });
        }
    };
    
})(window, jQuery);




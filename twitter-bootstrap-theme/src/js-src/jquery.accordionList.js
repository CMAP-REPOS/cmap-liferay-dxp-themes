/*
 * name: accordionList - jQuery Plugin
 * version: 0.5
 * @requires jQuery v1.10 or later
 *
 * contributing author: John Nguyen
 * source: https://github.com/nguyenj/accordion-list
 * Copyright 2013 John Nguyen
 * 
 */

/* Example markup */
/*
    <ul class="accordion-list">
        <li>
            <div class="title"><p>title text</p></div>
            <div class="description">
                <p>description text</p>
                <img src="..." />
            </div>
        </li>
    </ul>
*/

(function($) {
$.fn.accordionList = function (options) {
    var defaults;

    defaults = {
        title: '.title',
        description: '.description',
        currentClass: 'current',
        slideSpeed: 400,
        showFirst: false,
        onAfter: function (el) {}
    };

    options = $.extend({}, defaults, options);

    return this.each(function () {
        var $container = $(this);
        if ($container.length) {

            var $title = $container.find(options.title);
            var $descriptions = $container.find(options.description);

            if (options.showFirst) {
                $descriptions.not(':first').hide().end()
                    .first().parent().addClass(options.currentClass);
            } else {
                $descriptions.hide();
            }
            
            $title.on('click', function () {
                var $this = $(this);
                var isCurrent = $this.parent().hasClass(options.currentClass);
                var $description = $(this).siblings(options.description);

                $title.parent().removeClass(options.currentClass);
                $descriptions.slideUp(options.slideSpeed);

                if (!isCurrent) {
                    $this.parent().addClass(options.currentClass);
                    $description.slideDown(options.slideSpeed);
                }

                setTimeout(function() {
                    options.onAfter($this);
                }, options.slideSpeed+1);

                return false;
            });
        }
    });
};
})(jQuery);
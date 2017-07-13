var mainNav = {

    init: function () {
        if (window.outerWidth > 768) {
            this.bindActions('.root-cat-li', 'a');
            this.bindActions('.root-cat-li', '.sub', false);
        };

        this.bindActions('.site-navigation', '.mobile-nav-main-label');

        this.wrapNested('.root-cat-items-ul');
        this.addNested('.root-cat-items-ul li:not(.featured-li)');
    },

    bindActions: function (item, target, nested) {
        nested = typeof nested !== 'undefined' ? nested : true;

        $(item).on('click', target, function (e) {
            var $item = nested ? $(this).closest(item) : $(this);
            var hasLink = !/^(\#)$/i.test($(this).attr('href'));
            
            if ( $item.hasClass(item.substring(1)) || !hasLink ) {
                mainNav.removeActive($item.siblings());
                $item.toggleClass('active');
                return false;
            } else if ( $item.hasClass(target.substring(1)) ) {
                e.stopPropagation();
                mainNav.removeActive($item.siblings());
                $item.toggleClass('active');
            } else {
                e.stopPropagation();
            }
        });
    },

    addActive: function (element) {
        $(element).addClass('active');
    },

    removeActive: function (element) {
        $(element).removeClass('active');
    },

    wrapNested: function (container) {
        $(container).wrap('<div class="container-fluid" />').wrap('<div class="row-fluid" />');
    },

    addNested: function (container) {
        $(container).each(function (i, item) {
            if ( $(item).find('ul').length > 0 ) {
                $(item).addClass('sub');
            }
        });
    }

};
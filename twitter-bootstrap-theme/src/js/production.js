/**
 * A simple jQuery plugin for creating animated drilldown menus.
 *
 * @name jQuery Drilldown
 * @version 1.0.0
 * @requires jQuery v1.7+
 * @author Aleksandras Nelkinas
 * @license [MIT]{@link http://opensource.org/licenses/mit-license.php}
 *
 * Copyright (c) 2015 Aleksandras Nelkinas
 */

;(function (factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD
    define(['jquery'], factory);
  } else if (typeof exports === 'object') {
    // Node/CommonJS
    module.exports = factory(require('jquery'));
  } else {
    // Browser globals
    factory(jQuery);
  }
}(function ($, undefined) {

  'use strict';

  var pluginName = 'drilldown';
  var defaults = {
    event: 'click',
    selector: 'a',
    speed: 100,
    cssClass: {
      container: pluginName + '-container',
      root: pluginName + '-root',
      sub: pluginName + '-sub',
      back: pluginName + '-back'
    }
  };

  var Plugin = (function () {

    function Plugin(element, options) {
      var inst = this;

      this._name = pluginName;
      this._defaults = defaults;

      this.element = element;
      this.$element = $(element);

      this.options = $.extend({}, defaults, options);

      this._history = [];
      this._css = {
        float: 'left',
        width: null
      };

      this.$container = this.$element.find('.' + this.options.cssClass.container);

      this.$element.on(this.options.event + '.' + pluginName, this.options.selector, function (e) {
        handleAction.call(inst, e, $(this));
      });
    }

    Plugin.prototype = {

      /**
       * Destroys plugin instance.
       */
      destroy: function () {
        this.reset();

        this.$element.off(this.options.event + '.' + pluginName, this.options.selector);
      },

      /**
       * Resets drilldown to its initial state.
       */
      reset: function () {
        var $root;

        if (this._history.length) {
          $root = this._history[0];

          this.$container.empty().append($root);
          restoreState.call(this, $root);
        }

        this._history = [];
        this._css = {
          float: 'left',
          width: null
        };
      }

    };

    /**
     * Handles user action and decides whether or not and where to drill.
     *
     * @param {jQuery.Event} e
     * @param {jQuery}       $trigger
     * @private
     */
    function handleAction(e, $trigger) {
      var $next = $trigger.nextAll('.' + this.options.cssClass.sub);
      var preventDefault = true;

      if ($next.length) {
        down.call(this, $next);
      } else if ($trigger.closest('.' + this.options.cssClass.back).length) {
        up.call(this);
      } else {
        preventDefault = false;
      }

      if (preventDefault && $trigger.prop('tagName') === 'A') {
        e.preventDefault();
      }
    }

    /**
     * Drills down (deeper).
     *
     * @param {jQuery} $next
     * @private
     */
    function down($next) {
      if (!$next.length) {
        return;
      }

      this._css.width = this.$element.outerWidth();
      this.$container.width(this._css.width * 2);

      $next = $next.clone(true)
          .removeClass(this.options.cssClass.sub)
          .addClass(this.options.cssClass.root);

      this.$container.append($next);

      animateDrilling.call(this, -1 * this._css.width, function () {
        var $current = $next.prev();

        this._history.push($current.detach());

        restoreState.call(this, $next);
      }.bind(this));
    }

    /**
     * Drills up (back).
     *
     * @private
     */
    function up() {
      var $next = this._history.pop();

      this._css.width = this.$element.outerWidth();
      this.$container.width(this._css.width * 2);

      this.$container.prepend($next);

      animateDrilling.call(this, 0, function () {
        var $current = $next.next();

        $current.remove();

        restoreState.call(this, $next);
      }.bind(this));
    }

    /**
     * Animates drilling process.
     *
     * @param {Number}   marginLeft Target margin-left.
     * @param {Function} callback
     * @private
     */
    function animateDrilling(marginLeft, callback) {
      var $menus = this.$container.children('.' + this.options.cssClass.root);

      $menus.css(this._css);

      $menus.first().animate({
        marginLeft: marginLeft
      }, this.options.speed, callback);
    }

    /**
     * Restores initial menu's state.
     *
     * @param {jQuery} $menu
     * @private
     */
    function restoreState($menu) {
      $menu.css({
        float: '',
        width: '',
        marginLeft: ''
      });

      this.$container.css('width', '');
    }

    return Plugin;

  })();

  $.fn[pluginName] = function (options) {
    return this.each(function () {
      var inst = $.data(this, pluginName);
      var method = options;

      if (!inst) {
        $.data(this, pluginName, new Plugin(this, options));
      } else if (typeof method === 'string') {
        if (method === 'destroy') {
          $.removeData(this,  pluginName);
        }
        if (typeof inst[method] === 'function') {
          inst[method]();
        }
      }
    });
  };

}));

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
/*! 
 *  jQuery Sorting Order List
 *  (c) 2014 John Nguyen
 *  jnguyen.me
 *
 *  HTML markup should be
 *  ==========
 *  <ul class="sort">
 *    <li>
 *      <span class="name">John Smith</span>
 *    </li>
 *  </ul>
 *
 *  JS call
 *  ==========
 *  $('.sort').sortList();
 */

;(function($) {

  $.fn.sortList = function(options) {

    var settings = $.extend({
      sortBy: $(this).data('sort-by') || "name",
      sortOrder: $(this).data('sort-order') || "desc",
      sortGroup: $(this).data('sort-group') != undefined ? $(this).data('sort-group').toString() : true,
      sortID: 0
    }, options);

    return this.each(function(i, obj) {

      // define vars
      var $currentList = $(this);
      var sortBy = settings.sortBy;
      var sortOrder = settings.sortOrder;
      var sortGroup = settings.sortGroup;
      var list = { letters: [] };
      var $alphabetHeadings = $('<ul />', { 'class': 'letter-headings' });

      // check if the specified list exists
      // loop through each item create a letter container
      // group each item in the respective letter by the specified "sortBy"
      if ( $currentList.length ) {
        $currentList.children().each(function(i, obj) {
          var name = $(obj).find("."+sortBy).text();
          var letter = name.substring(0,1);
          if ( !(letter in list) ) {
            list[letter] = [];
            list.letters.push(letter);
          }
          list[letter].push(obj);
        });
      }

      // Sort the letters
      if ( sortOrder.toLowerCase() == "asc") {
        list.letters.sort().reverse();
      } else {
        list.letters.sort();
      }

      _tempList = [];
      $.each(list.letters, function(i, letter) {
        // If grouping is true
        if ( sortGroup === "true" ) {
          // Define letter container
          var $letterList = $('<li />', { 
            "class": "letter " + letter.toLowerCase(),
            "text": letter
          });
          var _$letterHeading = $letterList.clone();
          var $letterListContainer = $('<ul />');

          // Set active class for first item
          if ( i == 0 ) {
            $letterList.addClass('active');
            _$letterHeading.addClass('active');
          }

          // Append the cloned letter heading to the alphabet heading list container
          $alphabetHeadings.append(_$letterHeading);

          // Append the letter list container to the letter list
          // Push each letter list to the temporary list
          $letterList.append($letterListContainer);
          _tempList.push($letterList)
        }

        // Sort items in each letter list
        list[letter].sort(function(a, b) {
          if ( $(a).find('.name').text() < $(b).find('.name').text() ) {
            if ( sortOrder.toLowerCase() == "asc" )  {
              return 1;
            } else {
              return -1;
            }
          }
          return 0;
        });

        $.each(list[letter], function(i, items) {
          // If grouping is true
          if ( sortGroup === "true" ) {
            $letterListContainer.append(items);
          } else {
            _tempList.push($(items));
          }
        });

      });
      
      // Insert the letter headings list before the sort list
      $currentList.before($alphabetHeadings.attr('data-sort-id', i).addClass('sort-headings no-list'));

      // Append the new list to the specified list container
      $currentList.attr('data-sort-id', i).empty().append(_tempList);

      $('[data-sort-id="'+i+'"]').on('click', '.letter', function(e) {
        var $el = $(this);
        var letter = $el.text().toLowerCase();

        $el.siblings().removeClass('active');
        $el.addClass('active');

        $('.sort[data-sort-id="'+i+'"]').find('.letter').removeClass('active');
        $('.sort[data-sort-id="'+i+'"]').find('.'+letter).addClass('active');

      });

    });
  }

  $(function() {
    $('.sort').sortList();
  });

})(jQuery);



/*
 * jQuery SimpleSelect
 * http://pioul.fr/jquery-simpleselect
 *
 * Copyright 2014, Philippe Masset
 * Dual licensed under the MIT or GPL Version 2 licenses
 */
;(function($) {
	"use strict";

	// Define variables and methods that all plugin instances have in common
	var windowHeight = null,
		documentHeight = null,
		activeSimpleselects = [],
		isSsActivationForbidden = false,
		isNextDocumentClickEventDisabled = false,

		// Executed on the plugin's first call on a select
		init = function(options) {
			// Override default options
			options = $.extend({}, {
				fadingDuration: (options && options.fadeSpeed) || 0,
				containerMargin: 5,
				displayContainerInside: "window"
			}, options);

			// Loop through all selects
			this.each(function() {
			
				var t = $(this).addClass("simpleselected");
				
				// Create the SimpleSelect
				var simpleselect = $("<div class=\"simpleselect\"></div>"),
					ssPlaceholder = $("<div class=\"placeholder\"></div>").appendTo(simpleselect),
					ssOptionsContainer = $("<div class=\"options\"></div>").appendTo(simpleselect);
				
				// Give an id to the SimpleSelect if the original select has one
				var selectIdAttribute = t.attr("id");
				if (selectIdAttribute) {
					simpleselect.attr("id", "simpleselect_"+ selectIdAttribute);
				}

				// Remove all change event listeners attached to the select before the plugin was called to avoid conflicts (see doc for more details)
				t.off("change");

				// Set the size attribute of the select to more than 1 (makes our lives easier)
				t.attr("size", 2);
				
				// SimpleSelect data
				var ssData = {
					select: t,
					selectOptions: null, // Set later, when the SimpleSelect is populated
					simpleselect: simpleselect,
					ssPlaceholder: ssPlaceholder,
					ssOptionsContainer: ssOptionsContainer,
					ssOptionsContainerHeight: null, // Set later, when the SimpleSelect is populated
					ssOptions: null, // Set later, when the SimpleSelect is populated
					canBeClosed: true,
					isActive: false,
					isScrollable: false,
					isDisabled: false,
					options: options
				};
				
				// SimpleSelect bindings
				simpleselect
					.data("simpleselect", ssData)
					.on({
						mousedown: function() {
							ssData.canBeClosed = false;
						},
						click: function(e) {
							var eventTarget = $(e.target);
							console.log("v4");
							if (eventTarget.hasClass("placeholder")) {
								if (eventTarget.parent().hasClass("active"))
									publicMethods.setInactive.call(ssData);
								else if (jQuery(window).width() <= 415 && !eventTarget.parent().hasClass("active")) {
									var metaData = jQuery('.page-meta-data');
									var metaDataHeight = -6;
									if (metaData.css('position') != 'fixed')
									metaDataHeight = metaData.height();
									var newScrollTop = eventTarget.offset().top - (52 + metaDataHeight);
									var curScrollTop = jQuery('body').scrollTop();
									if (curScrollTop != newScrollTop) {
										var duration = Math.abs(newScrollTop - curScrollTop)*2;
										if (duration > 500) duration = 500;
										jQuery('body').animate({
										        scrollTop: newScrollTop
										    }, duration, function() {
										    	publicMethods.setActive.call(ssData);
										    }
										);
									} else {
										publicMethods.setActive.call(ssData);
									}
								} else {
									publicMethods.setActive.call(ssData);
								}
							// Handle clicks on options
							} else if (eventTarget.hasClass("option")) {
								isSsActivationForbidden = true; // Disable the eventual activation of the SimpleSelect if the select is focused, until a click event bubbles up to the document, at which point it's reset
								selectOption.call(ssData, eventTarget);
								publicMethods.setInactive.call(ssData);
							}
						},
						mouseup: function() {
							ssData.canBeClosed = true;
						},
						mouseover: function(e) {
							var eventTarget = $(e.target);
							// Handle mouseover on options
							if (eventTarget.hasClass("option")) {
								selectSsOption.call(ssData, eventTarget);
							}
						}
					});
				
				// Select bindings
				t
					.data("simpleselect", ssData)
					.on({
						keydown: function(e) {
							// On key enter
							if (e.keyCode == 13) {
								publicMethods.setInactive.call(ssData);
							}
						},
						focus: function() {
							// If a SimpleSelect option has just been clicked, don't activate the select
							if (!isSsActivationForbidden) {
								publicMethods.setActive.call(ssData);
							}
						},
						blur: function() {
							if (ssData.canBeClosed) {
								publicMethods.setInactive.call(ssData);
							}
						},
						change: function(e, shouldLetChangeEventThrough) {
							if (!shouldLetChangeEventThrough) e.stopImmediatePropagation();
							var optionToSelect = getSsOptionToSelect.call(ssData);
							selectSsOption.call(ssData, optionToSelect, true);
						},
						// We don't care about that event – it's only fired when the related label is clicked, and this action is already captured through the focus event on the select
						click: function(e) {
							e.stopPropagation();
						}
					});
					
				// Add the SimpleSelect to the DOM
				t.after(simpleselect);
				
				// Hide the original select
				var hiddenSelectContainer = $("<div class=\"hidden_select_container\"></div>");
				t.after(hiddenSelectContainer).appendTo(hiddenSelectContainer);
				
				// Update the SimpleSelect with the select's contents and state
				populateSs.call(ssData);
				updateSsState.call(ssData);
				
				// Populate variables dependent on presentation
				publicMethods.updatePresentationDependentVariables.call(ssData);
			});
		},

		// Update the value we stored of the window's height
		updateWindowHeightValue = function() {
			windowHeight = $(window).height();
		},

		// Add a SimpleSelect to the array of active ones
		addToActiveSimpleselects = function(simpleselect) {
			activeSimpleselects.push(simpleselect);
		},

		// Remove a SimpleSelect from the array of active ones
		removeFromActiveSimpleselects = function(simpleselect) {
			activeSimpleselects = $.grep(activeSimpleselects, function(val) {
				return val !== simpleselect;
			});
		},

		// Populate the SimpleSelect with the select's options
		populateSs = function() {
			this.selectOptions = this.select.find("option");
			var ssOptionsAndOptgroups = "",
				addOption = function(selectOption) {
					ssOptionsAndOptgroups += "<div class=\"option\">"+ selectOption.text() +"</div>";
				},
				addOptgroup = function(selectOptgroup) {
					ssOptionsAndOptgroups += "<div class=\"optgroup\">";
					var label = selectOptgroup.attr("label");
					if (label) {
						ssOptionsAndOptgroups += "<div class=\"optgroup-label\">"+ htmlEncode(label) +"</div>";
					}
					selectOptgroup.children("option").each(function() {
						addOption($(this));
					});
					ssOptionsAndOptgroups += "</div>";
				},
				htmlEncode = function(html) {
					return html.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/'/g, "&#039;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
				},
				selectChildren = this.select.children("optgroup, option"),
				selectHasOptgroups = false;
			selectChildren.each(function() {
				var t = $(this);
				if (t.is("optgroup")) {
					addOptgroup(t);
					selectHasOptgroups = true;
				} else {
					addOption(t);
				}
			});
			
			this.ssOptions = this.ssOptionsContainer.html(ssOptionsAndOptgroups).find(".option");
			this.ssPlaceholder.text(getSsOptionToSelect.call(this).text());
		},

		// Enable/disable the SimpleSelect so as to replicate the select's state 
		updateSsState = function() {
			this.isDisabled = this.select.prop("disabled");
			this.simpleselect[(this.isDisabled? "addClass" : "removeClass")]("disabled");
		},

		// Select a SimpleSelect option among the ones in the options container
		// If the new option can be out of sight, make sure it isn't by scrolling the options container when necessary
		selectSsOption = function(ssOption, canBeOutOfSight) {
			this.ssOptions.removeClass("active");
			ssOption.addClass("active");

			// If the option that has been selected can be out of sight
			// (Can happen when changing the selected option based on the select's change event)
			if (canBeOutOfSight) {
				// If the options container is scrollable, and if the
				// to-be-selected SimpleSelect option isn't visible,
				// scroll enough (up or downward) to make it entirely visible
				if (this.isScrollable) {
					var ssOptionPosition = ssOption.position(),
						ssOptionsContainerScrollTop = this.ssOptionsContainer.scrollTop(),
						topViewOffset = ssOptionPosition.top,
						bottomViewOffset = this.ssOptionsContainer.height() - (ssOptionPosition.top + ssOption.outerHeight()),
						toScrollTo;

					if (topViewOffset < 0) {
						toScrollTo = ssOptionsContainerScrollTop + topViewOffset;
					} else if(bottomViewOffset < 0) {
						toScrollTo = ssOptionsContainerScrollTop - bottomViewOffset;
					}

					this.ssOptionsContainer.scrollTop(toScrollTo);
				}
			}
		},

		// Get the SimpleSelect option that has to be selected, based on the index of the currently selected select option
		// Returns a jQuery object
		getSsOptionToSelect = function() {
			var selectedOption = getSelectedOption.call(this),
				selectedOptionIndex = selectedOption.length? this.selectOptions.index(selectedOption) : 0;
			return $(this.ssOptions[selectedOptionIndex]);
		},

		// Select an option in the select corresponding to the given SimpleSelect option
		selectOption = function(ssOption) {
			var optionToSelect = $(this.selectOptions[this.ssOptions.index(ssOption)]);
			this.select.val(optionToSelect.val());
		},

		// Get the currently selected select option
		getSelectedOption = function() {
			return this.selectOptions.filter(":selected").first();
		},

		// Set the options container's initial CSS properties back (usually in order to get its dimensions)
		resetSsOptionsContainerCSS = function() {
			this.ssOptionsContainer.css({
				height: "auto",
				"overflow-y": "visible"
			});
		},

		// Force a layout repaint
		forceRepaint = function() {
			this.ssOptionsContainer.hide();
			this.ssOptionsContainer[0].offsetHeight;
			this.ssOptionsContainer.show();
		},

		// Handle the size, position and (possibly) scrolling of the options container so that the currently selected option appears above the placeholder
		// 1. Identify how much visible space is available above and below the SimpleSelect
		// 2. Compute how much space remains above and below the options container after positioning it according to the selected option
		// 3. If at least one of those values is negative, the container is resized and a scrollbar is added
		// 4. The options container is positioned according to the selected option
		positionAroundSsOption = function(ssOption) {
			resetSsOptionsContainerCSS.call(this);
			
			var ssOptionPosition, freeVisibleSpaceAbove, freeVisibleSpaceBelow, spaceLeftAboveAfterPositioning, spaceLeftBelowAfterPositioning, excessSpaceAbove, excessSpaceBelow,
				shouldDisplayContainerInsideWindow = this.options.displayContainerInside == "window";

			var computePositioningValues = $.proxy(function() {
				ssOptionPosition = ssOption.position();
				freeVisibleSpaceAbove = this.ssPlaceholderOffset.top - this.options.containerMargin - (shouldDisplayContainerInsideWindow? $(window).scrollTop() : 0);
				freeVisibleSpaceBelow = (shouldDisplayContainerInsideWindow? windowHeight : documentHeight) - freeVisibleSpaceAbove - this.ssPlaceholderHeight - 2 * this.options.containerMargin;
				spaceLeftAboveAfterPositioning = freeVisibleSpaceAbove - ssOptionPosition.top;
				spaceLeftBelowAfterPositioning = freeVisibleSpaceBelow - (this.ssOptionsContainerOuterHeight - ssOptionPosition.top - this.ssPlaceholderHeight);
				excessSpaceAbove = spaceLeftAboveAfterPositioning < 0? Math.abs(spaceLeftAboveAfterPositioning) : 0;
				excessSpaceBelow = spaceLeftBelowAfterPositioning < 0? Math.abs(spaceLeftBelowAfterPositioning) : 0;
			}, this);
			computePositioningValues();
			
			var wasScrollable = this.isScrollable;
			this.isScrollable = /*spaceLeftAboveAfterPositioning < 0 || */spaceLeftBelowAfterPositioning < 0;

			// If the options container won't fit inside the screen after being positioned, make it shorter and scrollable
			if (this.isScrollable) {
				// Add the scrollbar
				this.ssOptionsContainer.css({
					height: "auto",
					"overflow-y": "scroll"
				});

				// If the addition of the scrollbar made some text wrap, thus increased the options container's height, recompute positioning values
				if (this.ssOptionsContainer.height() != this.ssOptionsContainerHeight) {
					// Force a repaint to avoid an issue found in WebKit
					forceRepaint.call(this);

					publicMethods.updatePresentationDependentVariables.call(this, "ssOptionsContainer", false);
					computePositioningValues();
				}

				var ssOptionsContainerNewHeight = this.ssOptionsContainer.height() - excessSpaceAbove - excessSpaceBelow;
					
				this.ssOptionsContainer
					/*.css({
						top: - (ssOptionPosition.top - excessSpaceAbove)
					})*/
					.height(ssOptionsContainerNewHeight) // Using .height() instead of .css("height", value) gives us access to the cssHook for "height" that adapts the height value depending on the options container's box model (updated cssHook available since jQuery 1.8)
					.scrollTop(excessSpaceAbove);
				
			// If the options container doesn't need scrollbars nor resizing
			} else {
				/*this.ssOptionsContainer.css({
					top: - ssOptionPosition.top
				});
				*/

				// If it had a scrollbar and it just got hidden, force a repaint to avoid an issue in WebKit
				if (wasScrollable) forceRepaint.call(this);
			}
		},

		publicMethods = {

			// Update the variables that depend on how and where the SimpleSelect is displayed
			// Can take a string as an argument describing the reduced set of variables to update (instead of all)
			// Set `updateSafely` to `false` to update values without resetting the related CSS first
			updatePresentationDependentVariables: function(variablesToUpdate, updateSafely) {
				// Update variables related to the placeholder
				if (!variablesToUpdate || variablesToUpdate == "ssPlaceholder") {
					this.ssPlaceholderOffset = this.ssPlaceholder.offset();
					this.ssPlaceholderHeight = this.ssPlaceholder.outerHeight();
				}

				// Update variables related to the options container
				// Make sure the SimpleSelect's options container's CSS is reset before, if necessary, using resetSsOptionsContainerCSS()
				if (!variablesToUpdate || variablesToUpdate == "ssOptionsContainer") {
					if (updateSafely !== false) resetSsOptionsContainerCSS.call(this);
					this.ssOptionsContainerOuterHeight = this.ssOptionsContainer.outerHeight(true);
					this.ssOptionsContainerHeight = this.ssOptionsContainer.height();
				}
			},

			// populateSs equivalent
			// Meant to be exposed in the public API
			refreshContents: function() {
				populateSs.call(this);

				// Update variables dependent on presentation
				publicMethods.updatePresentationDependentVariables.call(this);
			},

			// updateSsState alias
			// Meant to be exposed in the public API
			refreshState: function() {
				updateSsState.call(this);
			},

			// Disable the select, and update the SimpleSelect's state accordingly
			disable: function() {
				this.select.prop("disabled", true);
				publicMethods.refreshState.call(this);
			},

			// Enable the select, and update the SimpleSelect's state accordingly
			enable: function() {
				this.select.prop("disabled", false);
				publicMethods.refreshState.call(this);
			},

			// Set the SimpleSelect in an active state, and show the options container
			setActive: function() {
				if (!this.isActive && !this.isDisabled && this.ssOptions.length) {
					this.lastValue = this.select.val();
					this.simpleselect.addClass("active");
					this.isActive = true;
					addToActiveSimpleselects.call(this, this.simpleselect);
					var optionToSelect = getSsOptionToSelect.call(this);
					selectSsOption.call(this, optionToSelect);
					documentHeight = $(document).height(); // Save the document height before it possibly changes due to the options list being made visible
					this.ssOptionsContainer
						.fadeTo(0, 0)
						.fadeTo(this.options.fadingDuration, 1);
					/*if (!this.select.is(":focus")) {
						this.select.focus();
					}*/
					positionAroundSsOption.call(this, optionToSelect);
					isNextDocumentClickEventDisabled = true;
				}
			},

			// Set the SimpleSelect in an inactive state, and hide the options container
			setInactive: function() {
				if (this.isActive) {
					this.simpleselect.removeClass("active");
					this.isActive = false;
					removeFromActiveSimpleselects.call(this, this.simpleselect);
					this.ssOptionsContainer.fadeOut(this.options.fadingDuration);
					/*if (this.select.is(":focus")) {
						this.select.blur();
					}*/
					var currentValue = this.select.val();
					if (this.lastValue != currentValue) {
						this.ssPlaceholder.text(getSelectedOption.call(this).text());
						this.select.trigger("change", [true]);
					}
				}
			}

		};

	$.fn.simpleselect = function(method) {
		// Additional plugin call (method call)
		// The context inside of these methods is set to the SimpleSelect's data
		if (publicMethods[method]) {
			var args = Array.prototype.slice.call(arguments, 1);
			this.each(function() {
				publicMethods[method].apply($(this).data("simpleselect"), args);
			});
		// First plugin call
		// The context inside of this method is set to the select element
		} else {
			init.apply(this, arguments);
		}
		
		return this;
	};
	
	// Document and window bindings and initialization of related values
	$(document).ready(function() {

		updateWindowHeightValue();
		
		// Update shared windowHeight value when page is resized
		$(window).on("resize.simpleselect", function() {
			updateWindowHeightValue();
		});
		
		$(document).on("click.simpleselect keyup.simpleselect", function(e) {
			// Detect click events once they've bubbled up to the document
			if (e.type == "click") {
				// Reset the flag
				// The following statement is appended to the end of the current call stack to ensure that, when the option of a SimpleSelect placed inside a label is clicked, events (or more precisely, statements handling isSsActivationForbidden and bound to those events) are triggered in the following order while in the bubbling phase:
				// Click on SimpleSelect option -> Click on SimpleSelect -> Click on label (thus focus on associated select) -> Click on document
				// (In IE, if not interfering with the call stack, the click event finishes bubbling up before the focus event is fired on the select.)
				setTimeout(function() {
					isSsActivationForbidden = false;
				}, 0);
				
				// If that flag is activated, don't let the rest of this function be executed (and reset the flag)
				if (isNextDocumentClickEventDisabled) {
					isNextDocumentClickEventDisabled = false;
					return;
				}
			}

			// Disable active selects when the "background" is clicked or when the escape key is pressed
			if (e.type == "click" || (e.type == "keyup" && e.keyCode == 27)) {
				var activeSimpleselectsLength = activeSimpleselects.length;
				if (activeSimpleselectsLength) {
					var activeSimpleselectsCopy = activeSimpleselects.slice(0);
					for (var i = 0; i < activeSimpleselectsLength; i++) {
						activeSimpleselectsCopy[i].simpleselect("setInactive");
					}
				}
			}
		});
	});
	
})(jQuery);
/*
     _ _      _       _
 ___| (_) ___| | __  (_)___
/ __| | |/ __| |/ /  | / __|
\__ \ | | (__|   < _ | \__ \
|___/_|_|\___|_|\_(_)/ |___/
                   |__/

 Version: 1.5.0
  Author: Ken Wheeler
 Website: http://kenwheeler.github.io
    Docs: http://kenwheeler.github.io/slick
    Repo: http://github.com/kenwheeler/slick
  Issues: http://github.com/kenwheeler/slick/issues

 */
/* global window, document, define, jQuery, setInterval, clearInterval */
(function(factory) {
    'use strict';
    if (typeof define === 'function' && define.amd) {
        define(['jquery'], factory);
    } else if (typeof exports !== 'undefined') {
        module.exports = factory(require('jquery'));
    } else {
        factory(jQuery);
    }

}(function($) {
    'use strict';
    var Slick = window.Slick || {};

    Slick = (function() {

        var instanceUid = 0;

        function Slick(element, settings) {

            var _ = this,
                dataSettings, responsiveSettings, breakpoint;

            _.defaults = {
                accessibility: true,
                adaptiveHeight: false,
                appendArrows: $(element),
                appendDots: $(element),
                arrows: true,
                asNavFor: null,
                prevArrow: '<button type="button" data-role="none" class="slick-prev" aria-label="previous">Previous</button>',
                nextArrow: '<button type="button" data-role="none" class="slick-next" aria-label="next">Next</button>',
                autoplay: false,
                autoplaySpeed: 3000,
                centerMode: false,
                centerPadding: '50px',
                cssEase: 'ease',
                customPaging: function(slider, i) {
                    return '<button type="button" data-role="none">' + (i + 1) + '</button>';
                },
                dots: false,
                dotsClass: 'slick-dots',
                draggable: true,
                easing: 'linear',
                edgeFriction: 0.35,
                fade: false,
                focusOnSelect: false,
                infinite: true,
                initialSlide: 0,
                lazyLoad: 'ondemand',
                mobileFirst: false,
                pauseOnHover: true,
                pauseOnDotsHover: false,
                respondTo: 'window',
                responsive: null,
                rows: 1,
                rtl: false,
                slide: '',
                slidesPerRow: 1,
                slidesToShow: 1,
                slidesToScroll: 1,
                speed: 500,
                swipe: true,
                swipeToSlide: false,
                touchMove: true,
                touchThreshold: 5,
                useCSS: true,
                variableWidth: false,
                vertical: false,
                verticalSwiping: false,
                waitForAnimate: true
            };

            _.initials = {
                animating: false,
                dragging: false,
                autoPlayTimer: null,
                currentDirection: 0,
                currentLeft: null,
                currentSlide: 0,
                direction: 1,
                $dots: null,
                listWidth: null,
                listHeight: null,
                loadIndex: 0,
                $nextArrow: null,
                $prevArrow: null,
                slideCount: null,
                slideWidth: null,
                $slideTrack: null,
                $slides: null,
                sliding: false,
                slideOffset: 0,
                swipeLeft: null,
                $list: null,
                touchObject: {},
                transformsEnabled: false
            };

            $.extend(_, _.initials);

            _.activeBreakpoint = null;
            _.animType = null;
            _.animProp = null;
            _.breakpoints = [];
            _.breakpointSettings = [];
            _.cssTransitions = false;
            _.hidden = 'hidden';
            _.paused = false;
            _.positionProp = null;
            _.respondTo = null;
            _.rowCount = 1;
            _.shouldClick = true;
            _.$slider = $(element);
            _.$slidesCache = null;
            _.transformType = null;
            _.transitionType = null;
            _.visibilityChange = 'visibilitychange';
            _.windowWidth = 0;
            _.windowTimer = null;

            dataSettings = $(element).data('slick') || {};

            _.options = $.extend({}, _.defaults, dataSettings, settings);

            _.currentSlide = _.options.initialSlide;

            _.originalSettings = _.options;
            responsiveSettings = _.options.responsive || null;

            if (responsiveSettings && responsiveSettings.length > -1) {
                _.respondTo = _.options.respondTo || 'window';
                for (breakpoint in responsiveSettings) {
                    if (responsiveSettings.hasOwnProperty(breakpoint)) {
                        _.breakpoints.push(responsiveSettings[
                            breakpoint].breakpoint);
                        _.breakpointSettings[responsiveSettings[
                                breakpoint].breakpoint] =
                            responsiveSettings[breakpoint].settings;
                    }
                }
                _.breakpoints.sort(function(a, b) {
                    if (_.options.mobileFirst === true) {
                        return a - b;
                    } else {
                        return b - a;
                    }
                });
            }

            if (typeof document.mozHidden !== 'undefined') {
                _.hidden = 'mozHidden';
                _.visibilityChange = 'mozvisibilitychange';
            } else if (typeof document.msHidden !== 'undefined') {
                _.hidden = 'msHidden';
                _.visibilityChange = 'msvisibilitychange';
            } else if (typeof document.webkitHidden !== 'undefined') {
                _.hidden = 'webkitHidden';
                _.visibilityChange = 'webkitvisibilitychange';
            }

            _.autoPlay = $.proxy(_.autoPlay, _);
            _.autoPlayClear = $.proxy(_.autoPlayClear, _);
            _.changeSlide = $.proxy(_.changeSlide, _);
            _.clickHandler = $.proxy(_.clickHandler, _);
            _.selectHandler = $.proxy(_.selectHandler, _);
            _.setPosition = $.proxy(_.setPosition, _);
            _.swipeHandler = $.proxy(_.swipeHandler, _);
            _.dragHandler = $.proxy(_.dragHandler, _);
            _.keyHandler = $.proxy(_.keyHandler, _);
            _.autoPlayIterator = $.proxy(_.autoPlayIterator, _);

            _.instanceUid = instanceUid++;

            // A simple way to check for HTML strings
            // Strict HTML recognition (must start with <)
            // Extracted from jQuery v1.11 source
            _.htmlExpr = /^(?:\s*(<[\w\W]+>)[^>]*)$/;

            _.init();

            _.checkResponsive(true);

        }

        return Slick;

    }());

    Slick.prototype.addSlide = Slick.prototype.slickAdd = function(markup, index, addBefore) {

        var _ = this;

        if (typeof(index) === 'boolean') {
            addBefore = index;
            index = null;
        } else if (index < 0 || (index >= _.slideCount)) {
            return false;
        }

        _.unload();

        if (typeof(index) === 'number') {
            if (index === 0 && _.$slides.length === 0) {
                $(markup).appendTo(_.$slideTrack);
            } else if (addBefore) {
                $(markup).insertBefore(_.$slides.eq(index));
            } else {
                $(markup).insertAfter(_.$slides.eq(index));
            }
        } else {
            if (addBefore === true) {
                $(markup).prependTo(_.$slideTrack);
            } else {
                $(markup).appendTo(_.$slideTrack);
            }
        }

        _.$slides = _.$slideTrack.children(this.options.slide);

        _.$slideTrack.children(this.options.slide).detach();

        _.$slideTrack.append(_.$slides);

        _.$slides.each(function(index, element) {
            $(element).attr('data-slick-index', index);
        });

        _.$slidesCache = _.$slides;

        _.reinit();

    };

    Slick.prototype.animateHeight = function() {
        var _ = this;
        if (_.options.slidesToShow === 1 && _.options.adaptiveHeight === true && _.options.vertical === false) {
            var targetHeight = _.$slides.eq(_.currentSlide).outerHeight(true);
            _.$list.animate({
                height: targetHeight
            }, _.options.speed);
        }
    };

    Slick.prototype.animateSlide = function(targetLeft, callback) {

        var animProps = {},
            _ = this;

        _.animateHeight();

        if (_.options.rtl === true && _.options.vertical === false) {
            targetLeft = -targetLeft;
        }
        if (_.transformsEnabled === false) {
            if (_.options.vertical === false) {
                _.$slideTrack.animate({
                    left: targetLeft
                }, _.options.speed, _.options.easing, callback);
            } else {
                _.$slideTrack.animate({
                    top: targetLeft
                }, _.options.speed, _.options.easing, callback);
            }

        } else {

            if (_.cssTransitions === false) {
                if (_.options.rtl === true) {
                    _.currentLeft = -(_.currentLeft);
                }
                $({
                    animStart: _.currentLeft
                }).animate({
                    animStart: targetLeft
                }, {
                    duration: _.options.speed,
                    easing: _.options.easing,
                    step: function(now) {
                        now = Math.ceil(now);
                        if (_.options.vertical === false) {
                            animProps[_.animType] = 'translate(' +
                                now + 'px, 0px)';
                            _.$slideTrack.css(animProps);
                        } else {
                            animProps[_.animType] = 'translate(0px,' +
                                now + 'px)';
                            _.$slideTrack.css(animProps);
                        }
                    },
                    complete: function() {
                        if (callback) {
                            callback.call();
                        }
                    }
                });

            } else {

                _.applyTransition();
                targetLeft = Math.ceil(targetLeft);

                if (_.options.vertical === false) {
                    animProps[_.animType] = 'translate3d(' + targetLeft + 'px, 0px, 0px)';
                } else {
                    animProps[_.animType] = 'translate3d(0px,' + targetLeft + 'px, 0px)';
                }
                _.$slideTrack.css(animProps);

                if (callback) {
                    setTimeout(function() {

                        _.disableTransition();

                        callback.call();
                    }, _.options.speed);
                }

            }

        }

    };

    Slick.prototype.asNavFor = function(index) {
        var _ = this,
            asNavFor = _.options.asNavFor !== null ? $(_.options.asNavFor).slick('getSlick') : null;
        if (asNavFor !== null) asNavFor.slideHandler(index, true);
    };

    Slick.prototype.applyTransition = function(slide) {

        var _ = this,
            transition = {};

        if (_.options.fade === false) {
            transition[_.transitionType] = _.transformType + ' ' + _.options.speed + 'ms ' + _.options.cssEase;
        } else {
            transition[_.transitionType] = 'opacity ' + _.options.speed + 'ms ' + _.options.cssEase;
        }

        if (_.options.fade === false) {
            _.$slideTrack.css(transition);
        } else {
            _.$slides.eq(slide).css(transition);
        }

    };

    Slick.prototype.autoPlay = function() {

        var _ = this;

        if (_.autoPlayTimer) {
            clearInterval(_.autoPlayTimer);
        }

        if (_.slideCount > _.options.slidesToShow && _.paused !== true) {
            _.autoPlayTimer = setInterval(_.autoPlayIterator,
                _.options.autoplaySpeed);
        }

    };

    Slick.prototype.autoPlayClear = function() {

        var _ = this;
        if (_.autoPlayTimer) {
            clearInterval(_.autoPlayTimer);
        }

    };

    Slick.prototype.autoPlayIterator = function() {

        var _ = this;

        if (_.options.infinite === false) {

            if (_.direction === 1) {

                if ((_.currentSlide + 1) === _.slideCount -
                    1) {
                    _.direction = 0;
                }

                _.slideHandler(_.currentSlide + _.options.slidesToScroll);

            } else {

                if ((_.currentSlide - 1 === 0)) {

                    _.direction = 1;

                }

                _.slideHandler(_.currentSlide - _.options.slidesToScroll);

            }

        } else {

            _.slideHandler(_.currentSlide + _.options.slidesToScroll);

        }

    };

    Slick.prototype.buildArrows = function() {

        var _ = this;

        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {

            _.$prevArrow = $(_.options.prevArrow);
            _.$nextArrow = $(_.options.nextArrow);

            if (_.htmlExpr.test(_.options.prevArrow)) {
                _.$prevArrow.appendTo(_.options.appendArrows);
            }

            if (_.htmlExpr.test(_.options.nextArrow)) {
                _.$nextArrow.appendTo(_.options.appendArrows);
            }

            if (_.options.infinite !== true) {
                _.$prevArrow.addClass('slick-disabled');
            }

        }

    };

    Slick.prototype.buildDots = function() {

        var _ = this,
            i, dotString;

        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {

            dotString = '<ul class="' + _.options.dotsClass + '">';

            for (i = 0; i <= _.getDotCount(); i += 1) {
                dotString += '<li>' + _.options.customPaging.call(this, _, i) + '</li>';
            }

            dotString += '</ul>';

            _.$dots = $(dotString).appendTo(
                _.options.appendDots);

            _.$dots.find('li').first().addClass('slick-active').attr('aria-hidden', 'false');

        }

    };

    Slick.prototype.buildOut = function() {

        var _ = this;

        _.$slides = _.$slider.children(
            ':not(.slick-cloned)').addClass(
            'slick-slide');
        _.slideCount = _.$slides.length;

        _.$slides.each(function(index, element) {
            $(element).attr('data-slick-index', index);
        });

        _.$slidesCache = _.$slides;

        _.$slider.addClass('slick-slider');

        _.$slideTrack = (_.slideCount === 0) ?
            $('<div class="slick-track"/>').appendTo(_.$slider) :
            _.$slides.wrapAll('<div class="slick-track"/>').parent();

        _.$list = _.$slideTrack.wrap(
            '<div aria-live="polite" class="slick-list"/>').parent();
        _.$slideTrack.css('opacity', 0);

        if (_.options.centerMode === true || _.options.swipeToSlide === true) {
            _.options.slidesToScroll = 1;
        }

        $('img[data-lazy]', _.$slider).not('[src]').addClass('slick-loading');

        _.setupInfinite();

        _.buildArrows();

        _.buildDots();

        _.updateDots();

        if (_.options.accessibility === true) {
            _.$list.prop('tabIndex', 0);
        }

        _.setSlideClasses(typeof this.currentSlide === 'number' ? this.currentSlide : 0);

        if (_.options.draggable === true) {
            _.$list.addClass('draggable');
        }

    };

    Slick.prototype.buildRows = function() {

        var _ = this, a, b, c, newSlides, numOfSlides, originalSlides,slidesPerSection;

        newSlides = document.createDocumentFragment();
        originalSlides = _.$slider.children();

        if(_.options.rows > 1) {
            slidesPerSection = _.options.slidesPerRow * _.options.rows;
            numOfSlides = Math.ceil(
                originalSlides.length / slidesPerSection
            );

            for(a = 0; a < numOfSlides; a++){
                var slide = document.createElement('div');
                for(b = 0; b < _.options.rows; b++) {
                    var row = document.createElement('div');
                    for(c = 0; c < _.options.slidesPerRow; c++) {
                        var target = (a * slidesPerSection + ((b * _.options.slidesPerRow) + c));
                        if (originalSlides.get(target)) {
                            row.appendChild(originalSlides.get(target));
                        }
                    }
                    slide.appendChild(row);
                }
                newSlides.appendChild(slide);
            };
            _.$slider.html(newSlides);
            _.$slider.children().children().children()
                .width((100 / _.options.slidesPerRow) + "%")
                .css({'display': 'inline-block'});
        };

    };

    Slick.prototype.checkResponsive = function(initial) {

        var _ = this,
            breakpoint, targetBreakpoint, respondToWidth;
        var sliderWidth = _.$slider.width();
        var windowWidth = window.innerWidth || $(window).width();
        if (_.respondTo === 'window') {
            respondToWidth = windowWidth;
        } else if (_.respondTo === 'slider') {
            respondToWidth = sliderWidth;
        } else if (_.respondTo === 'min') {
            respondToWidth = Math.min(windowWidth, sliderWidth);
        }

        if (_.originalSettings.responsive && _.originalSettings
            .responsive.length > -1 && _.originalSettings.responsive !== null) {

            targetBreakpoint = null;

            for (breakpoint in _.breakpoints) {
                if (_.breakpoints.hasOwnProperty(breakpoint)) {
                    if (_.originalSettings.mobileFirst === false) {
                        if (respondToWidth < _.breakpoints[breakpoint]) {
                            targetBreakpoint = _.breakpoints[breakpoint];
                        }
                    } else {
                        if (respondToWidth > _.breakpoints[breakpoint]) {
                            targetBreakpoint = _.breakpoints[breakpoint];
                        }
                    }
                }
            }

            if (targetBreakpoint !== null) {
                if (_.activeBreakpoint !== null) {
                    if (targetBreakpoint !== _.activeBreakpoint) {
                        _.activeBreakpoint =
                            targetBreakpoint;
                        if (_.breakpointSettings[targetBreakpoint] === 'unslick') {
                            _.unslick();
                        } else {
                            _.options = $.extend({}, _.originalSettings,
                                _.breakpointSettings[
                                    targetBreakpoint]);
                            if (initial === true)
                                _.currentSlide = _.options.initialSlide;
                            _.refresh();
                        }
                    }
                } else {
                    _.activeBreakpoint = targetBreakpoint;
                    if (_.breakpointSettings[targetBreakpoint] === 'unslick') {
                        _.unslick();
                    } else {
                        _.options = $.extend({}, _.originalSettings,
                            _.breakpointSettings[
                                targetBreakpoint]);
                        if (initial === true)
                            _.currentSlide = _.options.initialSlide;
                        _.refresh();
                    }
                }
            } else {
                if (_.activeBreakpoint !== null) {
                    _.activeBreakpoint = null;
                    _.options = _.originalSettings;
                    if (initial === true)
                        _.currentSlide = _.options.initialSlide;
                    _.refresh();
                }
            }

        }

    };

    Slick.prototype.changeSlide = function(event, dontAnimate) {

        var _ = this,
            $target = $(event.target),
            indexOffset, slideOffset, unevenOffset;

        // If target is a link, prevent default action.
        $target.is('a') && event.preventDefault();

        unevenOffset = (_.slideCount % _.options.slidesToScroll !== 0);
        indexOffset = unevenOffset ? 0 : (_.slideCount - _.currentSlide) % _.options.slidesToScroll;

        switch (event.data.message) {

            case 'previous':
                slideOffset = indexOffset === 0 ? _.options.slidesToScroll : _.options.slidesToShow - indexOffset;
                if (_.slideCount > _.options.slidesToShow) {
                    _.slideHandler(_.currentSlide - slideOffset, false, dontAnimate);
                }
                break;

            case 'next':
                slideOffset = indexOffset === 0 ? _.options.slidesToScroll : indexOffset;
                if (_.slideCount > _.options.slidesToShow) {
                    _.slideHandler(_.currentSlide + slideOffset, false, dontAnimate);
                }
                break;

            case 'index':
                var index = event.data.index === 0 ? 0 :
                    event.data.index || $(event.target).parent().index() * _.options.slidesToScroll;

                _.slideHandler(_.checkNavigable(index), false, dontAnimate);
                break;

            default:
                return;
        }

    };

    Slick.prototype.checkNavigable = function(index) {

        var _ = this,
            navigables, prevNavigable;

        navigables = _.getNavigableIndexes();
        prevNavigable = 0;
        if (index > navigables[navigables.length - 1]) {
            index = navigables[navigables.length - 1];
        } else {
            for (var n in navigables) {
                if (index < navigables[n]) {
                    index = prevNavigable;
                    break;
                }
                prevNavigable = navigables[n];
            }
        }

        return index;
    };

    Slick.prototype.cleanUpEvents = function() {

        var _ = this;

        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {
            $('li', _.$dots).off('click.slick', _.changeSlide);
        }

        if (_.options.dots === true && _.options.pauseOnDotsHover === true && _.options.autoplay === true) {
            $('li', _.$dots)
                .off('mouseenter.slick', _.setPaused.bind(_, true))
                .off('mouseleave.slick', _.setPaused.bind(_, false));
        }

        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {
            _.$prevArrow && _.$prevArrow.off('click.slick', _.changeSlide);
            _.$nextArrow && _.$nextArrow.off('click.slick', _.changeSlide);
        }

        _.$list.off('touchstart.slick mousedown.slick', _.swipeHandler);
        _.$list.off('touchmove.slick mousemove.slick', _.swipeHandler);
        _.$list.off('touchend.slick mouseup.slick', _.swipeHandler);
        _.$list.off('touchcancel.slick mouseleave.slick', _.swipeHandler);

        _.$list.off('click.slick', _.clickHandler);

        if (_.options.autoplay === true) {
            $(document).off(_.visibilityChange, _.visibility);
        }

        _.$list.off('mouseenter.slick', _.setPaused.bind(_, true));
        _.$list.off('mouseleave.slick', _.setPaused.bind(_, false));

        if (_.options.accessibility === true) {
            _.$list.off('keydown.slick', _.keyHandler);
        }

        if (_.options.focusOnSelect === true) {
            $(_.$slideTrack).children().off('click.slick', _.selectHandler);
        }

        $(window).off('orientationchange.slick.slick-' + _.instanceUid, _.orientationChange);

        $(window).off('resize.slick.slick-' + _.instanceUid, _.resize);

        $('[draggable!=true]', _.$slideTrack).off('dragstart', _.preventDefault);

        $(window).off('load.slick.slick-' + _.instanceUid, _.setPosition);
        $(document).off('ready.slick.slick-' + _.instanceUid, _.setPosition);
    };

    Slick.prototype.cleanUpRows = function() {

        var _ = this, originalSlides;

        if(_.options.rows > 1) {
            originalSlides = _.$slides.children().children();
            originalSlides.removeAttr('style');
            _.$slider.html(originalSlides);
        }

    };

    Slick.prototype.clickHandler = function(event) {

        var _ = this;

        if (_.shouldClick === false) {
            event.stopImmediatePropagation();
            event.stopPropagation();
            event.preventDefault();
        }

    };

    Slick.prototype.destroy = function() {

        var _ = this;

        _.autoPlayClear();

        _.touchObject = {};

        _.cleanUpEvents();

        $('.slick-cloned', _.$slider).remove();

        if (_.$dots) {
            _.$dots.remove();
        }
        if (_.$prevArrow && (typeof _.options.prevArrow !== 'object')) {
            _.$prevArrow.remove();
        }
        if (_.$nextArrow && (typeof _.options.nextArrow !== 'object')) {
            _.$nextArrow.remove();
        }

        if (_.$slides) {
            _.$slides.removeClass('slick-slide slick-active slick-center slick-visible')
                .attr('aria-hidden', 'true')
                .removeAttr('data-slick-index')
                .css({
                    position: '',
                    left: '',
                    top: '',
                    zIndex: '',
                    opacity: '',
                    width: ''
                });

            _.$slider.html(_.$slides);
        }

        _.cleanUpRows();

        _.$slider.removeClass('slick-slider');
        _.$slider.removeClass('slick-initialized');

    };

    Slick.prototype.disableTransition = function(slide) {

        var _ = this,
            transition = {};

        transition[_.transitionType] = '';

        if (_.options.fade === false) {
            _.$slideTrack.css(transition);
        } else {
            _.$slides.eq(slide).css(transition);
        }

    };

    Slick.prototype.fadeSlide = function(slideIndex, callback) {

        var _ = this;

        if (_.cssTransitions === false) {

            _.$slides.eq(slideIndex).css({
                zIndex: 1000
            });

            _.$slides.eq(slideIndex).animate({
                opacity: 1
            }, _.options.speed, _.options.easing, callback);

        } else {

            _.applyTransition(slideIndex);

            _.$slides.eq(slideIndex).css({
                opacity: 1,
                zIndex: 1000
            });

            if (callback) {
                setTimeout(function() {

                    _.disableTransition(slideIndex);

                    callback.call();
                }, _.options.speed);
            }

        }

    };

    Slick.prototype.filterSlides = Slick.prototype.slickFilter = function(filter) {

        var _ = this;

        if (filter !== null) {

            _.unload();

            _.$slideTrack.children(this.options.slide).detach();

            _.$slidesCache.filter(filter).appendTo(_.$slideTrack);

            _.reinit();

        }

    };

    Slick.prototype.getCurrent = Slick.prototype.slickCurrentSlide = function() {

        var _ = this;
        return _.currentSlide;

    };

    Slick.prototype.getDotCount = function() {

        var _ = this;

        var breakPoint = 0;
        var counter = 0;
        var pagerQty = 0;

        if (_.options.infinite === true) {
            pagerQty = Math.ceil(_.slideCount / _.options.slidesToScroll);
        } else if (_.options.centerMode === true) {
            pagerQty = _.slideCount;
        } else {
            while (breakPoint < _.slideCount) {
                ++pagerQty;
                breakPoint = counter + _.options.slidesToShow;
                counter += _.options.slidesToScroll <= _.options.slidesToShow ? _.options.slidesToScroll : _.options.slidesToShow;
            }
        }

        return pagerQty - 1;

    };

    Slick.prototype.getLeft = function(slideIndex) {

        var _ = this,
            targetLeft,
            verticalHeight,
            verticalOffset = 0,
            targetSlide;

        _.slideOffset = 0;
        verticalHeight = _.$slides.first().outerHeight();

        if (_.options.infinite === true) {
            if (_.slideCount > _.options.slidesToShow) {
                _.slideOffset = (_.slideWidth * _.options.slidesToShow) * -1;
                verticalOffset = (verticalHeight * _.options.slidesToShow) * -1;
            }
            if (_.slideCount % _.options.slidesToScroll !== 0) {
                if (slideIndex + _.options.slidesToScroll > _.slideCount && _.slideCount > _.options.slidesToShow) {
                    if (slideIndex > _.slideCount) {
                        _.slideOffset = ((_.options.slidesToShow - (slideIndex - _.slideCount)) * _.slideWidth) * -1;
                        verticalOffset = ((_.options.slidesToShow - (slideIndex - _.slideCount)) * verticalHeight) * -1;
                    } else {
                        _.slideOffset = ((_.slideCount % _.options.slidesToScroll) * _.slideWidth) * -1;
                        verticalOffset = ((_.slideCount % _.options.slidesToScroll) * verticalHeight) * -1;
                    }
                }
            }
        } else {
            if (slideIndex + _.options.slidesToShow > _.slideCount) {
                _.slideOffset = ((slideIndex + _.options.slidesToShow) - _.slideCount) * _.slideWidth;
                verticalOffset = ((slideIndex + _.options.slidesToShow) - _.slideCount) * verticalHeight;
            }
        }

        if (_.slideCount <= _.options.slidesToShow) {
            _.slideOffset = 0;
            verticalOffset = 0;
        }

        if (_.options.centerMode === true && _.options.infinite === true) {
            _.slideOffset += _.slideWidth * Math.floor(_.options.slidesToShow / 2) - _.slideWidth;
        } else if (_.options.centerMode === true) {
            _.slideOffset = 0;
            _.slideOffset += _.slideWidth * Math.floor(_.options.slidesToShow / 2);
        }

        if (_.options.vertical === false) {
            targetLeft = ((slideIndex * _.slideWidth) * -1) + _.slideOffset;
        } else {
            targetLeft = ((slideIndex * verticalHeight) * -1) + verticalOffset;
        }

        if (_.options.variableWidth === true) {

            if (_.slideCount <= _.options.slidesToShow || _.options.infinite === false) {
                targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex);
            } else {
                targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex + _.options.slidesToShow);
            }

            targetLeft = targetSlide[0] ? targetSlide[0].offsetLeft * -1 : 0;

            if (_.options.centerMode === true) {
                if (_.options.infinite === false) {
                    targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex);
                } else {
                    targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex + _.options.slidesToShow + 1);
                }
                targetLeft = targetSlide[0] ? targetSlide[0].offsetLeft * -1 : 0;
                targetLeft += (_.$list.width() - targetSlide.outerWidth()) / 2;
            }
        }

        return targetLeft;

    };

    Slick.prototype.getOption = Slick.prototype.slickGetOption = function(option) {

        var _ = this;

        return _.options[option];

    };

    Slick.prototype.getNavigableIndexes = function() {

        var _ = this,
            breakPoint = 0,
            counter = 0,
            indexes = [],
            max;

        if (_.options.infinite === false) {
            max = _.slideCount - _.options.slidesToShow + 1;
            if (_.options.centerMode === true) max = _.slideCount;
        } else {
            breakPoint = _.options.slidesToScroll * -1;
            counter = _.options.slidesToScroll * -1;
            max = _.slideCount * 2;
        }

        while (breakPoint < max) {
            indexes.push(breakPoint);
            breakPoint = counter + _.options.slidesToScroll;
            counter += _.options.slidesToScroll <= _.options.slidesToShow ? _.options.slidesToScroll : _.options.slidesToShow;
        }

        return indexes;

    };

    Slick.prototype.getSlick = function() {

        return this;

    };

    Slick.prototype.getSlideCount = function() {

        var _ = this,
            slidesTraversed, swipedSlide, centerOffset;

        centerOffset = _.options.centerMode === true ? _.slideWidth * Math.floor(_.options.slidesToShow / 2) : 0;

        if (_.options.swipeToSlide === true) {
            _.$slideTrack.find('.slick-slide').each(function(index, slide) {
                if (slide.offsetLeft - centerOffset + ($(slide).outerWidth() / 2) > (_.swipeLeft * -1)) {
                    swipedSlide = slide;
                    return false;
                }
            });

            slidesTraversed = Math.abs($(swipedSlide).attr('data-slick-index') - _.currentSlide) || 1;

            return slidesTraversed;

        } else {
            return _.options.slidesToScroll;
        }

    };

    Slick.prototype.goTo = Slick.prototype.slickGoTo = function(slide, dontAnimate) {

        var _ = this;

        _.changeSlide({
            data: {
                message: 'index',
                index: parseInt(slide)
            }
        }, dontAnimate);

    };

    Slick.prototype.init = function() {

        var _ = this;

        if (!$(_.$slider).hasClass('slick-initialized')) {

            $(_.$slider).addClass('slick-initialized');
            _.buildRows();
            _.buildOut();
            _.setProps();
            _.startLoad();
            _.loadSlider();
            _.initializeEvents();
            _.updateArrows();
            _.updateDots();
        }

        _.$slider.trigger('init', [_]);

    };

    Slick.prototype.initArrowEvents = function() {

        var _ = this;

        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {
            _.$prevArrow.on('click.slick', {
                message: 'previous'
            }, _.changeSlide);
            _.$nextArrow.on('click.slick', {
                message: 'next'
            }, _.changeSlide);
        }

    };

    Slick.prototype.initDotEvents = function() {

        var _ = this;

        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {
            $('li', _.$dots).on('click.slick', {
                message: 'index'
            }, _.changeSlide);
        }

        if (_.options.dots === true && _.options.pauseOnDotsHover === true && _.options.autoplay === true) {
            $('li', _.$dots)
                .on('mouseenter.slick', _.setPaused.bind(_, true))
                .on('mouseleave.slick', _.setPaused.bind(_, false));
        }

    };

    Slick.prototype.initializeEvents = function() {

        var _ = this;

        _.initArrowEvents();

        _.initDotEvents();

        _.$list.on('touchstart.slick mousedown.slick', {
            action: 'start'
        }, _.swipeHandler);
        _.$list.on('touchmove.slick mousemove.slick', {
            action: 'move'
        }, _.swipeHandler);
        _.$list.on('touchend.slick mouseup.slick', {
            action: 'end'
        }, _.swipeHandler);
        _.$list.on('touchcancel.slick mouseleave.slick', {
            action: 'end'
        }, _.swipeHandler);

        _.$list.on('click.slick', _.clickHandler);

        if (_.options.autoplay === true) {
            $(document).on(_.visibilityChange, _.visibility.bind(_));
        }

        _.$list.on('mouseenter.slick', _.setPaused.bind(_, true));
        _.$list.on('mouseleave.slick', _.setPaused.bind(_, false));

        if (_.options.accessibility === true) {
            _.$list.on('keydown.slick', _.keyHandler);
        }

        if (_.options.focusOnSelect === true) {
            $(_.$slideTrack).children().on('click.slick', _.selectHandler);
        }

        $(window).on('orientationchange.slick.slick-' + _.instanceUid, _.orientationChange.bind(_));

        $(window).on('resize.slick.slick-' + _.instanceUid, _.resize.bind(_));

        $('[draggable!=true]', _.$slideTrack).on('dragstart', _.preventDefault);

        $(window).on('load.slick.slick-' + _.instanceUid, _.setPosition);
        $(document).on('ready.slick.slick-' + _.instanceUid, _.setPosition);

    };

    Slick.prototype.initUI = function() {

        var _ = this;

        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {

            _.$prevArrow.show();
            _.$nextArrow.show();

        }

        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {

            _.$dots.show();

        }

        if (_.options.autoplay === true) {

            _.autoPlay();

        }

    };

    Slick.prototype.keyHandler = function(event) {

        var _ = this;

        if (event.keyCode === 37 && _.options.accessibility === true) {
            _.changeSlide({
                data: {
                    message: 'previous'
                }
            });
        } else if (event.keyCode === 39 && _.options.accessibility === true) {
            _.changeSlide({
                data: {
                    message: 'next'
                }
            });
        }

    };

    Slick.prototype.lazyLoad = function() {

        var _ = this,
            loadRange, cloneRange, rangeStart, rangeEnd;

        function loadImages(imagesScope) {
            $('img[data-lazy]', imagesScope).each(function() {
                var image = $(this),
                    imageSource = $(this).attr('data-lazy'),
                    imageToLoad = document.createElement('img');

                imageToLoad.onload = function() {
                    image.animate({
                        opacity: 1
                    }, 200);
                };
                imageToLoad.src = imageSource;

                image
                    .css({
                        opacity: 0
                    })
                    .attr('src', imageSource)
                    .removeAttr('data-lazy')
                    .removeClass('slick-loading');
            });
        }

        if (_.options.centerMode === true) {
            if (_.options.infinite === true) {
                rangeStart = _.currentSlide + (_.options.slidesToShow / 2 + 1);
                rangeEnd = rangeStart + _.options.slidesToShow + 2;
            } else {
                rangeStart = Math.max(0, _.currentSlide - (_.options.slidesToShow / 2 + 1));
                rangeEnd = 2 + (_.options.slidesToShow / 2 + 1) + _.currentSlide;
            }
        } else {
            rangeStart = _.options.infinite ? _.options.slidesToShow + _.currentSlide : _.currentSlide;
            rangeEnd = rangeStart + _.options.slidesToShow;
            if (_.options.fade === true) {
                if (rangeStart > 0) rangeStart--;
                if (rangeEnd <= _.slideCount) rangeEnd++;
            }
        }

        loadRange = _.$slider.find('.slick-slide').slice(rangeStart, rangeEnd);
        loadImages(loadRange);

        if (_.slideCount <= _.options.slidesToShow) {
            cloneRange = _.$slider.find('.slick-slide');
            loadImages(cloneRange);
        } else
        if (_.currentSlide >= _.slideCount - _.options.slidesToShow) {
            cloneRange = _.$slider.find('.slick-cloned').slice(0, _.options.slidesToShow);
            loadImages(cloneRange);
        } else if (_.currentSlide === 0) {
            cloneRange = _.$slider.find('.slick-cloned').slice(_.options.slidesToShow * -1);
            loadImages(cloneRange);
        }

    };

    Slick.prototype.loadSlider = function() {

        var _ = this;

        _.setPosition();

        _.$slideTrack.css({
            opacity: 1
        });

        _.$slider.removeClass('slick-loading');

        _.initUI();

        if (_.options.lazyLoad === 'progressive') {
            _.progressiveLazyLoad();
        }

    };

    Slick.prototype.next = Slick.prototype.slickNext = function() {

        var _ = this;

        _.changeSlide({
            data: {
                message: 'next'
            }
        });

    };

    Slick.prototype.orientationChange = function() {

        var _ = this;

        _.checkResponsive();
        _.setPosition();

    };

    Slick.prototype.pause = Slick.prototype.slickPause = function() {

        var _ = this;

        _.autoPlayClear();
        _.paused = true;

    };

    Slick.prototype.play = Slick.prototype.slickPlay = function() {

        var _ = this;

        _.paused = false;
        _.autoPlay();

    };

    Slick.prototype.postSlide = function(index) {

        var _ = this;

        _.$slider.trigger('afterChange', [_, index]);

        _.animating = false;

        _.setPosition();

        _.swipeLeft = null;

        if (_.options.autoplay === true && _.paused === false) {
            _.autoPlay();
        }

    };

    Slick.prototype.prev = Slick.prototype.slickPrev = function() {

        var _ = this;

        _.changeSlide({
            data: {
                message: 'previous'
            }
        });

    };

    Slick.prototype.preventDefault = function(e) {
        e.preventDefault();
    };

    Slick.prototype.progressiveLazyLoad = function() {

        var _ = this,
            imgCount, targetImage;

        imgCount = $('img[data-lazy]', _.$slider).length;

        if (imgCount > 0) {
            targetImage = $('img[data-lazy]', _.$slider).first();
            targetImage.attr('src', targetImage.attr('data-lazy')).removeClass('slick-loading').load(function() {
                    targetImage.removeAttr('data-lazy');
                    _.progressiveLazyLoad();

                    if (_.options.adaptiveHeight === true) {
                        _.setPosition();
                    }
                })
                .error(function() {
                    targetImage.removeAttr('data-lazy');
                    _.progressiveLazyLoad();
                });
        }

    };

    Slick.prototype.refresh = function() {

        var _ = this,
            currentSlide = _.currentSlide;

        _.destroy();

        $.extend(_, _.initials);

        _.init();

        _.changeSlide({
            data: {
                message: 'index',
                index: currentSlide
            }
        }, false);

    };

    Slick.prototype.reinit = function() {

        var _ = this;

        _.$slides = _.$slideTrack.children(_.options.slide).addClass(
            'slick-slide');

        _.slideCount = _.$slides.length;

        if (_.currentSlide >= _.slideCount && _.currentSlide !== 0) {
            _.currentSlide = _.currentSlide - _.options.slidesToScroll;
        }

        if (_.slideCount <= _.options.slidesToShow) {
            _.currentSlide = 0;
        }

        _.setProps();

        _.setupInfinite();

        _.buildArrows();

        _.updateArrows();

        _.initArrowEvents();

        _.buildDots();

        _.updateDots();

        _.initDotEvents();

        if (_.options.focusOnSelect === true) {
            $(_.$slideTrack).children().on('click.slick', _.selectHandler);
        }

        _.setSlideClasses(0);

        _.setPosition();

        _.$slider.trigger('reInit', [_]);

    };

    Slick.prototype.resize = function() {

        var _ = this;

        if ($(window).width() !== _.windowWidth) {
            clearTimeout(_.windowDelay);
            _.windowDelay = window.setTimeout(function() {
                _.windowWidth = $(window).width();
                _.checkResponsive();
                _.setPosition();
            }, 50);
        }
    };

    Slick.prototype.removeSlide = Slick.prototype.slickRemove = function(index, removeBefore, removeAll) {

        var _ = this;

        if (typeof(index) === 'boolean') {
            removeBefore = index;
            index = removeBefore === true ? 0 : _.slideCount - 1;
        } else {
            index = removeBefore === true ? --index : index;
        }

        if (_.slideCount < 1 || index < 0 || index > _.slideCount - 1) {
            return false;
        }

        _.unload();

        if (removeAll === true) {
            _.$slideTrack.children().remove();
        } else {
            _.$slideTrack.children(this.options.slide).eq(index).remove();
        }

        _.$slides = _.$slideTrack.children(this.options.slide);

        _.$slideTrack.children(this.options.slide).detach();

        _.$slideTrack.append(_.$slides);

        _.$slidesCache = _.$slides;

        _.reinit();

    };

    Slick.prototype.setCSS = function(position) {

        var _ = this,
            positionProps = {},
            x, y;

        if (_.options.rtl === true) {
            position = -position;
        }
        x = _.positionProp == 'left' ? Math.ceil(position) + 'px' : '0px';
        y = _.positionProp == 'top' ? Math.ceil(position) + 'px' : '0px';

        positionProps[_.positionProp] = position;

        if (_.transformsEnabled === false) {
            _.$slideTrack.css(positionProps);
        } else {
            positionProps = {};
            if (_.cssTransitions === false) {
                positionProps[_.animType] = 'translate(' + x + ', ' + y + ')';
                _.$slideTrack.css(positionProps);
            } else {
                positionProps[_.animType] = 'translate3d(' + x + ', ' + y + ', 0px)';
                _.$slideTrack.css(positionProps);
            }
        }

    };

    Slick.prototype.setDimensions = function() {

        var _ = this;

        if (_.options.vertical === false) {
            if (_.options.centerMode === true) {
                _.$list.css({
                    padding: ('0px ' + _.options.centerPadding)
                });
            }
        } else {
            _.$list.height(_.$slides.first().outerHeight(true) * _.options.slidesToShow);
            if (_.options.centerMode === true) {
                _.$list.css({
                    padding: (_.options.centerPadding + ' 0px')
                });
            }
        }

        _.listWidth = _.$list.width();
        _.listHeight = _.$list.height();


        if (_.options.vertical === false && _.options.variableWidth === false) {
            _.slideWidth = Math.ceil(_.listWidth / _.options.slidesToShow);
            _.$slideTrack.width(Math.ceil((_.slideWidth * _.$slideTrack.children('.slick-slide').length)));

        } else if (_.options.variableWidth === true) {
            _.$slideTrack.width(5000 * _.slideCount);
        } else {
            _.slideWidth = Math.ceil(_.listWidth);
            _.$slideTrack.height(Math.ceil((_.$slides.first().outerHeight(true) * _.$slideTrack.children('.slick-slide').length)));
        }

        var offset = _.$slides.first().outerWidth(true) - _.$slides.first().width();
        if (_.options.variableWidth === false) _.$slideTrack.children('.slick-slide').width(_.slideWidth - offset);

    };

    Slick.prototype.setFade = function() {

        var _ = this,
            targetLeft;

        _.$slides.each(function(index, element) {
            targetLeft = (_.slideWidth * index) * -1;
            if (_.options.rtl === true) {
                $(element).css({
                    position: 'relative',
                    right: targetLeft,
                    top: 0,
                    zIndex: 800,
                    opacity: 0
                });
            } else {
                $(element).css({
                    position: 'relative',
                    left: targetLeft,
                    top: 0,
                    zIndex: 800,
                    opacity: 0
                });
            }
        });

        _.$slides.eq(_.currentSlide).css({
            zIndex: 900,
            opacity: 1
        });

    };

    Slick.prototype.setHeight = function() {

        var _ = this;

        if (_.options.slidesToShow === 1 && _.options.adaptiveHeight === true && _.options.vertical === false) {
            var targetHeight = _.$slides.eq(_.currentSlide).outerHeight(true);
            _.$list.css('height', targetHeight);
        }

    };

    Slick.prototype.setOption = Slick.prototype.slickSetOption = function(option, value, refresh) {

        var _ = this;
        _.options[option] = value;

        if (refresh === true) {
            _.unload();
            _.reinit();
        }

    };

    Slick.prototype.setPosition = function() {

        var _ = this;

        _.setDimensions();

        _.setHeight();

        if (_.options.fade === false) {
            _.setCSS(_.getLeft(_.currentSlide));
        } else {
            _.setFade();
        }

        _.$slider.trigger('setPosition', [_]);

    };

    Slick.prototype.setProps = function() {

        var _ = this,
            bodyStyle = document.body.style;

        _.positionProp = _.options.vertical === true ? 'top' : 'left';

        if (_.positionProp === 'top') {
            _.$slider.addClass('slick-vertical');
        } else {
            _.$slider.removeClass('slick-vertical');
        }

        if (bodyStyle.WebkitTransition !== undefined ||
            bodyStyle.MozTransition !== undefined ||
            bodyStyle.msTransition !== undefined) {
            if (_.options.useCSS === true) {
                _.cssTransitions = true;
            }
        }

        if (bodyStyle.OTransform !== undefined) {
            _.animType = 'OTransform';
            _.transformType = '-o-transform';
            _.transitionType = 'OTransition';
            if (bodyStyle.perspectiveProperty === undefined && bodyStyle.webkitPerspective === undefined) _.animType = false;
        }
        if (bodyStyle.MozTransform !== undefined) {
            _.animType = 'MozTransform';
            _.transformType = '-moz-transform';
            _.transitionType = 'MozTransition';
            if (bodyStyle.perspectiveProperty === undefined && bodyStyle.MozPerspective === undefined) _.animType = false;
        }
        if (bodyStyle.webkitTransform !== undefined) {
            _.animType = 'webkitTransform';
            _.transformType = '-webkit-transform';
            _.transitionType = 'webkitTransition';
            if (bodyStyle.perspectiveProperty === undefined && bodyStyle.webkitPerspective === undefined) _.animType = false;
        }
        if (bodyStyle.msTransform !== undefined) {
            _.animType = 'msTransform';
            _.transformType = '-ms-transform';
            _.transitionType = 'msTransition';
            if (bodyStyle.msTransform === undefined) _.animType = false;
        }
        if (bodyStyle.transform !== undefined && _.animType !== false) {
            _.animType = 'transform';
            _.transformType = 'transform';
            _.transitionType = 'transition';
        }
        _.transformsEnabled = (_.animType !== null && _.animType !== false);

    };


    Slick.prototype.setSlideClasses = function(index) {

        var _ = this,
            centerOffset, allSlides, indexOffset, remainder;

        _.$slider.find('.slick-slide').removeClass('slick-active').attr('aria-hidden', 'true').removeClass('slick-center');
        allSlides = _.$slider.find('.slick-slide');

        if (_.options.centerMode === true) {

            centerOffset = Math.floor(_.options.slidesToShow / 2);

            if (_.options.infinite === true) {

                if (index >= centerOffset && index <= (_.slideCount - 1) - centerOffset) {
                    _.$slides.slice(index - centerOffset, index + centerOffset + 1).addClass('slick-active').attr('aria-hidden', 'false');
                } else {
                    indexOffset = _.options.slidesToShow + index;
                    allSlides.slice(indexOffset - centerOffset + 1, indexOffset + centerOffset + 2).addClass('slick-active').attr('aria-hidden', 'false');
                }

                if (index === 0) {
                    allSlides.eq(allSlides.length - 1 - _.options.slidesToShow).addClass('slick-center');
                } else if (index === _.slideCount - 1) {
                    allSlides.eq(_.options.slidesToShow).addClass('slick-center');
                }

            }

            _.$slides.eq(index).addClass('slick-center');

        } else {

            if (index >= 0 && index <= (_.slideCount - _.options.slidesToShow)) {
                _.$slides.slice(index, index + _.options.slidesToShow).addClass('slick-active').attr('aria-hidden', 'false');
            } else if (allSlides.length <= _.options.slidesToShow) {
                allSlides.addClass('slick-active').attr('aria-hidden', 'false');
            } else {
                remainder = _.slideCount % _.options.slidesToShow;
                indexOffset = _.options.infinite === true ? _.options.slidesToShow + index : index;
                if (_.options.slidesToShow == _.options.slidesToScroll && (_.slideCount - index) < _.options.slidesToShow) {
                    allSlides.slice(indexOffset - (_.options.slidesToShow - remainder), indexOffset + remainder).addClass('slick-active').attr('aria-hidden', 'false');
                } else {
                    allSlides.slice(indexOffset, indexOffset + _.options.slidesToShow).addClass('slick-active').attr('aria-hidden', 'false');
                }
            }

        }

        if (_.options.lazyLoad === 'ondemand') {
            _.lazyLoad();
        }

    };

    Slick.prototype.setupInfinite = function() {

        var _ = this,
            i, slideIndex, infiniteCount;

        if (_.options.fade === true) {
            _.options.centerMode = false;
        }

        if (_.options.infinite === true && _.options.fade === false) {

            slideIndex = null;

            if (_.slideCount > _.options.slidesToShow) {

                if (_.options.centerMode === true) {
                    infiniteCount = _.options.slidesToShow + 1;
                } else {
                    infiniteCount = _.options.slidesToShow;
                }

                for (i = _.slideCount; i > (_.slideCount -
                        infiniteCount); i -= 1) {
                    slideIndex = i - 1;
                    $(_.$slides[slideIndex]).clone(true).attr('id', '')
                        .attr('data-slick-index', slideIndex - _.slideCount)
                        .prependTo(_.$slideTrack).addClass('slick-cloned');
                }
                for (i = 0; i < infiniteCount; i += 1) {
                    slideIndex = i;
                    $(_.$slides[slideIndex]).clone(true).attr('id', '')
                        .attr('data-slick-index', slideIndex + _.slideCount)
                        .appendTo(_.$slideTrack).addClass('slick-cloned');
                }
                _.$slideTrack.find('.slick-cloned').find('[id]').each(function() {
                    $(this).attr('id', '');
                });

            }

        }

    };

    Slick.prototype.setPaused = function(paused) {

        var _ = this;

        if (_.options.autoplay === true && _.options.pauseOnHover === true) {
            _.paused = paused;
            _.autoPlayClear();
        }
    };

    Slick.prototype.selectHandler = function(event) {

        var _ = this;

        var targetElement = $(event.target).is('.slick-slide') ?
            $(event.target) :
            $(event.target).parents('.slick-slide');

        var index = parseInt(targetElement.attr('data-slick-index'));

        if (!index) index = 0;

        if (_.slideCount <= _.options.slidesToShow) {
            _.$slider.find('.slick-slide').removeClass('slick-active').attr('aria-hidden', 'true');
            _.$slides.eq(index).addClass('slick-active').attr("aria-hidden", "false");
            if (_.options.centerMode === true) {
                _.$slider.find('.slick-slide').removeClass('slick-center');
                _.$slides.eq(index).addClass('slick-center');
            }
            _.asNavFor(index);
            return;
        }
        _.slideHandler(index);

    };

    Slick.prototype.slideHandler = function(index, sync, dontAnimate) {

        var targetSlide, animSlide, oldSlide, slideLeft, targetLeft = null,
            _ = this;

        sync = sync || false;

        if (_.animating === true && _.options.waitForAnimate === true) {
            return;
        }

        if (_.options.fade === true && _.currentSlide === index) {
            return;
        }

        if (_.slideCount <= _.options.slidesToShow) {
            return;
        }

        if (sync === false) {
            _.asNavFor(index);
        }

        targetSlide = index;
        targetLeft = _.getLeft(targetSlide);
        slideLeft = _.getLeft(_.currentSlide);

        _.currentLeft = _.swipeLeft === null ? slideLeft : _.swipeLeft;

        if (_.options.infinite === false && _.options.centerMode === false && (index < 0 || index > _.getDotCount() * _.options.slidesToScroll)) {
            if (_.options.fade === false) {
                targetSlide = _.currentSlide;
                if (dontAnimate !== true) {
                    _.animateSlide(slideLeft, function() {
                        _.postSlide(targetSlide);
                    });
                } else {
                    _.postSlide(targetSlide);
                }
            }
            return;
        } else if (_.options.infinite === false && _.options.centerMode === true && (index < 0 || index > (_.slideCount - _.options.slidesToScroll))) {
            if (_.options.fade === false) {
                targetSlide = _.currentSlide;
                if (dontAnimate !== true) {
                    _.animateSlide(slideLeft, function() {
                        _.postSlide(targetSlide);
                    });
                } else {
                    _.postSlide(targetSlide);
                }
            }
            return;
        }

        if (_.options.autoplay === true) {
            clearInterval(_.autoPlayTimer);
        }

        if (targetSlide < 0) {
            if (_.slideCount % _.options.slidesToScroll !== 0) {
                animSlide = _.slideCount - (_.slideCount % _.options.slidesToScroll);
            } else {
                animSlide = _.slideCount + targetSlide;
            }
        } else if (targetSlide >= _.slideCount) {
            if (_.slideCount % _.options.slidesToScroll !== 0) {
                animSlide = 0;
            } else {
                animSlide = targetSlide - _.slideCount;
            }
        } else {
            animSlide = targetSlide;
        }

        _.animating = true;

        _.$slider.trigger("beforeChange", [_, _.currentSlide, animSlide]);

        oldSlide = _.currentSlide;
        _.currentSlide = animSlide;

        _.setSlideClasses(_.currentSlide);

        _.updateDots();
        _.updateArrows();

        if (_.options.fade === true) {
            if (dontAnimate !== true) {
                _.fadeSlide(animSlide, function() {
                    _.postSlide(animSlide);
                });
            } else {
                _.postSlide(animSlide);
            }
            _.animateHeight();
            return;
        }

        if (dontAnimate !== true) {
            _.animateSlide(targetLeft, function() {
                _.postSlide(animSlide);
            });
        } else {
            _.postSlide(animSlide);
        }

    };

    Slick.prototype.startLoad = function() {

        var _ = this;

        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {

            _.$prevArrow.hide();
            _.$nextArrow.hide();

        }

        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {

            _.$dots.hide();

        }

        _.$slider.addClass('slick-loading');

    };

    Slick.prototype.swipeDirection = function() {

        var xDist, yDist, r, swipeAngle, _ = this;

        xDist = _.touchObject.startX - _.touchObject.curX;
        yDist = _.touchObject.startY - _.touchObject.curY;
        r = Math.atan2(yDist, xDist);

        swipeAngle = Math.round(r * 180 / Math.PI);
        if (swipeAngle < 0) {
            swipeAngle = 360 - Math.abs(swipeAngle);
        }

        if ((swipeAngle <= 45) && (swipeAngle >= 0)) {
            return (_.options.rtl === false ? 'left' : 'right');
        }
        if ((swipeAngle <= 360) && (swipeAngle >= 315)) {
            return (_.options.rtl === false ? 'left' : 'right');
        }
        if ((swipeAngle >= 135) && (swipeAngle <= 225)) {
            return (_.options.rtl === false ? 'right' : 'left');
        }
        if (_.options.verticalSwiping === true) {
            if ((swipeAngle >= 35) && (swipeAngle <= 135)) {
                return 'left';
            } else {
                return 'right';
            }
        }

        return 'vertical';

    };

    Slick.prototype.swipeEnd = function(event) {

        var _ = this,
            slideCount;

        _.dragging = false;

        _.shouldClick = (_.touchObject.swipeLength > 10) ? false : true;

        if (_.touchObject.curX === undefined) {
            return false;
        }

        if (_.touchObject.edgeHit === true) {
            _.$slider.trigger("edge", [_, _.swipeDirection()]);
        }

        if (_.touchObject.swipeLength >= _.touchObject.minSwipe) {

            switch (_.swipeDirection()) {
                case 'left':
                    slideCount = _.options.swipeToSlide ? _.checkNavigable(_.currentSlide + _.getSlideCount()) : _.currentSlide + _.getSlideCount();
                    _.slideHandler(slideCount);
                    _.currentDirection = 0;
                    _.touchObject = {};
                    _.$slider.trigger("swipe", [_, "left"]);
                    break;

                case 'right':
                    slideCount = _.options.swipeToSlide ? _.checkNavigable(_.currentSlide - _.getSlideCount()) : _.currentSlide - _.getSlideCount();
                    _.slideHandler(slideCount);
                    _.currentDirection = 1;
                    _.touchObject = {};
                    _.$slider.trigger("swipe", [_, "right"]);
                    break;
            }
        } else {
            if (_.touchObject.startX !== _.touchObject.curX) {
                _.slideHandler(_.currentSlide);
                _.touchObject = {};
            }
        }

    };

    Slick.prototype.swipeHandler = function(event) {

        var _ = this;

        if ((_.options.swipe === false) || ('ontouchend' in document && _.options.swipe === false)) {
            return;
        } else if (_.options.draggable === false && event.type.indexOf('mouse') !== -1) {
            return;
        }

        _.touchObject.fingerCount = event.originalEvent && event.originalEvent.touches !== undefined ?
            event.originalEvent.touches.length : 1;

        _.touchObject.minSwipe = _.listWidth / _.options
            .touchThreshold;

        if (_.options.verticalSwiping === true) {
            _.touchObject.minSwipe = _.listHeight / _.options
                .touchThreshold;
        }

        switch (event.data.action) {

            case 'start':
                _.swipeStart(event);
                break;

            case 'move':
                _.swipeMove(event);
                break;

            case 'end':
                _.swipeEnd(event);
                break;

        }

    };

    Slick.prototype.swipeMove = function(event) {

        var _ = this,
            edgeWasHit = false,
            curLeft, swipeDirection, swipeLength, positionOffset, touches;

        touches = event.originalEvent !== undefined ? event.originalEvent.touches : null;

        if (!_.dragging || touches && touches.length !== 1) {
            return false;
        }

        curLeft = _.getLeft(_.currentSlide);

        _.touchObject.curX = touches !== undefined ? touches[0].pageX : event.clientX;
        _.touchObject.curY = touches !== undefined ? touches[0].pageY : event.clientY;

        _.touchObject.swipeLength = Math.round(Math.sqrt(
            Math.pow(_.touchObject.curX - _.touchObject.startX, 2)));

        if (_.options.verticalSwiping === true) {
            _.touchObject.swipeLength = Math.round(Math.sqrt(
                Math.pow(_.touchObject.curY - _.touchObject.startY, 2)));
        }

        swipeDirection = _.swipeDirection();

        if (swipeDirection === 'vertical') {
            return;
        }

        if (event.originalEvent !== undefined && _.touchObject.swipeLength > 4) {
            event.preventDefault();
        }

        positionOffset = (_.options.rtl === false ? 1 : -1) * (_.touchObject.curX > _.touchObject.startX ? 1 : -1);
        if (_.options.verticalSwiping === true) {
            positionOffset = _.touchObject.curY > _.touchObject.startY ? 1 : -1;
        }


        swipeLength = _.touchObject.swipeLength;

        _.touchObject.edgeHit = false;

        if (_.options.infinite === false) {
            if ((_.currentSlide === 0 && swipeDirection === "right") || (_.currentSlide >= _.getDotCount() && swipeDirection === "left")) {
                swipeLength = _.touchObject.swipeLength * _.options.edgeFriction;
                _.touchObject.edgeHit = true;
            }
        }

        if (_.options.vertical === false) {
            _.swipeLeft = curLeft + swipeLength * positionOffset;
        } else {
            _.swipeLeft = curLeft + (swipeLength * (_.$list.height() / _.listWidth)) * positionOffset;
        }
        if (_.options.verticalSwiping === true) {
            _.swipeLeft = curLeft + swipeLength * positionOffset;
        }

        if (_.options.fade === true || _.options.touchMove === false) {
            return false;
        }

        if (_.animating === true) {
            _.swipeLeft = null;
            return false;
        }

        _.setCSS(_.swipeLeft);

    };

    Slick.prototype.swipeStart = function(event) {

        var _ = this,
            touches;

        if (_.touchObject.fingerCount !== 1 || _.slideCount <= _.options.slidesToShow) {
            _.touchObject = {};
            return false;
        }

        if (event.originalEvent !== undefined && event.originalEvent.touches !== undefined) {
            touches = event.originalEvent.touches[0];
        }

        _.touchObject.startX = _.touchObject.curX = touches !== undefined ? touches.pageX : event.clientX;
        _.touchObject.startY = _.touchObject.curY = touches !== undefined ? touches.pageY : event.clientY;

        _.dragging = true;

    };

    Slick.prototype.unfilterSlides = Slick.prototype.slickUnfilter = function() {

        var _ = this;

        if (_.$slidesCache !== null) {

            _.unload();

            _.$slideTrack.children(this.options.slide).detach();

            _.$slidesCache.appendTo(_.$slideTrack);

            _.reinit();

        }

    };

    Slick.prototype.unload = function() {

        var _ = this;

        $('.slick-cloned', _.$slider).remove();
        if (_.$dots) {
            _.$dots.remove();
        }
        if (_.$prevArrow && (typeof _.options.prevArrow !== 'object')) {
            _.$prevArrow.remove();
        }
        if (_.$nextArrow && (typeof _.options.nextArrow !== 'object')) {
            _.$nextArrow.remove();
        }
        _.$slides.removeClass('slick-slide slick-active slick-visible').attr("aria-hidden", "true").css('width', '');

    };

    Slick.prototype.unslick = function() {

        var _ = this;
        _.destroy();

    };

    Slick.prototype.updateArrows = function() {

        var _ = this,
            centerOffset;

        centerOffset = Math.floor(_.options.slidesToShow / 2);

        if (_.options.arrows === true && _.options.infinite !==
            true && _.slideCount > _.options.slidesToShow) {
            _.$prevArrow.removeClass('slick-disabled');
            _.$nextArrow.removeClass('slick-disabled');
            if (_.currentSlide === 0) {
                _.$prevArrow.addClass('slick-disabled');
                _.$nextArrow.removeClass('slick-disabled');
            } else if (_.currentSlide >= _.slideCount - _.options.slidesToShow && _.options.centerMode === false) {
                _.$nextArrow.addClass('slick-disabled');
                _.$prevArrow.removeClass('slick-disabled');
            } else if (_.currentSlide >= _.slideCount - 1 && _.options.centerMode === true) {
                _.$nextArrow.addClass('slick-disabled');
                _.$prevArrow.removeClass('slick-disabled');
            }
        }

    };

    Slick.prototype.updateDots = function() {

        var _ = this;

        if (_.$dots !== null) {

            _.$dots.find('li').removeClass('slick-active').attr("aria-hidden", "true");
            _.$dots.find('li').eq(Math.floor(_.currentSlide / _.options.slidesToScroll)).addClass('slick-active').attr("aria-hidden", "false");

        }

    };

    Slick.prototype.visibility = function() {

        var _ = this;

        if (document[_.hidden]) {
            _.paused = true;
            _.autoPlayClear();
        } else {
            _.paused = false;
            _.autoPlay();
        }

    };

    $.fn.slick = function() {
        var _ = this,
            opt = arguments[0],
            args = Array.prototype.slice.call(arguments, 1),
            l = _.length,
            i = 0,
            ret;
        for (i; i < l; i++) {
            if (typeof opt == 'object' || typeof opt == 'undefined')
                _[i].slick = new Slick(_[i], opt);
            else
                ret = _[i].slick[opt].apply(_[i].slick, args);
            if (typeof ret != 'undefined') return ret;
        }
        return _;
    };

}));


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

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



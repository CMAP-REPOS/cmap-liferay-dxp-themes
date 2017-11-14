<div class="search-widget">
  <label>
  	<div class="search-widget-decorators">
	    <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 19 19" width="19" height="19"> <path stroke="#3C5976" stroke-width="2" fill="none" d="M11.5,11.5c1-1,1.6-2.4,1.6-3.9c0-3.1-2.5-5.6-5.6-5.6S2,4.5,2,7.6c0,3.1,2.5,5.6,5.6,5.6 C9.1,13.2,10.5,12.5,11.5,11.5L18,18L11.5,11.5z"/></svg>
	    <span class="search-placeholder-text">Search</span>
    </div>
    <input class="search-widget-field" type="text" aria-describedby="site-search-addon">
  </label>
</div>

<script>

Liferay.on('allPortletsReady', function(){
	$('.search-widget-field').focus(function() {
	  $(this).parent().find('.search-placeholder-text').fadeOut();
	});

	$('.search-widget-field').blur(function() {
	  if ($(this).val().trim() === '') {
	    $(this).parent().find('.search-placeholder-text').fadeIn();
	  }
	});

	$('.search-widget-decorators .search-icon').on('click', function(e) {
	  e.preventDefault();
	  var value = $(this).parent().parent().find('.search-widget-field').val();
	  document.location = "/search?q=" + escape(value);
	});

	$('.search-widget-field').on('keypress', function(e) {
	  var enterKey = 13;
	  if (e.which == enterKey) {
	    document.location = "/search?q=" + escape($(this).val());
	    $(this).blur();
	  }
	});
});

</script>
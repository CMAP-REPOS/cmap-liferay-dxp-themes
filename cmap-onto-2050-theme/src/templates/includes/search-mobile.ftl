<div id="mobile-search" class="input-group">
	<span class="input-group-btn">
		<button class="search-button btn btn-default" type="button">
			<span class="glyphicon glyphicon-search"></span>
		</button>
	</span>
	<input class="search-input form-control" type="text" value="" placeholder="Search">
</div>

<script type="text/javascript">
Liferay.on('allPortletsReady', function(){
	var $search_input = $('#mobile-search').find('.search-input'),
		$search_button = $('#mobile-search').find('.search-button');
	$search_input.on("focus",function(){
		$search_input.attr('placeholder','');
	});
	$search_input.on("blur", function() {
		if ($(this).val().trim() === '') {
			$search_input.val("");
			$search_input.attr('placeholder','Search');
		}
	});
	$search_button.on('touchstart', function(e){
		e.preventDefault();
		var value = $search_input.val();
		document.location = "/search?q=" + escape(value);
	});
	$search_input.on('keypress', function(e) {
		var enterKey = 13;
		if (e.which == enterKey) {
			document.location = "/search?q=" + escape($(this).val());
			$(this).blur();
		}
	});
});
</script>
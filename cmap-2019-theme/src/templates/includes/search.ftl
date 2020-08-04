<div id="desktop-search" class="input-group input-group-lg">
	<span class="input-group-btn">
		<button class="search-button btn btn-default" type="button">
			<span class="glyphicon glyphicon-search"></span>
		</button>
	</span>
	<input class="search-input form-control" type="text" value="" placeholder="Search">
</div>

<script type="text/javascript">
Liferay.on('allPortletsReady', function(){
	var $search_input = $('#desktop-search').find('.search-input'),
		$search_button = $('#desktop-search').find('.search-button');
	$search_input.on("focus",function(){
		$search_input.attr('placeholder','');
	});
	$search_input.on("blur", function() {
		if ($(this).val().trim() === '') {
			$search_input.val("");
			$search_input.attr('placeholder','Search');
		}
	});
	$search_button.on('click', function(e){
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
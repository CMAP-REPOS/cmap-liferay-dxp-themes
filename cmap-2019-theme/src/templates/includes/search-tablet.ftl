<div id="tablet-search" class="input-group input-group-lg">
	<span class="input-group-btn">
		<button class="search-button-tablet btn btn-default" type="button">
			<span class="glyphicon glyphicon-search"></span>
		</button>
	</span>
    <input class="search-input-tablet form-control" type="text" value="" placeholder="Search">
</div>

<script type="text/javascript">
    Liferay.on('allPortletsReady', function(){
        var $search_input = $('#tablet-search').find('.search-input-tablet'),
            $search_button = $('#tablet-search').find('.search-button-tablet');
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
<div class="page-nav">
  <h4 class="widget-headline">${Heading.getData()}</h4>
	<ul class="list-unstyled"></ul>
</div>

<script>
Liferay.on(
	'allPortletsReady',
	function() {
		var $nav = $('.page-nav');


		function addLink(){
			var $this = $(this),
					id = $this.attr('id'),
					title = $this.find('.section-title').text(),
					$item = $('<li><h4><a href="#'+id+'">'+title+'</a></h4></li>');
			$item.click(handleClick);
			$nav.find('ul').append($item);
		}
		$('.anchor-point').each(addLink);

		var trigger_offset = 0;
		if($('.signed-in').length){
			trigger_offset = 64;
		}

		function handleClick(event){
			event.preventDefault();
			var target = $(event.target).attr('href');
			var offset = $(target).offset().top;
			$('html,body').animate({
				scrollTop: offset - trigger_offset
			}, 800);
			// console.log(event, event.target, $(event.target), );

		}

		var trigger = $nav.offset().top;
		$(window).scroll(_.throttle(function(){
			if(window.scrollY > (trigger - trigger_offset)){
				$nav.addClass('fixed');
			} else {
				$nav.removeClass('fixed');
			}
		}, 100));
	}
);
</script>

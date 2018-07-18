<div class="page-nav">
  <h5 class="widget-headline">${Heading.getData()}</h5>
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
					$item = $('<li><h5><a href="#'+id+'">'+title+'</a></h5></li>');
			console.log($this, id, title, $item);
			$item.click(handleClick);
			$nav.find('ul').append($item);
		}
		$('.anchor-point').each(addLink);

		

		function handleClick(event){
			event.preventDefault();
			var target = $(event.target).attr('href');
			var offset = $(target).offset().top;
			var trigger_offset = getTriggerOffset();
			$('html,body').animate({
				scrollTop: offset - trigger_offset
			}, 800);
			// console.log(event, event.target, $(event.target), );
		}

		function getTriggerOffset(){
			var answer = 0;
			if($('.signed-in').length){
				answer += 64;
			}	
			if($('#scroll-nav.active').length){
				answer += $('#scroll-nav.active').innerHeight();
			}
			return answer;
		}

		var trigger = $nav.offset().top;
		$(window).scroll(_.throttle(function(){
			var trigger_offset = getTriggerOffset();
			// console.log(window.scrollY, trigger, trigger_offset,(trigger + trigger_offset));
			if(window.scrollY > (trigger - trigger_offset)){
				$nav.addClass('fixed');
			} else {
				$nav.removeClass('fixed');
			}
		}, 100));
	}
);
</script>

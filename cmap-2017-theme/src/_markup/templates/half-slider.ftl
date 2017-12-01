<#if HalfSlides.getSiblings()?has_content>
<section class="half-slider slider" id="${randomNamespace}">
	<div class="slider-container"></div>
	<div class="row">
		<#list HalfSlides.getSiblings() as Slide>
			<div class="item col-xl-8 col-sm-16">
				<#if Slide.SlideImage.getData()?? && Slide.SlideImage.getData() != "">
					<img class="slide-image" data-fileentryid="${Slide.SlideImage.getAttribute("fileEntryId")}" alt="${Slide.SlideImage.getAttribute("alt")}" src="${Slide.SlideImage.getData()}" />
				</#if>
				<div class="slide-text">
					<#if Slide.SlideText?has_content>
						<h2 class="slide-title">${Slide.SlideText.getData()}</h2>
					</#if>
					<#if Slide.SlideDescription?has_content>
						<p  class="slide-description">${Slide.SlideDescription.getData()}</p>
					</#if>
				</div>
			</div>
		</#list>
	</div>
</section>
</#if>

<script>

  $(document).ready(function(){
    var $this = $('#${randomNamespace}');
    var $container = $this.find('.slider-container');
    var $spacer = $("<div class='col-xl-8 col-sm-16'></div>");
    var $nav = $("<nav class='slider-nav'></nav>");

    var items = $this.find('.item');
    var container = $('<div class="slider-slide"></div>');
    var row = $('<div class="row"></div>');

    function addItem(dom){
      if(dom){
        row.append(dom);
      } else {
        row.append($spacer.clone());
      }
    }

    // one iteration for each row of two items
    for(let i=0; i<Math.ceil(items.length / 2); i++){

      // reset the row element
      container = $('<div class="slider-slide"></div>');
      row = $('<div class="row"></div>');

      var $navItem = $('<div class="nav-item"></div>');
      if(i===0){ $navItem.addClass('active'); }
      $navItem.click(function(){
        $container.css('transform', 'translateX(-'+(i*100)+'vw)');
  			$nav.find('.nav-item.active').removeClass('active');
  			$(this).addClass('active');
      });
      $nav.append($navItem);

      // builds a row
      addItem(items[(i*2)]);
      addItem(items[(i*2)+1]);

      container.append(row); // wrapping the bootstrap row
      $container.append(container);
    }

    if($nav.find('.nav-item').length > 1){
      $this.append($nav);
    } 
  });
</script>

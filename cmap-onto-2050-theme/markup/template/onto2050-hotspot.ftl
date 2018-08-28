<#if Layer.getSiblings()?has_content>
<div id="${randomNamespace}" class="hotspot-widget row">
  <hr class="hotspot-rule" />

  <#if Title.getData() != '' && Description.getData() != ''>
    <header class="hotspot-header row">
      <#if PDF.getData() != ''>
        <div class="left">  
          <a class="download-link whitney-small bold" href="${PDF.getData()}" target="_blank">
            Download as PDF 
            <svg viewBox="0 0 50 50" width="50" height="50">
              <path d="M32.53,27.78c-0.61,0-1.1,0.49-1.1,1.1v3.92H18.57v-3.92c0-0.61-0.49-1.1-1.1-1.1s-1.1,0.49-1.1,1.1V35h17.26v-6.12 C33.63,28.27,33.14,27.78,32.53,27.78z"/>
              <path d="M25,29.24l4.65-4.04c0.46-0.4,0.51-1.09,0.11-1.55c-0.4-0.46-1.09-0.51-1.55-0.11l-2.12,1.84V16.1 c0-0.61-0.49-1.1-1.1-1.1s-1.1,0.49-1.1,1.1v9.28l-2.12-1.84c-0.46-0.4-1.15-0.35-1.55,0.11c-0.4,0.46-0.35,1.15,0.11,1.55 L25,29.24z"/>
            </svg>
          </a>
        </div>
      </#if>

      <div class="center">
        <#if Title.getData() != ''>
          <div class="whitney-normal bold">${Title.getData()}</div>
        </#if>
        <#if Description.getData() != ''>
          <div class="whitney-small">${Description.getData()}</div>
        </#if>
      </div>
    </header>
  </#if>

  <div id="${randomNamespace}_hotspots_desktop" class="hotspot-layer-contents" aria-live="polite">
    <#list Layer.getSiblings() as cur_Layer>
      <div class="hotspot-layer" data-layer-name="${cur_Layer.getData()}">

        <#if cur_Layer.Caption.getSiblings()?has_content>
          <#list cur_Layer.Caption.getSiblings() as cur_caption>
          
          <#assign top = cur_caption.Top.getData()?number>
          <#assign left = cur_caption.Left.getData()?number>
          <div class="hotspot-spot" style="top: ${top}%; left: ${left}%;">
            <#if (left > 50)>
              <div class="caption-content">
                <div class="whitney-normal bold">${cur_caption.getData()}</div>
              </div>
              <div class="caption-toggle">
                <img alt="Close icon for picture captions" src="/o/cmap-onto-2050-theme/images/icons/ic_close.svg" />
              </div>
            <#else>
              <div class="caption-toggle">
                <img alt="Close icon for picture captions" src="/o/cmap-onto-2050-theme/images/icons/ic_close.svg" />
              </div>
              <div class="caption-content">
                <div class="whitney-normal bold">${cur_caption.getData()}</div>
              </div>
            </#if>
            <div class="caption-background"></div>
            <div class="caption-background-size"></div>
          </div>
          </#list>
        </#if>

        <#if cur_Layer.Image.getData()?? && cur_Layer.Image.getData() != "">
          <img class="hotspot-layer-background" data-fileentryid="${cur_Layer.Image.getAttribute("fileEntryId")}" alt="${cur_Layer.Image.getAttribute("alt")}" src="${cur_Layer.Image.getData()}" />
          <hr class="hotspot-rule" />
        </#if>
      </div>
    </#list>
  </div>

  <div class="mobile-hotspot-information" id="${randomNamespace}_hotspots_mobile">
    <#list Layer.getSiblings() as cur_Layer>
      <ul data-layer-name="${cur_Layer.getData()}">
        <#list cur_Layer.Caption.getSiblings() as cur_caption>
          <li>${cur_caption.getData()}</li>
        </#list>
      </ul>
    </#list>
  </div>

  <footer class="hotspot-footer row">
    <div class="col-md-4 col-sm-16">
      <div class="hotspot-footer-instructions">
        <div class="whitney-small bold">Click to toggle views</div>
      </div>
    </div>
    <div class="col-md-12 col-sm-16"><nav aria-controls="${randomNamespace}_hotspots_mobile ${randomNamespace}_hotspots_desktop"></nav></div>
	</footer>

</div>
</#if>

<script>
Liferay.on(
	'allPortletsReady',
	function() {

    // what point does the caption flip around and open to the left
    var FLIP_CUTOFF = 0.5; // switch up there in the markup also

    $('#${randomNamespace}').each(function(){
      var $hotspot = $(this);
      var $layers = $hotspot.find('.hotspot-layer');
      
      if($layers.length < 2){
        $hotspot.find('.hotspot-footer').css('display', 'none');
      }

      var $portlet_column = $hotspot.parents('.portlet-column');
      var $header = $hotspot.find('.hotspot-header');
      var $left = $header.find('.left');
      var $center = $header.find('.center');

      if($portlet_column.hasClass('col-md-8')){
        $center.addClass('col-md-10 col-sm-16');
        if($left.length){
          $left.addClass('col-md-3 col-sm-16');
        } else {
          $center.addClass('col-md-offset-3');
        }
      }

      if($portlet_column.hasClass('col-md-16')){
        $center.addClass('col-md-6 col-sm-16');
        if($left.length){
          $left.addClass('col-md-5 col-sm-16');
        } else {
          $center.addClass('col-sm-offset-5');
        }
      }

      $layers.each(function(i,el){
        var $el = $(el);
        var layer_name = $el.data('layer-name');
        var $nav_item = $('<div class="hotspot-layer-item" data-toggle="'+layer_name+'"><div class="whitney-normal bold">'+layer_name+'</div></div>');

        $nav_item.click(function(){
          var self = this;
          $('.hotspot-layer-item').removeClass('active');
					$(this).addClass('active');
          
          console.log(layer_name);
          $('.mobile-hotspot-information ul').removeClass('active');
          $('.mobile-hotspot-information ul[data-layer-name="'+layer_name+'"]').addClass('active');

          $layers.each(function(i_b,el_b){
            if(el_b == el){
              $(el_b).removeClass('hidden');
            } else {
              $(el_b).addClass('hidden');
            }
          });
        });
        $hotspot.find('.hotspot-footer nav').append($nav_item);
      });


			$('.hotspot-spot').each(function(index){        
				var $this = $(this);
        var $background = $this.find('.caption-background');
				var $toggle = $this.find('.caption-toggle');
				$this.addClass('min');
				$background.css('width', $toggle.innerWidth());
				$background.css('height', $toggle.innerHeight());
        // the caption is too far to the left and we need to flip it

        if(parseInt($this.css('left')) / $hotspot.innerWidth() > FLIP_CUTOFF){
          $this.addClass('flipped');
        }
      });

      $hotspot.find('.mobile-hotspot-information ul').removeClass('active');      
      $hotspot.find('.mobile-hotspot-information ul:first-of-type').addClass('active');
			$layers.addClass('hidden');
			$hotspot.find('.hotspot-layer:first-of-type').removeClass('hidden');
			$hotspot.find('.hotspot-layer-item:first-of-type').addClass('active');
    });

    $('.caption-toggle').click(function(){
      var parent = $(this).parent().toggleClass('min');

			var toggle_width = $(this).innerWidth();
			var toggle_height = $(this).innerHeight();

      $('.hotspot-spot').each(function(index){
        var $this = $(this);
        var $background = $this.find('.caption-background');
        var $caption = $this.find('.caption-content');
        var $toggle = $this.find('.caption-toggle');

        if(this == parent[0]){
          if(parent.hasClass('min')){
            $background.css('width', toggle_width);
            $background.css('height', toggle_height);
          } else {
            var w = $this.hasClass('flipped') ? $caption.innerWidth() : $caption.innerWidth() + $toggle.innerWidth();
            $background.css('width', w);
            $background.css('height', $caption.innerHeight());
          }
        } else {
          $(this).addClass('min');
          $background.css('width', toggle_width);
          $background.css('height', toggle_height);
        }
      });
    });
	}
);
</script>
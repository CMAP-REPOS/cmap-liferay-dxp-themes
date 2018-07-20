<#if Layer.getSiblings()?has_content>
<div id="${randomNamespace}" class="hotspot-widget row">

	<#list Layer.getSiblings() as cur_Layer>
		<div class="hotspot-layer" data-layer-name="${cur_Layer.getData()}">
		  <#if cur_Layer.Caption.getSiblings()?has_content>
		  	<#list cur_Layer.Caption.getSiblings() as cur_caption>
		    <div class="hotspot-spot" style="top: ${cur_caption.Top.getData()}%; left: ${cur_caption.Left.getData()}%;">
		      <div class="caption-toggle">
		        <img src="https://clarknelson.com/drop/ic_close.svg" />
		      </div>
		      <div class="caption-content">
		        <h5>${cur_caption.getData()}</h5>
		      </div>
		      <div class="caption-background"></div>
		      <div class="caption-background-size"></div>
		    </div>
		  	</#list>
		  </#if>
			<#if cur_Layer.Image.getData()?? && cur_Layer.Image.getData() != "">
			  <img class="hotspot-layer-background" data-fileentryid="${cur_Layer.Image.getAttribute("fileEntryId")}" alt="${cur_Layer.Image.getAttribute("alt")}" src="${cur_Layer.Image.getData()}" />
			</#if>
		</div>
	</#list>

  <div class="hotspot-footer">
    <div class="col-md-4 col-sm-16">
      <div class="hotspot-footer-instructions">
        <h6>Click to toggle views</h6>
      </div>
    </div>
    <div class="col-md-12 col-sm-16"><nav></nav></div>
	</div>

</div>
</#if>

<script>
Liferay.on(
	'allPortletsReady',
	function() {

    $('#${randomNamespace}').each(function(){
      var $this = $(this);
      var $layers = $this.find('.hotspot-layer');
      
      if($layers.length < 2){
        $this.find('.hotspot-footer').css('display', 'none');
      }

      $layers.each(function(i,el){
        var $el = $(el);
        var layer_name = $el.data('layer-name');
        var $nav_item = $('<div class="hotspot-layer-item" data-toggle="'+layer_name+'"><h4>'+layer_name+'</h4></div>');

        $nav_item.click(function(){
          var self = this;
          $('.hotspot-layer-item').removeClass('active');
					$(this).addClass('active');

          $layers.each(function(i_b,el_b){
            if(el_b == el){
              $(el_b).removeClass('hidden');
            } else {
              $(el_b).addClass('hidden');
            }
          });
        });
        $this.find('.hotspot-footer nav').append($nav_item);
      });

      console.log($('.hotspot-spot'));

			$('.hotspot-spot').each(function(index){        
				var $this = $(this);
        var $background = $this.find('.caption-background');
				var $toggle = $this.find('.caption-toggle');
				$this.addClass('min');
				$background.css('width', $toggle.innerWidth());
				$background.css('height', $toggle.innerHeight());
        console.log($this);
      });

			$layers.addClass('hidden');
			$this.find('.hotspot-layer:first-of-type').removeClass('hidden');
			$this.find('.hotspot-layer-item:first-of-type').addClass('active');
    });

    $('.caption-toggle').click(function(){
      var parent = $(this).parent().toggleClass('min');

			var toggle_width = $(this).innerWidth();
			var toggle_height = $(this).innerHeight();

      $('.hotspot-spot').each(function(index){
        var $background = $(this).find('.caption-background');
        var $background_size = $(this).find('.caption-background-size');

        if(this == parent[0]){
          if(parent.hasClass('min')){
            $background.css('width', toggle_width);
            $background.css('height', toggle_height);
          } else {
            $background.css('width', $background_size.innerWidth());
            $background.css('height', $background_size.innerHeight());
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

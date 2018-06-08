
<#assign unique_id = randomNamespace>

<#if Layer.getSiblings()?has_content>
<div id="${unique_id}" class="hotspot-widget row">
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
      </div>
    	</#list>
    </#if>
  </div>
	</#list>

  <#if Image.getData()?? && Image.getData() != "">
    <img class="hotspot-layer-background" data-fileentryid="${Image.getAttribute("fileEntryId")}" alt="${Image.getAttribute("alt")}" src="${Image.getData()}" />
  </#if>

  <div class="hotspot-footer">
    <div class="col-lg-4 col-md-3 col-sm-16">
      <div class="hotspot-footer-instructions">
        <h6>Click to toggle views</h6>
      </div>
    </div>
    <div class="col-lg-12 col-md-13 col-sm-16">
      <nav>
        <div class="hotspot-layer-item active" data-toggle="View All">
          <h4>View All</h4>
        </div>
      </nav>
    </div>
  </div>

</div>
</#if>

<script>
Liferay.on(
	'allPortletsReady',
	function() {

    // set up footer!
    $('#${unique_id}').each(function(){
      var $this = $(this);
      var $layers = $this.find('.hotspot-layer');
      if($layers.length < 2){
        $this.find('.hotspot-footer').css('display', 'none');
        return;
      }

      $('.hotspot-footer .hotspot-layer-item[data-toggle="View All"]').click(function(){
        var $this = $(this);
        $layers.each(function(i,el){
          $('.hotspot-layer-item').removeClass('active');
          $(el).removeClass('hidden');
          $this.addClass('active');
        });
      });

      $layers.each(function(i,el){
        var $el = $(el);
        console.log(i, el);
        var layer_name = $el.data('layer-name');
        var $nav_item = $('<div class="hotspot-layer-item" data-toggle="'+layer_name+'"><h4>'+layer_name+'</h4></div>');

        $nav_item.click(function(){
          var self = this;
          $('.hotspot-layer-item').removeClass('active');

          $layers.each(function(i_b,el_b){
            if(el_b == el){
              $(el_b).removeClass('hidden');
            } else {
              $(el_b).addClass('hidden');
            }
          });

          $(this).addClass('active');
        });
        $this.find('.hotspot-footer nav').append($nav_item);
      });
    });

    $('.caption-background').each(function(i,el){
      var $this = $(this);
      var $toggle = $this.parent().find('.caption-toggle');
      $this.css('width', $this.outerWidth());
      $this.css('height', $this.outerHeight());
      $this.data('full-width', $this.outerWidth());
      $this.data('full-height', $this.outerHeight());

      $this.parent().addClass('min');
      $this.css('width', $toggle.outerWidth());
      $this.css('height', $toggle.outerHeight());
      $this.data('small-width', $toggle.outerWidth());
      $this.data('small-height', $toggle.outerHeight());
    });

    $('.caption-toggle').click(function(){
      var parent = $(this).parent().toggleClass('min');

      $('.hotspot-spot').each(function(){
        var background = $(this).find('.caption-background');
        if(this == parent[0]){
          if(parent.hasClass('min')){
            background.css('width', background.data('small-width'));
            background.css('height', background.data('small-height'));
          } else {
            background.css('width', background.data('full-width'));
            background.css('height', background.data('full-height'));
          }
        } else {
          $(this).addClass('min');
          background.css('width', background.data('small-width'));
          background.css('height', background.data('small-height'));
        }
      });
    });
	}
);
</script>

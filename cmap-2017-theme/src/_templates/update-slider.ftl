<#if entries?has_content>
<section class="update-slider slider" id="${randomNamespace}">

  <header class="row">
    <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
      <div class="buttons">
        <h3>Updates</h3>
        <div class="view-all">
          <a href="/view-all">View all</a>
        </div>
      </div>
    </div>
  </header>

	<div class="slider-container">
		<#list entries as update>
			<div class="item col-xl-4 col-sm-8 col-xs-16">

				<#assign dateFormat="MMMM dd, yyyy" />

        <#if update.getPublishDate()??>
          <h4 class="item-date">${dateUtil.getDate(update.getPublishDate()?date, dateFormat, locale)}</h4>
        </#if>

        <#if update.getTitle(locale)??>
  				<#assign assetRenderer=update.getAssetRenderer()>
  				<#assign viewURL="/about/updates/-/asset_publisher/UIMfSLnFfMB6/content/" + assetRenderer.getUrlTitle()>
  		    <h3 class="item-title"><a href="${viewURL}">${update.getTitle(locale)}</a></h3>
        </#if>


				<#assign assetSummary=assetRenderer.getSummary(renderRequest, renderResponse)>
				<#assign assetSummaryLength=assetSummary?length>
				<#assign abstractLength=abstractLength?number>
		    <p class="item-description">
					<#if (assetSummaryLength> abstractLength)>
						${assetSummary?substring(0,abstractLength-3)}...
					<#else>
						${assetSummary}
					</#if>
		    </p>

		    <a class="read-more-link" href="${viewURL}"> Read more </a>
		  </div>
		</#list>
	</div>
</section>
</#if>

<script>
$(document).ready(function(){
	var $this = $('#${randomNamespace}');
	var $container = $this.find('.slider-container');
	var $spacer = $('<div class="col-xl-4"></div>');
	var $row = $('<div class="row"></div>');
	var $nav = $('<nav class="slider-nav"></nav>');

	var items = $container.find('.item');

	function addItem(dom){
		var $node = $(dom);
		if($node){
			$node.remove();
			$row.append($node);
		} else {
			$row.append($spacer.clone());
		}
	}
	for(let i=0; i<Math.ceil(items.length / 4); i++){
		// create row
		addItem(items[(i*4)]);
		addItem(items[(i*4)+1]);
		addItem(items[(i*4)+2]);
		addItem(items[(i*4)+3]);

		var $slide = $(`<div class="slider-slide"></div>`);
		var $navItem = $('<div class="nav-item"></div>');
		if(i===0){ $navItem.addClass('active'); }

		$navItem.click(function(){
			$container.css('transform', 'translateX(-'+(i*100)+'vw)');
      $nav.find('.nav-item.active').removeClass('active');
			$(this).addClass('active');
		});

		$nav.append($navItem);
		$slide.append($row);
		$container.append($slide);

		// reset
		$row = $('<div class="row"></div>');
	}
	$this.append($nav);
});

</script>

<div id="${randomNamespace}" class="actions-widget">
  <h4 class="widget-title">Actions include:</h4>
  <#if Actions.getSiblings()?has_content>
    <div class="actions-grid row">
  	<#list Actions.getSiblings() as cur_Actions>
      <div class="action col-xs-8">
        <h4> ${cur_Actions.Title.getData()} </h4>
    		<p> ${cur_Actions.Description.getData()} </p>
      </div>
  	</#list>
    </div>
  </#if>
</div>

<script>
Liferay.on(
	'allPortletsReady',
	function() {
		// function set_advertisement(){
		// 	var $this = $(this);
		// 	var height = $this.outerWidth() * 0.5;
		// 	var min_height = $this.find('.cmap-ad-content').outerHeight();
		// 	$this.css('height', height);
		// 	$this.css('min-height', min_height);
		// }

    var temp_height = 0, temp_this = null;
		function parse_actions(i){
      var $this = $(this), height = $this.innerHeight();

      if(i%2 === 0){
        temp_height = height;
        temp_this = $this;
      }
      if(i%2 === 1){
        if(height > temp_height){
          temp_this.css('min-height', height);
        } else {
          $this.css('min-height', temp_height);
        }
      }
      console.log($this, height, i, i%2);
		}
    $('#${randomNamespace} .action').each(parse_actions);
		// $(window).resize(_.throttle(handle_resize, 100));
		// handle_resize();
	}
);
</script>

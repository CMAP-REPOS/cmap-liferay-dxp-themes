${Anchor.getData()}

<#assign unique_id = randomNamespace>

<div id="${unique_id}" class="onto2050-basic-web-content">
    ${Content.getData()}
</div>

<script>
function parse_anchors(el){
  var $this = $(this);
  console.log($this, $this.attr('name'), $this.attr('id'));
  if($this.attr('name') === $this.attr('id')){
    console.log('ANCHOR TAG FOUND', $this);
  }
}
Liferay.on(
	'allPortletsReady',
	function() {
    $('#${unique_id} a').each(parse_anchors);
	}
);
</script>

<#assign shade_color = ShadeColor.getData()>
<#assign image = Image.getData()>

<div class="onto2050-cover-photo-widget">
  <#if image?? && image != "">
    <div class="cover-photo-container" style="background: url(${image}); background-position: ${HorzImgAlign.getData()} ${VertImgAlign.getData()}; background-size: cover;">
      <span class="sr-only">${Image.getAttribute("alt")}</span>
      <#if shade_color?? && shade_color != "">
        <div class="image-mask" style="background: ${shade_color};"></div>
      </#if>
    </div>
  </#if>
</div>

<script>
Liferay.on(
	'allPortletsReady',
	function() {


    var $cover_photo = $('.onto2050-cover-photo-widget');

    function compute_padding_top(){
      var content_rows = ${NumberOfRows.getData()};
      var banner_height = $('#banner').innerHeight();
      var breadcrumbs_height = $('#breadcrumbs').innerHeight();
      var foobar = banner_height + breadcrumbs_height;
      var $row = $('.cmap-onto-2050-main-content > .row');

      if($('body.signed-in').length){
        foobar += $('#ControlMenu').innerHeight();
      }
      for(var i=0; i<content_rows; i++){
        foobar += $($row[i]).innerHeight();
      }
      if((window.innerHeight - foobar) > 0){
        $($row[content_rows]).css('padding-top', window.innerHeight - foobar);
      }
    }
    if($cover_photo.length > 1){
      alert('There should only be one cover photo per page.');
    } else {
      $('body').addClass('has-cover-photo');

      var $photo = $cover_photo.find('.cover-photo-container');
      $photo.remove();
      $('#wrapper').before($photo);

      compute_padding_top();
      $(window).resize(_.throttle(compute_padding_top, 100));
    }
	}
);
</script>

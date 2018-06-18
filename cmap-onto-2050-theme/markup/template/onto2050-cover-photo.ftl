<div class="onto2050-cover-photo-widget">
  <#if Image.getData()?? && Image.getData() != "">
    <div class="cover-photo-container" style="background: url(${Image.getData()}); background-position: ${HorzImgAlign.getData()} ${VertImgAlign.getData()}; background-size: cover;">
      <span class="sr-only">${Image.getAttribute("alt")}</span>
    </div>
  </#if>
</div>

<script>
Liferay.on(
	'allPortletsReady',
	function() {
    var $cover_photo = $('.onto2050-cover-photo-widget');
    if($cover_photo.length > 1){
      alert('There should only be one cover photo per page.');
    } else {
      $('body').addClass('has-cover-photo');
      var $photo = $cover_photo.find('.cover-photo-container');
      $photo.remove();
      $('#wrapper').before($photo);
    }
	}
);
</script>

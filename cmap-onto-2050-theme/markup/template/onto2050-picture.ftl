<#assign unique_namespace = randomNamespace>

<#if CaptionPosition.getData() == 'top-right' || CaptionPosition.getData() == 'top-left'>
  <#assign top_bottom = 'top'>
<#else>
  <#assign top_bottom = 'bottom'>
</#if>

<div id="${unique_namespace}" class="picture-figure">

  <div class="picture-container">
    <#if Asset.getData() != ''>
      <img class="picture-img" src="${Asset.getData()}" alt="${Asset.getAttribute("alt")}" />
    </#if>

    <#if CaptionText.getData() != ''>
      <div class="caption-row ${top_bottom}">
        <#if CaptionPosition.getData() == "bottom-right" || CaptionPosition.getData() == "top-right">
          <div class="col-md-8 col-md-offset-8">
            <div class="picture-caption right">
              ${CaptionText.getData()}
            </div>
          </div>
        <#else>
          <div class="col-md-8">
            <div class="picture-caption left">
              ${CaptionText.getData()}
            </div>
          </div>
        </#if>
        ${CaptionPosition.getData()}
      </div>
    </#if>
  </div>

  <#if Footnote.getData() != ''>
    <div class="picture-footnote-container">
      <div class="picture-footnote">
        <div class="whitney-small bold">${Footnote.getData()}</div>
      </div>
    </div>
  </#if>
</div>

<script>
function generateFullWidth(){
  var root = $('#${unique_namespace}');
  var footnote = root.find('.picture-footnote').remove();
  footnote.prepend('<div class="icon"><img src="'+Liferay.ThemeDisplay.getPathThemeImages()+'/icons/ic_pin.svg" alt="Icon which represents location"/></div>');

  root.find('.picture-footnote-container').append('<div class="col-md-4"></div>');
  root.find('.picture-footnote-container').append('<div class="col-md-8"></div>');
  root.find('.picture-footnote-container').append('<div class="col-md-4"></div>');

  root.find('.picture-footnote-container .col-md-8').append(footnote);

  root.find('.caption-row .col-md-8').removeClass('col-md-8').addClass('col-md-5');
  root.find('.caption-row .col-md-offset-8').removeClass('col-md-offset-8').addClass('col-md-offset-11');

  root.addClass('row');
  // root.wrapInner('<div class="row"></div>');
}
function checkForFullWidth(){
  if($('#${unique_namespace}').parents('.col-md-16').length){
    generateFullWidth();
  }
}
Liferay.on(
	'allPortletsReady',
	function() {
    checkForFullWidth();
	}
);
</script>

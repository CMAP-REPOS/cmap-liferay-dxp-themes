<#--<#include "${templatesPath}/875701">-->
<#include "${templatesPath}/848954">

<#assign caption_text = validate_field(CaptionText.getData())>
<#assign footnote = validate_field(Footnote.getData())>
<#assign picture_asset = validate_field(Asset.getData())>
<#assign caption_position = validate_field(CaptionPosition.getData())>
<#assign unique_namespace = randomNamespace>

<div id="${unique_namespace}" class="picture-figure">


  <#if picture_asset != ''>
    <div class="picture-img" style="background-image: url('${picture_asset}')">
      <div class="sr-only">${Asset.getAttribute("alt")}</div>
      <#if caption_text != ''>

        <#if caption_position == 'top-right' || caption_position == 'top-right'>
          <#assign top_bottom = 'top'>
        <#else>
          <#assign top_bottom = 'bottom'>
        </#if>

        <div class="caption-row ${top_bottom}">
          <#if caption_position == "bottom-right" || caption_position == "top-right">
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
        </div>
      </#if>
    </div>
  </#if>

  <#if footnote != ''>
    <div class="picture-footnote-container">
      <div class="picture-footnote">
        <small>${footnote}</small>
      </div>
    </div>
  </#if>
</div>

<script>
function generateFullWidth(){
  var root = $('#${unique_namespace}');
  var footnote = root.find('.picture-footnote').remove();
  footnote.prepend('<div class="icon"><img src="'+Liferay.ThemeDisplay.getPathThemeImages()+'/icons/ic_pin.svg" /></div>');

  root.find('.picture-footnote-container').append('<div class="col-md-4"></div>');
  root.find('.picture-footnote-container').append('<div class="col-md-8"></div>');
  root.find('.picture-footnote-container').append('<div class="col-md-4"></div>');

  root.find('.picture-footnote-container .col-md-8').append(footnote);

  root.find('.caption-row .col-md-8').removeClass('col-md-8').addClass('col-md-5');
  root.find('.caption-row .col-md-offset-8').removeClass('col-md-offset-8').addClass('col-md-offset-11');

  root.wrapInner('<div class="row"></div>');
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

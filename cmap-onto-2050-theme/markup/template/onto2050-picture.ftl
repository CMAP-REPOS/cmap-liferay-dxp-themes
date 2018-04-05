<div class="picture-figure">
<#if getterUtil.getBoolean(IsFullWidth.getData())>
  <div class="row">
</#if>

  <#if Asset.getData()?? && Asset.getData() != "">
    <div class="picture-img" style="background-image: url('${Asset.getData()}')">
      <div class="sr-only">${Asset.getAttribute("alt")}</div>

      <#if CaptionText?? && CaptionText.getData()?? && CaptionText.getData() != "">

      <#if CaptionPosition.getData()[0] == 'top-right' || CaptionPosition.getData()[0] == 'top-right'>
        <#assign top_bottom = 'top'>
      <#else>
        <#assign top_bottom = 'bottom'>
      </#if>

      <div class="caption-row ${top_bottom}">
        <#if CaptionPosition.getData() == "bottom-right" || CaptionPosition.getData() == "top-right">
          <div class="col-md-5 col-md-offset-11">
            <div class="picture-caption right">
              ${CaptionText.getData()}
            </div>
          </div>
        <#else>
          <div class="col-md-5">
            <div class="picture-caption left">
              ${CaptionPosition.getData()}
              ${CaptionText.getData()}
            </div>
          </div>
        </#if>
      </div>
      </#if>
    </div>
  </#if>

  <#if getterUtil.getBoolean(IsFullWidth.getData())>
    <div class="col-md-4"></div>
    <div class="col-md-8">
      <div class="picture-footnote">
        <div class="icon">
          <img src="${themeDisplay.getPathThemeImages()}/icons/ic_pin.svg" />
        </div>
        <small>${Footnote.getData()}</small>
      </div>
    </div>
    <div class="col-md-4"></div>
  <#else>
    <div class="picture-footnote">
      ${Footnote.getData()}
    </div>
  </#if>

<#if getterUtil.getBoolean(IsFullWidth.getData())>
  </div>
</#if>
</div>

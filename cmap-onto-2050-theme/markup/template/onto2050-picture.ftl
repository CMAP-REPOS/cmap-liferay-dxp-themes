<#if CaptionText?? && CaptionText.getData()?? && CaptionText.getData() != "">
  <#assign caption_text = CaptionText.getData()>
<#else>
  <#assign caption_text = ''>
</#if>

<#if Footnote?? && Footnote.getData()?? && Footnote.getData() != "">
  <#assign footnote = Footnote.getData()>
<#else>
  <#assign footnote = ''>
</#if>

<#if getterUtil.getBoolean(IsFullWidth.getData())>
  <#assign full_width = true>
<#else>
  <#assign full_width = false>
</#if>

<#if Asset.getData()?? && Asset.getData() != "">
  <#assign picture_asset = Asset.getData()>
<#else>
  <#assign picture_asset = ''>
</#if>

<#if CaptionPosition.getData()?? && CaptionPosition.getData() != "">
  <#assign caption_position = CaptionPosition.getData()>
<#else>
  <#assign caption_position = ''>
</#if>

<div class="picture-figure">
  <#if full_width>
    <div class="row">
  </#if>

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
            <#if full_width>
            <div class="col-md-5 col-md-offset-11">
            <#else>
            <div class="col-md-8 col-md-offset-8">
            </#if>
              <div class="picture-caption right">
                ${CaptionText.getData()}
              </div>
            </div>
          <#else>
            <#if full_width>
            <div class="col-md-5">
            <#else>
            <div class="col-md-8">
            </#if>
              <div class="picture-caption left">
                ${CaptionText.getData()}
              </div>
            </div>
          </#if>
        </div>
      </#if>
    </div>
  </#if>

  <#if full_width>
    <div class="col-md-4"></div>
    <div class="col-md-8">
      <#if footnote != ''>
        <div class="picture-footnote">
          <div class="icon">
            <img src="${themeDisplay.getPathThemeImages()}/icons/ic_pin.svg" />
          </div>
          <small>${footnote}</small>
        </div>
      </#if>
    </div>
    <div class="col-md-4"></div>
  <#else>
    <#if footnote != ''>
      <div class="picture-footnote">
        ${footnote}
      </div>
    </#if>
  </#if>

  <#if getterUtil.getBoolean(IsFullWidth.getData())>
    </div>
  </#if>
</div>

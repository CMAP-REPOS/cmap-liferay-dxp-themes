<#if Anchor.getData()?? && Anchor.getData() != ''>
  <#assign anchor = Anchor.getData()>
<#else>
  <#assign anchor = ''>
</#if>
<#if Subtitle.getData()?? && Subtitle.getData() != ''>
  <#assign subtitle = Subtitle.getData()>
<#else>
  <#assign subtitle = ''>
</#if>
<#if Title.getData()?? && Title.getData() != ''>
  <#assign title = Title.getData()>
<#else>
  <#assign title = ''>
</#if>

<div class="section-headline<#if anchor != ''> anchor-point" id="${anchor}"<#else>"</#if>>
  <header>
    <#if anchor != ''>
      <img src="${themeDisplay.getPathThemeImages()}/icons/ic_clipboard.svg" />
    </#if>
    <#if subtitle != ''>
      <h4 class="section-subtitle">${subtitle}</h4>
    </#if>
  </header>
  <#if title != ''>
    <h2 class="section-title">${title}</h2>
  </#if>
</div>

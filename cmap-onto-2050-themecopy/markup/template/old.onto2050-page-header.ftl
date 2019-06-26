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

<#if Description.getData()?? && Description.getData() != ''>
  <#assign description = Description.getData()>
<#else>
  <#assign description = ''>
</#if>

<div id="page-header">
  <#if subtitle != '' && title != ''>
    <div class="duel-headlines">
  </#if>
    <#if subtitle != ''>
      <h2 class="page-subtitle">${subtitle}</h2>
    </#if>
    <#if title != ''>
      <h1 class="page-title">${title}</h1>
    </#if>
  <#if subtitle != '' && title != ''>
    </div>
  </#if>
  <#if description != ''>
    <h3 class="page-description">${description}</h3>
  </#if>
</div>

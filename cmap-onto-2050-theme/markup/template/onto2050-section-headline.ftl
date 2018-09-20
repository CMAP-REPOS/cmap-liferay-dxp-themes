<#include "${templatesPath}/848955">
<#assign anchor = validate_field(Anchor.getData())>
<#assign subtitle = validate_field(Subtitle.getData())>
<#assign title = validate_field(Title.getData())>

<div ${anchor_signature('section-headline', anchor)}>
  <header>
    <@render_anchor name=anchor/>
    <#if subtitle != ''>
      <h4 class="section-subtitle">${subtitle}</h4>
    </#if>
  </header>
  <#if title != ''>
    <h2 class="section-title">${title}</h2>
  </#if>
</div>

<#if Anchor.getData()?? && Anchor.getData() != ''>
  <#assign anchor = Anchor.getData()>
<#else>
  <#assign anchor = ''>
</#if>

<div class="topic-goal<#if anchor != ''> anchor-point" id="${anchor}"<#else>"</#if>>
  <header>
    <#if anchor != ''>
      <img src="${themeDisplay.getPathThemeImages()}/icons/ic_clipboard.svg" />
    </#if>

    <h4>Goal ${GoalNumber.getData()}</h4>
  </header>
  <h2>${Title.getData()}</h2>
  <p>${Content.getData()}</p>
</div>

<#assign profilepicture>
  <#if Background.getData()?? && Background.getData() != "">
    background-image: url('${Background.getData()}');
  <#else>
    background: transparent;
  </#if>
</#assign>

<section class="profile-header row" style="${profilepicture}">
  <div class="profile-text col-sm-6 col-sm-offset-8">
    <h2>${Quote.getData()}</h2>
    <span class="profile-name">${Name.getData()}</span>
    <#if Title.getSiblings()?has_content>
    	<#list Title.getSiblings() as cur_Title>
        <span class="profile-title">${cur_Title.getData()}</span>
    	</#list>
    </#if>
  </div>
  <#if Background.getData()?? && Background.getData() != "">
    <span class="sr-only">${Background.getAttribute("alt")}</span>
  </#if>
</section>

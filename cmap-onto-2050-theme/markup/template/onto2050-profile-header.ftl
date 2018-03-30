<#assign profilepicture>
  <#if Background.getData()?? && Background.getData() != "">
    background-image: url('${Background.getData()}');
  <#else>
    background: transparent;
  </#if>
</#assign>

<section class="profile-header row" style="${profilepicture}">
  <#if MobileImage?? && MobileImage.getData()?? && MobileImage.getData() != "">
  	<img class="mobile-image" data-fileentryid="${MobileImage.getAttribute("fileEntryId")}" alt="${MobileImage.getAttribute("alt")}" src="${MobileImage.getData()}" />
  </#if>
  <#if Background.getData()?? && Background.getData() != "">
    <span class="sr-only">${Background.getAttribute("alt")}</span>
  </#if>
  <div class="profile-text col-md-7 col-md-offset-8 col-sm-16">
    <h2>${Quote.getData()}</h2>
    <span class="profile-name">${Name.getData()}</span>
    <#if Title.getSiblings()?has_content>
    	<#list Title.getSiblings() as cur_Title>
        <span class="profile-title">${cur_Title.getData()}</span>
    	</#list>
    </#if>
  </div>
</section>

<section class="profile-header row">

  <#if MobileImage.getData() != "">
  	<img class="mobile-image" data-fileentryid="${MobileImage.getAttribute("fileEntryId")}" alt="${MobileImage.getAttribute("alt")}" src="${MobileImage.getData()}" />
  </#if>

  <#if Background.getData() != "">
  	<img class="background-image" data-fileentryid="${Background.getAttribute("fileEntryId")}" alt="${Background.getAttribute("alt")}" src="${Background.getData()}" />
  </#if>

  <div class="profile-text col-md-7 col-md-offset-8 col-sm-16">
    <blockquote><p>${Quote.getData()}</p></blockquote>
    <span class="profile-name">${Name.getData()}</span>
    <#if Title.getSiblings()?has_content>
    	<#list Title.getSiblings() as cur_Title>
        <span class="profile-title">${cur_Title.getData()}</span>
    	</#list>
    </#if>
  </div>
</section>

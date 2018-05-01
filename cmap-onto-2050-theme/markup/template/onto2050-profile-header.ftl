<#include "${templatesPath}/848955">

<#assign mobile_image = validate_field(MobileImage.getData())>
<#assign background = validate_field(Background.getData())>
<#assign quote = validate_field(Quote.getData())>

<#assign profilepicture>
  <#if background != "">
    background-image: url('${background}');
  <#else>
    background: transparent;
  </#if>
</#assign>

<section class="profile-header row" style="${profilepicture}">
  <#if mobile_image != "">
  	<img class="mobile-image" data-fileentryid="${MobileImage.getAttribute("fileEntryId")}" alt="${MobileImage.getAttribute("alt")}" src="${mobile_image}" />
  </#if>

  <#if background != "">
    <span class="sr-only">${Background.getAttribute("alt")}</span>
  </#if>

  <div class="profile-text col-md-7 col-md-offset-8 col-sm-16">
    <h2>${quote}</h2>
    <span class="profile-name">${Name.getData()}</span>
    <#if Title.getSiblings()?has_content>
    	<#list Title.getSiblings() as cur_Title>
        <span class="profile-title">${cur_Title.getData()}</span>
    	</#list>
    </#if>
  </div>
</section>

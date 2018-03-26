<section class="profile-footer row">
<#if Image.getSiblings()?has_content>
	<#list Image.getSiblings() as cur_Image>
		<#if cur_Image.getData()?? && cur_Image.getData() != "">
      <div class="profile-footer-item">
  			<img data-fileentryid="${cur_Image.getAttribute("fileEntryId")}" alt="${cur_Image.getAttribute("alt")}" src="${cur_Image.getData()}" />
      </div>
		</#if>
	</#list>
</#if>
</section>

<div class="onto2050-slider">
  <#if Images.getSiblings()?has_content>
  	<#list Images.getSiblings() as cur_Images>
  		<#if cur_Images.getData()?? && cur_Images.getData() != "">
  			<img data-fileentryid="${cur_Images.getAttribute("fileEntryId")}" alt="${cur_Images.getAttribute("alt")}" src="${cur_Images.getData()}" />
  		</#if>
  	</#list>
  </#if>
</div>

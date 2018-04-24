${Title.getData()}

${Description.getData()}

<#if KeyItem.getSiblings()?has_content>
	<#list KeyItem.getSiblings() as cur_KeyItem>
		<#if getterUtil.getBoolean(cur_KeyItem.getData())>

		</#if>
	</#list>
</#if>

${KeyItem.KeyItemName.getData()}

<#if KeyItem.KeyItemImage.getData()?? && KeyItem.KeyItemImage.getData() != "">
	<img data-fileentryid="${KeyItem.KeyItemImage.getAttribute("fileEntryId")}" alt="${KeyItem.KeyItemImage.getAttribute("alt")}" src="${KeyItem.KeyItemImage.getData()}" />
</#if>

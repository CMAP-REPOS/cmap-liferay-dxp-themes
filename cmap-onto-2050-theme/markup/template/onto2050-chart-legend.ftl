
<#include "${templatesPath}/848954">

<#assign title = validate_field(Title.getData())>
<#assign description = validate_field(Description.getData())>

	${title}
	${description}

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

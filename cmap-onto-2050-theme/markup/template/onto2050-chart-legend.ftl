${Title.getData()}

<#if Description.getData()?has_content && Description.getData() != "">
<p><strong>Chart</strong></p>
${Description.getData()}
</#if>

<p><strong>Key</strong></p>
<#if KeyItem.getSiblings()?has_content>
    <ul class="list-unstyled">
	<#list KeyItem.getSiblings() as cur_KeyItem>
		<#if getterUtil.getBoolean(cur_KeyItem.getData())>
        <li>
		    <#if KeyItem.KeyItemImage.getData()?? && KeyItem.KeyItemImage.getData() != "">
            <img data-fileentryid="${KeyItem.KeyItemImage.getAttribute("fileEntryId")}" alt="${KeyItem.KeyItemImage.getAttribute("alt")}" src="${KeyItem.KeyItemImage.getData()}" />
            </#if>
        ${KeyItem.KeyItemName.getData()}
        </li>
		</#if>
	</#list>
	</ul>
</#if>

<#if  Source.getData()?has_content && Source.getData() != "">
<p><strong>Source</strong></p>
${Source.getData()}
</#if>
<#-- Freemarker can report false positives for list content, so create a custom key array -->
<#assign keyArray = []>

<#list KeyItem.getSiblings() as cur_KeyItem>
    <#assign keyName = "">
    <#assign keyImageUrl = "">
    <#assign keyImageAlt = "">

    <#if cur_KeyItem.KeyItemName.getData() ?? && cur_KeyItem.KeyItemName.getData() != "">
        <#assign keyName = cur_KeyItem.KeyItemName.getData()>
    </#if>

    <#if cur_KeyItem.KeyItemImage.getData() ?? && cur_KeyItem.KeyItemImage.getData() != "">
        <#assign keyImageUrl = cur_KeyItem.KeyItemImage.getData()>
    </#if>

    <#if cur_KeyItem.KeyItemImage.getAttribute("alt") ?? && cur_KeyItem.KeyItemImage.getAttribute("alt") != "">
        <#assign keyImageAlt = cur_KeyItem.KeyItemImage.getAttribute("alt")>
    </#if>

    <#if keyName != "">
    <#assign keyArray = keyArray + [{
        "keyName": keyName,
        "keyImageUrl": keyImageUrl,
        "keyImageAlt": keyImageAlt
    }]>
    </#if>
</#list>

${Title.getData()}

<#if Description.getData()?has_content && Description.getData() != "">
<p><strong>Chart</strong></p>
${Description.getData()}
</#if>

<#if keyArray?size != 0>
<p><strong>Key</strong></p>
<ul class="list-unstyled">
    <#list keyArray as key>
    <li>
        <img alt="${key.keyImageAlt}" src="${key.keyImageUrl}" />
        ${key.keyName}
    </li>
    </#list>
</ul>
</#if>

<#if Source.getData()?has_content && Source.getData() != "">
<p><strong>Source</strong></p>
${Source.getData()}
</#if>
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

<div class="chart-legend-2050">
    <#--
    <div class="chart-legend-2050-title">
    ${Title.getData()}
    </div>
    -->
<#if Description.getData()?has_content && Description.getData() != "">
    <div class="chart-legend-2050-description">
    <p><strong>Chart</strong></p>
    ${Description.getData()}
    </div>
</#if>
    
<#if keyArray?size != 0>
    <div class="chart-legend-2050-key">
    <p><strong>Key</strong></p>
    <ul class="list-unstyled chart-legend-2050-key-list">
        <#list keyArray as key>
        <li>
            <img alt="${key.keyImageAlt}" src="${key.keyImageUrl}" />
            ${key.keyName}
        </li>
        </#list>
    </ul>
    </div>
</#if>

<#if Source.getData()?has_content && Source.getData() != "">
    <div class="chart-legend-2050-source">
    <p><strong>Source</strong></p>
    ${Source.getData()}
    </div>
</#if>
</div>
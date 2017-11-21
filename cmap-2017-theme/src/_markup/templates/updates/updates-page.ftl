<#setting time_zone = timeZone.ID>
<#setting locale = locale.toString()>
<#setting datetime_format = "MMMM dd, yyyy">

<#if entries?has_content>
<div class="updates-container row">
    <div class="col-xl-10 col-xl-push-3">
    	<#list entries as entry>

        <#assign assetRenderer = entry.getAssetRenderer() />
        <#assign entryTitle = htmlUtil.escape(entry.getTitle(locale)) />
        <#assign assetSummary = assetRenderer.getSummary(renderRequest, renderResponse) />
        <#assign summary = htmlUtil.extractText(assetSummary) />
        <#assign assetDate = entry.modifiedDate?datetime />
        <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry, true) />
        <article>
            <hr class="update-divider">
            <header>
                <time class="update-date">${assetDate}</time>
                <#if entry.getCategories()?has_content>
                <ul class="update-categories">
                <#list entry.getCategories() as category>
                    <#assign categoryId = category.getCategoryId()?string /> 
                    <li><a href="/updates/all/-/categories/${categoryId}">${category.getName()}</a></li>
                </#list>
                </ul>
                </#if>
            </header>
            <div class="update-preview">
                <h2 class="update-title"><a href="${viewURL}">${entryTitle}</a></h2>
                <p class="update-summary">
                    <#assign summaryLength = summary?length />
                    <#assign abstractLength = abstractLength?number />
                    <#if (summaryLength > abstractLength)>
                        ${assetSummary?substring(0,abstractLength-3)}...
                    <#else>
                        ${assetSummary}
                    </#if>
                </p>
                <a class="update-read-more underline-link" href="${viewURL}">Read More</a>
            </div>
        </article>
    	</#list>
    </div>
</div>
</#if>


<#-- Old Code -->
<#-- <#assign categoryURL = renderResponse.createRenderURL() /> -->
<#-- <pre>category: ${category}</pre> -->
<#-- <pre>category.getVocabularyId(): ${category.getVocabularyId()}</pre> -->
<#-- <pre>categoryURL: ${categoryURL}</pre> -->
<#-- <pre>categoryName: ${categoryName}</pre> -->
<#-- <pre>categoryId: ${categoryId}</pre> -->
<#-- ${categoryURL.setParameter("resetCur", "true")} -->
<#-- ${categoryURL.setParameter("categoryId", categoryId)} -->
<#-- <#if category.getVocabularyId() == 424402></#if> -->
<#-- <div class="asset-publish-date"></div> -->
<#-- <span class="taglib-asset-categories-summary"></span> -->


<!-- View URLS -->
<!-- ORIGINAL: https://www.cmap.illinois.gov/about/updates/-/asset_publisher/UIMfSLnFfMB6/content/cmap-weekly-update-11-17-17 -->
<!-- TEST: http://localhost:8080/about/updates/policy/-/asset_publisher/U9jFxa68cnNA/content/TransitAvailability_2017_CMAP_WebMerc_Dissolved.geojson -->
<!-- NEW: http://localhost:8080/web/guest/about/updates/-/asset_publisher/86b7OattYVA4/document/id/752638?_com_liferay_asset_publisher_web_portlet_AssetPublisherPortlet_INSTANCE_86b7OattYVA4_redirect=http%3A%2F%2Flocalhost%3A8080%2Fweb%2Fguest%2Fabout%2Fupdates%3Fp_p_id%3Dcom_liferay_asset_publisher_web_portlet_AssetPublisherPortlet_INSTANCE_86b7OattYVA4%26p_p_lifecycle%3D0%26p_p_state%3Dnormal%26p_p_mode%3Dview%26_com_liferay_asset_publisher_web_portlet_AssetPublisherPortlet_INSTANCE_86b7OattYVA4_cur%3D0%26p_r_p_resetCur%3Dfalse%26_com_liferay_asset_publisher_web_portlet_AssetPublisherPortlet_INSTANCE_86b7OattYVA4_assetEntryId%3D752638 -->



<#-- Java Docs -->

<#-- Interface -->
<#--  https://docs.liferay.com/portal/7.0/javadocs/portal-kernel/com/liferay/asset/kernel/model/AssetRenderer.html -->

<#-- Class -->
<#-- https://docs.liferay.com/portal/7.0/javadocs/portal-impl/com/liferay/portlet/asset/model/impl/AssetEntryModelImpl.html -->
<#-- https://docs.liferay.com/portal/7.0/javadocs/portal-impl/com/liferay/portlet/asset/model/impl/AssetEntryImpl.html -->
<#-- https://docs.liferay.com/ce/apps/collaboration/latest/javadocs/com/liferay/document/library/web/asset/DLFileEntryAssetRenderer.html -->
<#-- https://docs.liferay.com/portal/7.0/javadocs/portal-kernel/com/liferay/portal/kernel/util/HtmlUtil.html -->

<#-- Tutorials -->
<#-- http://proliferay.com/important-code-snippets-for-liferay-asset-publisher-adt/ -->
<#-- https://web.liferay.com/web/eduardo.garcia/blog/-/blogs/divide-and-conquer-rendering-structured-web-content-with-the-asset-publisher -->
<!-- https://dev.liferay.com/es/develop/tutorials/-/knowledge_base/7-0/rendering-an-asset -->
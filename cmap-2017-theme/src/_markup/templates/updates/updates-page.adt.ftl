<#setting time_zone = timeZone.ID>
<#setting locale = locale.toString()>
<#setting datetime_format = "MMMM dd, yyyy">

<#if entries?has_content>
<div class="updates-container">
	<#list entries as entry>

    <#assign assetRenderer = entry.getAssetRenderer() />
    <#assign entryTitle = htmlUtil.escape(entry.getTitle(locale)) />
    <#assign assetSummary = assetRenderer.getSummary(renderRequest, renderResponse) />
    <#assign summary = htmlUtil.extractText(assetSummary) />
    <#assign assetDate = entry.publishDate?datetime />
    <#assign viewURL = "/updates/all/-/asset_publisher/UIMfSLnFfMB6/content/" + assetRenderer.getUrlTitle()>
    <article>
        <hr class="update-divider" />
        <header>
            <time class="update-date">${assetDate}</time>
        </header>
        <div class="update-preview">
            <h2 class="update-title"><@getEditIcon /> <a href="${viewURL}">${entryTitle}</a></h2>
            <p class="update-summary">
                <!-- -->
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

    <hr class="update-divider" />
    <div class="pagnation-container">
        <div class="left">
            <label>Page</label>
            <div class="pagnation-numbers"></div>
        </div>
        <div class="right">
        </div>
    </div>
</div>
</#if>

<#macro getEditIcon>
	<#if assetRenderer.hasEditPermission(themeDisplay.getPermissionChecker())>
		<#assign redirectURL = renderResponse.createRenderURL() />

		${redirectURL.setParameter("mvcPath", "/add_asset_redirect.jsp")}
		${redirectURL.setWindowState("pop_up")}

		<#assign editPortletURL = assetRenderer.getURLEdit(renderRequest, renderResponse, windowStateFactory.getWindowState("pop_up"), redirectURL)!"" />

		<#if validator.isNotNull(editPortletURL)>
			<#assign title = languageUtil.format(locale, "edit-x", entryTitle, false) />

			<@liferay_ui["icon"]
				cssClass="icon-monospaced visible-interaction"
				icon="pencil"
				markupView="lexicon"
				message=title
				url="javascript:Liferay.Util.openWindow({id:'" + renderResponse.getNamespace() + "editAsset', title: '" + title + "', uri:'" + htmlUtil.escapeURL(editPortletURL.toString()) + "'});"
			/>
		</#if>
	</#if>
</#macro>

<script>
Liferay.on('allPortletsReady', function() {
    console.log('updates-page');
    var currentPage = $('.lfr-icon-menu-text').text().replace(/Page (\d+) of \d*/, '$1');
    var $container = $('.pagnation-container .pagnation-numbers');

    // iterates through each page in the dropdown menu
    $('.dropdown-menu.lfr-menu-list li a').each(function(index,element){
        var href = $(element).attr('href');
        var real_index = index + 1;
        var item_class = real_index === parseInt(currentPage) ? 'active' : '';

        var $item = $('<a href="'+href+'" class="pagnation-number '+item_class+'"><span>'+real_index+'</span></a>');
        $container.append($item);
    });

    // adds the next and previous page buttons
    var $button_container = $('.pagnation-container .right');
    $('.lfr-pagination-buttons.pager li').each(function(index, element){
        var $button = $(this).find('a');
        $button.addClass('pagnation-single');
        console.log($button);
        if($(this).hasClass('disabled')){
            $button.addClass('disabled');
        }
        if(index === 1){$button_container.append($button); }
        if(index === 2){$button_container.append($button); }
    });

    $('.taglib-page-iterator').remove();
});

</script>


<#-- Categories! -->
<#-- <#if entry.getCategories()?has_content>
<ul class="update-categories">
<#list entry.getCategories() as category>
    <#assign categoryId = category.getCategoryId()?string /> 
    <li><a href="/updates/all/-/categories/${categoryId}">${category.getName()}</a></li>
</#list>
</ul>
</#if> -->


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
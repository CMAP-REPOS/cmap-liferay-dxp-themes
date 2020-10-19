<#assign viewURL = "/about/updates/weekly/-/asset_publisher/U9jFxa68cnNA/content/" + assetRenderer.getUrlTitle()>

<#if entries?has_content>
	<#list entries as curEntry>
	    <div class="asset-abstract">
	    <#assign dateFormat = "MMMM dd, yyyy" />
        <#assign assetRenderer = curEntry.getAssetRenderer() >
	    <#assign entryTitle = htmlUtil.escape(assetRenderer.getTitle(locale)) >
        <#assign assetSummary = assetRenderer.getSummary(renderRequest, renderResponse)>
        <#assign assetSummaryLength = assetSummary?length>
        <#assign abstractLength = abstractLength?number>
        <#assign categories = curEntry.getCategories() />
            <div class="asset-publish-date">${dateUtil.getDate(curEntry.getPublishDate(), dateFormat, locale)}
            <#if categories?has_content>
                <span class="taglib-asset-categories-summary">
                <#list categories as category>
                <#if category.getVocabularyId() == 424402>
                    <#assign categoryURL = renderResponse.createRenderURL() />
                    <#assign categoryName = category.getName() />
                    <#assign categoryId = category.getCategoryId()?string />
                    ${categoryURL.setParameter("resetCur", "true")}
                    ${categoryURL.setParameter("categoryId", categoryId)}
                    <a  class="asset-category" href="${categoryURL}">${category.getName()}</a>
                </#if>
                </#list>
                </span>
            </#if>
            </div>
		    <h3 class="asset-title"><a href="${viewURL}">${curEntry.getTitle(locale)}</a></h3>
	        <div class="asset-content">
	            <div class="asset-summary">
                <#if (assetSummaryLength > abstractLength)>
    				${assetSummary?substring(0,abstractLength-3)}...
                <#else>
    				${assetSummary}
                </#if>
				    <a href="${viewURL}"><@liferay.language key="read-more" /><span class="hide-accessible"><@liferay.language key="about" /> ${entryTitle}</span></a>
	            </div>
		    </div>
	    </div>
	</#list>
</#if>
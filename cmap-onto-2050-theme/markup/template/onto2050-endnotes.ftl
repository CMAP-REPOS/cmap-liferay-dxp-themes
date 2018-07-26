<#if PageTitle.getSiblings()?has_content>
	<#list PageTitle.getSiblings() as cur_PageTitle>

<a id="${cur_PageTitle.PageLink.getFriendlyUrl()?lower_case?remove_beginning('/web/guest')?remove_beginning('/')}"></a>
<div class="whitney-huge">
    ${cur_PageTitle.getData()}
</div>

${cur_PageTitle.Notes.getData()}

	</#list>
</#if>
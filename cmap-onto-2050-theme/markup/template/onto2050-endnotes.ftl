<#if PageTitle.getSiblings()?has_content>
	<#list PageTitle.getSiblings() as cur_PageTitle>

<a id="${cur_PageTitle.PageLink.getFriendlyUrl()?lower_case?remove_beginning('/web/guest')?remove_beginning('/')}"></a>
<h2>
    ${cur_PageTitle.getData()}
</h2>

${cur_PageTitle.Notes.getData()}

	</#list>
</#if>
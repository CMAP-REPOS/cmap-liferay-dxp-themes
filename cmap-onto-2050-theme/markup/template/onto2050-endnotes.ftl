<style>

body.default-theme .endnotes-introduction {
	color: #000;
	font-family: "Prensa LF", Georgia, "Times New Roman", Times, serif ;
}

body.default-theme .endnotes-group-recommendation {
    background-color: #89a0b1;
    color: #fff !important;;
    padding: 10px 20px;
    margin-left: -13px;
    margin-right: -13px;
    font-size: 15px;
}

body.default-theme .endnotes-group-content ol li {
    border-top: 1px solid rgba(71, 92, 102, 0.25);  
    color: #000;
}
			
body.default-theme .endnotes-group-content ol li:first-of-type {
    border-top: none;  
}

</style>

<div class="endnotes-container">
    <div class="endnotes-introduction">
    ${Introduction.getData()}
    </div>
    <#if PageTitle.getSiblings()?has_content>
    	<div class="endnote-group">
    	<#list PageTitle.getSiblings() as cur_PageTitle>
    	    <#assign anchor = cur_PageTitle.PageLink.getFriendlyUrl()?lower_case?remove_beginning('/web/guest')?remove_beginning('/')>
        	<h2 class="section-sub-headline bold alt-color">
        	    <a id="${anchor}" name="${anchor}" href="#${anchor}" class="page-anchor" tabindex="0">
        	    <button class="page-anchor-button" tabindex="0"><span class="sr-only">${cur_PageTitle.getData()}</span> <img class="page-anchor-icon" src="/o/cmap-onto-2050-theme/images/icons/ic_clipboard.svg" alt=""></button> ${cur_PageTitle.getData()}</a>
    		</h2>
    		<#if cur_PageTitle.Recommendation.getData()?has_content>
    		<h3 class="endnotes-group-recommendation">${cur_PageTitle.Recommendation.getData()}</h3>
    		</#if>
            <div class="endnotes-group-content">
            ${cur_PageTitle.Notes.getData()}
            </div>
    	</#list>
        </div>
    </#if>
</div>
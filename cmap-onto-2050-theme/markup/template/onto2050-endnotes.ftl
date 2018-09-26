<style>

body.default-theme .endnotes-container .endnotes-introduction {
	color: #000;
	font-family: "Prensa LF", Georgia, "Times New Roman", Times, serif ;
}

body.default-theme .endnotes-container .endnotes-group-recommendation {
    background-color: #89a0b1;
    color: #fff !important;;
    padding: 10px 20px;
    margin-left: -13px;
    margin-right: -13px;
    font-size: 15px;
}

body.default-theme .endnotes-container ol li {
    border-top: 1px solid rgba(71, 92, 102, 0.25);  
    color: #000;
}
			
body.default-theme .endnotes-container ol li:first-of-type {
    border-top: none;  
}

</style>

<div class="endnotes-container">
    <div class="endnotes-introduction">
    ${Introduction.getData()}
    </div>
    <h2 class="section-sub-headline bold alt-color">
        <#assign jump = SectionTitle.getData()?lower_case?replace("[^a-zA-Z0-9]", "",'r')>
        <a id="${jump}" name="${jump}" href="#${jump}" class="page-anchor section-jump" tabindex="0">
        <button class="page-anchor-button" tabindex="0"><span class="sr-only">${SectionTitle.getData()}</span> <img class="page-anchor-icon" src="/o/cmap-onto-2050-theme/images/icons/ic_clipboard.svg" alt=""></button>${SectionTitle.getData()}</a>
    </h2>
    <#if Recommendation.getSiblings()?has_content>
    	<#list Recommendation.getSiblings() as cur_Recommendation>
        	<#if cur_Recommendation.PageTitle.getData()?has_content >
            <#assign anchor = cur_Recommendation.PageLink.getFriendlyUrl()?lower_case?remove_beginning('/web/guest')?remove_beginning('/')>
    	<h3 class="endnotes-group-recommendation">
    	    <a id="${anchor}" class="page-anchor recommendation-jump" tabindex="0"></a>
    	    ${cur_Recommendation.PageTitle.getData()}
		</h3>
    	${cur_Recommendation.PageNotes.getData()}
    	    </#if>
    	</#list>
    </#if>
</div>
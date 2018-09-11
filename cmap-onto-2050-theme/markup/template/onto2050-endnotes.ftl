<style>

body.default-theme .endnotes-container h1,
body.default-theme .endnotes-container h2 {
	color: #000;
	font-weight: normal;
}			

body.default-theme .endnotes-introduction {
    color: #000;
	font-family: "Prensa LF", Georgia, "Times New Roman", Times, serif ;
}

body.default-theme .endnotes-group-recommendation {
    background-color: #89a0b1;
    color: #fff !important;
    font-size: 15px;
    padding: 10px 20px;
    margin-left: -13px;
    margin-right: -13px;
}
			
body.default-theme .endnotes-group-content ol li {
	border-top: 1px solid rgba(71, 92, 102, 0.25);  
	color: #000;
}
			
body.default-theme .endnotes-group-content ol li:first-of-type {
	border-top: none;  
}

</style>

<div class="col-md-4 col-sm-16 portlet-column portlet-column-first" id="column-2"> 
</div>

<div class="col-md-8 col-sm-16 portlet-column" id="column-3"> 
    <div class="endnotes-container">
    <h1>Endnotes</h1>
        <div class="endnotes-introduction">
        ${Introduction.getData()}
        </div>
        <#if PageTitle.getSiblings()?has_content>
        	<div class="endnote-group">
        	<#list PageTitle.getSiblings() as cur_PageTitle>
        	<a id="${cur_PageTitle.PageLink.getFriendlyUrl()?lower_case?remove_beginning('/web/guest')?remove_beginning('/')}"></a>
        		<h2 class="endnotes-group-title">
        			${cur_PageTitle.getData()}
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
</div>

<div class="col-md-4 col-sm-16 portlet-column portlet-column-last" id="column-4"> 
    <#if PageTitle.getSiblings()?has_content>
	<div class="endnotes-navigation page-nav">
        <span class="widget-headline whitney-normal bold">Jump to</span>
        <ul class="list-unstyled">
    	<#list PageTitle.getSiblings() as cur_PageTitle>
    		<li>
    		    <span class="whitney-small bold">
    		    <a href="#${cur_PageTitle.PageLink.getFriendlyUrl()?lower_case?remove_beginning('/web/guest')?remove_beginning('/')}">
    			${cur_PageTitle.getData()}
    			</a>
    			</span>
    		</li>
    	</#list>
    	</ul>
    </div>
    </#if>
</div>
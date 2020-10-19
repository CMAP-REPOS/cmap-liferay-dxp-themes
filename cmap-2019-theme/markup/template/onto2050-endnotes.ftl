<div class="endnotes-container">
  <#if PageTitle.getSiblings()?has_content>
    <div class="endnote-group">
      <#list PageTitle.getSiblings() as cur_PageTitle>
        <#assign anchor = cur_PageTitle.PageLink.getFriendlyUrl()?lower_case?remove_beginning('/web/guest')?remove_beginning('/')>
        <h2 class="section-sub-headline bold alt-color">
          <a class="page-anchor" id="${anchor}" name="${anchor}" tabindex="0">
            <button class="page-anchor-button" tabindex="0">
              <span class="sr-only">${cur_PageTitle.getData()}</span> 
              <img class="page-anchor-icon" src="/o/cmap-2019-theme/images/icons/ic_clipboard.svg" alt="">
            </button> 
            ${cur_PageTitle.getData()}
          </a>
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
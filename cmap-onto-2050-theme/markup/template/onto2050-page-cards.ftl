

<div class="page-cards">
  <h4 class="widget-title">${Title.getData()}</h4>

  ${Anchor.getData()}

  <div class="row">
  <#if Card.getSiblings()?has_content>
    <#list Card.getSiblings() as cur_Card>

      <#if cur_Card.Asset.getData()?? && cur_Card.Asset.getData() != "">
        <#assign card_picture = cur_Card.Asset.getData()>
      <#else>
        <#assign card_picture = ''>
      </#if>

      <#if cur_Card.PageLink?? && cur_Card.PageLink.getData() != "" >
        <#assign card_link = cur_Card.PageLink.getData()>
      <#else>
        <#assign card_link = ''>
      </#if>

      <div class="page-card col-sm-8 col-xs-16">
        <div class="top">
          <#if card_link != '' >
            <a href="${cur_Card.PageLink.getFriendlyUrl()}">
          </#if>
            <#if card_picture != '' >
              <img data-fileentryid="${cur_Card.Asset.getAttribute("fileEntryId")}" alt="${cur_Card.Asset.getAttribute("alt")}" src="${cur_Card.Asset.getData()}" />
            <#else>
              <div class="placeholder-image"></div>
            </#if>
          <#if card_link != '' >
            </a>
          </#if>
        </div>

        <div class="bottom">
          <#if cur_Card.Title1?? && cur_Card.Title1.getData() != "" >
            <h4>
            <#if cur_Card.PageLink?? && cur_Card.PageLink.getData() != "" >
              <a href="${cur_Card.PageLink.getFriendlyUrl()}">
                ${cur_Card.Title1.getData()}
              </a>
            <#else>
              ${cur_Card.Title1.getData()}
            </#if>
            </h4>
          </#if>
        </div>
      </div>
    </#list>
  </#if>
  </div>
</div>

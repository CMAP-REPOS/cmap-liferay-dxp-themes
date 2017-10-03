<#if Slide.getSiblings()?has_content>
<section class="full-slider">
  <#list Slide.getSiblings() as S>
    <div class="slide">
      <div class="slide-text">
        <div class="slide-top row">
          <#if S.TopContent1.getSiblings()?has_content>
            <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
              ${S.TopContent1.getData()}
            </div>
          </#if>
        </div>

        <div class="slide-bottom row">
          <#if S.BottomContent.getSiblings()?has_content>
            <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
              ${S.BottomContent.getData()}
            </div>
          </#if>
        </div>
      </div>

      <#if S.Background.getData()?? && S.Background.getData() != "">
        <div class="slide-background">
          <img data-fileentryid="${S.Background.getAttribute("fileEntryId")}" alt="${S.Background.getAttribute("alt")}" src="${S.Background.getData()}" />
        </div>
      </#if>
    </div>
  </#list>
</section>
</#if>

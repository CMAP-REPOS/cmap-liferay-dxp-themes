<section class="homepage-hero">

  <div class="homepage-hero-text ">
    <div class="homepage-hero-top row">
      <#if HeroTitle.getSiblings()?has_content>
        <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
          <h1 class="homepage-hero-title ">
            <#list HeroTitle.getSiblings() as HeroTitleRow>
              ${HeroTitleRow.getData()}<br />
            </#list>
          </h1>
        </div>
      </#if>
    </div>

    <div class="homepage-hero-bottom row">
      <div class="homepage-hero-description col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
        ${HeroDescription.getData()}
      </div>
    </div>
  </div>

  <#if HeroBackground.getData()?? && HeroBackground.getData() != "">
    <div class="homepage-hero-background">
      <img data-fileentryid="${HeroBackground.getAttribute("fileEntryId")}" alt="${HeroBackground.getAttribute("alt")}" src="${HeroBackground.getData()}" />
    </div>
  </#if>

</section>

<section class="homepage-hero">

  <div class="homepage-hero-text ">
    <div class="homepage-hero-top row">
      <#if HeroTitle.getSiblings()?has_content>
        <h1 class="homepage-hero-title col-xl-10 col-xl-offset-3">
          <#list HeroTitle.getSiblings() as HeroTitleRow>
            ${HeroTitleRow.getData()}<br />
          </#list>
        </h1>
      </#if>
    </div>

    <div class="homepage-hero-bottom row">
      <div class="homepage-hero-description col-xl-10 col-xl-offset-3">
        ${HeroDescription.getData()}
      </div>
    </div>
  </div>

  <div class="homepage-hero-background">
    <#if HeroBackground.getData()?? && HeroBackground.getData() != "">
    	<img data-fileentryid="${HeroBackground.getAttribute("fileEntryId")}" alt="${HeroBackground.getAttribute("alt")}" src="${HeroBackground.getData()}" />
    </#if>
  </div>
</section>

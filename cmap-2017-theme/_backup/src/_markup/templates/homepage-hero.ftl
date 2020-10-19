<section class="homepage-hero">

  <div class="homepage-hero-text ">
    <div class="row">
      <#if HeroTitle.getSiblings()?has_content>
        <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
          <h1 class="homepage-hero-title ">
            <#list HeroTitle.getSiblings() as HeroTitleRow>
              ${HeroTitleRow.getData()}<br />
            </#list>
          </h1>
        </div>
      </#if>
      <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
        <div class="homepage-hero-description">
          ${HeroDescription.getData()}
        </div>
      </div>
    </div>
  </div>

  <#if HeroBackground.getData()?? && HeroBackground.getData() != "">
    <div class="homepage-hero-background">
      <img data-fileentryid="${HeroBackground.getAttribute("fileEntryId")}" alt="${HeroBackground.getAttribute("alt")}" src="${HeroBackground.getData()}" />
    </div>
  </#if>

  <svg class="close-nav nav-icon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ev="http://www.w3.org/2001/xml-events" viewBox="0 0 29 29" width="29" height="29">
  	<style type="text/css">
  		.st1 {
  			fill: none;
  			stroke: #FFFFFF;
  			stroke-width: 2.7908;
  		}
  	</style>
  	<line class="st1" x1="1.3" y1="1.3" x2="27.6" y2="27.6"></line>
  	<line class="st1" x1="1.3" y1="27.6" x2="27.6" y2="1.3"></line>
  </svg>
  <svg class="open-nav nav-icon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ev="http://www.w3.org/2001/xml-events" width="22" height="16" viewBox="0 0 22 16">
    <g fill="#000000" transform="translate(1 1)">
      <polygon points="0 1.802 0 .198 20 .198 20 1.802"></polygon>
      <polygon points="0 7.498 0 5.894 20 5.894 20 7.498"></polygon>
      <polygon points="0 13.197 0 11.593 20 11.593 20 13.197"></polygon>
    </g>
  </svg>
</section>

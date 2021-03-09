<!-- https://gsmblog.net/blog/date-objects-liferay-freemarker-web-content-templates/ -->
<#-- Retrieve the published date meta data field of the web content -->
<#assign displaydate = .vars['reserved-article-display-date'].data>
<#assign createdate = .vars['reserved-article-create-date'].data>
<#assign modifieddate = .vars['reserved-article-modified-date'].data>
<#assign articleId = .vars['reserved-article-id'].data>

<#assign JournalArticleLocalService = serviceLocator.findService("com.liferay.journal.service.JournalArticleLocalService")>
<#assign AssetEntryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService")>

<#assign journalArticle = JournalArticleLocalService.getArticle(groupId, articleId)>
<#assign journalArticleResource = journalArticle.getArticleResource()>
<#assign assetEntry = AssetEntryLocalService.fetchEntry(groupId, journalArticleResource.getUuid())>

<#-- Save the original page locale for later -->
<#assign originalLocale = .locale>

<#-- Set the page locale to the portals default locale -->
<#setting locale = localeUtil.getDefault()>

<#-- Parse the date to a date object -->
<#assign displaydate = displaydate?datetime("EEE, d MMM yyyy HH:mm:ss Z")>
<#assign createdate = createdate?datetime("EEE, d MMM yyyy HH:mm:ss Z")>
<#assign modifieddate = modifieddate?datetime("EEE, d MMM yyyy HH:mm:ss Z")>

<#-- Set the page locale back to the original page locale -->
<#assign locale = originalLocale>

<#assign serviceContext = staticUtil["com.liferay.portal.kernel.service.ServiceContextThreadLocal"].getServiceContext()>
<#assign themeDisplay = serviceContext.getThemeDisplay() />

<#assign sectionTitles = []>
<#list Subtitle.getSiblings() as cur_subTitle>
  <#if cur_subTitle?? && cur_subTitle.getData()?? && cur_subTitle.getData() != "">
    <#assign sectionTitles = sectionTitles + [cur_subTitle]>
  </#if>
</#list>

<#function cleanContractions str>
  <#assign returnString = '' />
  <#list 0..<str?length as i>>
    <#if i != 0 && i != str?length - 1 >
      <#if str[i - 1] == "-" && str[i + 1] == "-">
        <#if str[i] != "a" && str[i] != "i">
          <#assign returnString = str[0..i-2] + "'" + str[i..str?length-1] />
        <#else>
          <#assign returnString = str />
        </#if>
      <#else>
        <#assign returnString = str />
      </#if>
    </#if>
  </#list>
  <#return returnString>
</#function>

<#assign title = themeDisplay.getURLCurrent()?keep_after_last("/") />
<#assign title = cleanContractions(title)?replace("-", " ")?capitalize />

<#function cleanImageURL imageURL>
  <#if imageURL?contains("@root")>
    <#return imageURL?keep_after("root_path@") >
  <#else>
    <#return imageURL >
  </#if>
</#function>

<section class="title-with-sections 2019">

  <div class="row page-layout">

    <div class="col-md-3 col-sm-16">
      <div class="page-date">
        <#-- Logic is inverted because HideDateInSidebar (Boolean7kfq) is undefined by default -->
        <#if Boolean7kfq?? && getterUtil.getBoolean(Boolean7kfq.getData())>
        <#else>
          <h4 class="h4">${assetEntry.getPublishDate()?date}</h4>
        </#if>
      </div>
    </div>

    <div class="col-md-10 col-sm-16">
      <#if Title.getData() != "">
        <div class="page-title">
          <h1 class="h1">${Title.getData()}</h1>
        </div>
      </#if>

      <#if sectionTitles?size != 0>
        <div class="mobile-page-nav">
          <select name="page-nav" class="form-control">
            <option value="" selected="true" disabled="true">Jump to section</option>
            <#list Subtitle.getSiblings() as section>
              <#if section.getData() != "">
                <option value="#${section.getData()?replace(" ", "_")}">${section.getData()}</option>
              </#if>
            </#list>
          </select>
        </div>
      </#if>

      <#list Subtitle.getSiblings() as section>
        <section>
          <#if section.getData() != "">
            <div class="section-title">
              <#assign currentUrl = themeDisplay.getPortalURL() + themeDisplay.getURLCurrent() />
              <#assign temp = section.getData()?replace(" ", "_") />
              <#assign sectionID = temp?replace("\\W","", "r") />
              <button aria-label="section-hyperlink" class="section-hyperlink" data-url="#${sectionID}_2019">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20"> <g fill="#3C5976" transform="translate(2 2)"> <path d="M6.46966991,10.1913079 L7.06366991,10.7853079 C7.19742939,10.9190674 7.41355912,11.0987434 7.70019478,11.2769265 C8.57658114,11.8217201 9.54159691,11.9862244 10.4719295,11.469604 C10.6962841,11.3450182 10.90851,11.183128 11.1073301,10.9843079 L15.7473872,6.34325075 C15.8607328,6.22990523 16.0062522,6.04910633 16.1479065,5.80442489 C16.7709911,4.72816198 16.7077829,3.45910054 15.5483301,2.29964772 L14.4883301,1.23964772 C14.3545706,1.10588825 14.1384409,0.926212244 13.8518052,0.748029107 C12.9754189,0.203235524 12.0104031,0.038731182 11.0800705,0.555351622 C10.8557159,0.679937389 10.64349,0.841827652 10.4446699,1.04064772 L7.98477774,3.49953992 C7.69182498,3.79237359 7.69172844,4.26724732 7.98456211,4.56020007 C8.27739578,4.85315283 8.75226951,4.85324937 9.04522226,4.5604157 L11.5052223,2.1014157 C11.607414,1.99922402 11.7083835,1.92220234 11.8082861,1.86672574 C12.1751901,1.66298129 12.5985233,1.73514606 13.0598905,2.0219487 C13.2377414,2.13250725 13.3689349,2.24157292 13.4276699,2.3003079 L14.4876699,3.3603079 C15.1279755,4.00061344 15.1541946,4.52702838 14.8497592,5.05288402 C14.7800388,5.17331299 14.7141837,5.25513398 14.6866699,5.28264772 L10.0466128,9.92370487 C9.94458604,10.0257316 9.84361645,10.1027533 9.74371392,10.1582299 C9.37680992,10.3619743 8.95347672,10.2898096 8.49210946,10.0030069 C8.31425862,9.89244838 8.18306507,9.78338271 8.12433009,9.72464772 L7.53033009,9.13064772 C7.23743687,8.83775451 6.76256313,8.83775451 6.46966991,9.13064772 C6.1767767,9.42354094 6.1767767,9.89841468 6.46966991,10.1913079 Z"/> <path d="M10.3109958,6.83364772 L9.71699575,6.23964772 C9.58323628,6.10588825 9.36710655,5.92621224 9.08047089,5.74802911 C8.20408453,5.20323552 7.23906875,5.03873118 6.30873617,5.55535162 C6.08438152,5.67993739 5.87215565,5.84182765 5.67333558,6.04064772 L1.03327844,10.6817049 C0.919932909,10.7950504 0.774413466,10.9758493 0.632759199,11.2205307 C0.00967461158,12.2967936 0.072882768,13.5658551 1.23233558,14.7253079 L2.29233558,15.7853079 C2.42609505,15.9190674 2.64222479,16.0987434 2.92886045,16.2769265 C3.8052468,16.8217201 4.77026258,16.9862244 5.70059516,16.469604 C5.92494981,16.3450182 6.13717568,16.183128 6.33599575,15.9843079 L8.79588793,13.5254157 C9.08884069,13.232582 9.08893722,12.7577083 8.79610355,12.4647555 C8.50326988,12.1718028 8.02839616,12.1717063 7.7354434,12.4645399 L5.2754434,14.9235399 C5.1732517,15.0257316 5.07228212,15.1027533 4.97237959,15.1582299 C4.60547559,15.3619743 4.18214238,15.2898096 3.72077513,15.0030069 C3.54292429,14.8924484 3.41173073,14.7833827 3.35299575,14.7246477 L2.29299575,13.6646477 C1.65269021,13.0243422 1.62647105,12.4979272 1.93090647,11.9720716 C2.00062683,11.8516426 2.06648201,11.7698216 2.09399575,11.7423079 L6.73405289,7.10125075 C6.83607963,6.99922402 6.93704921,6.92220234 7.03695174,6.86672574 C7.40385574,6.66298129 7.82718895,6.73514606 8.2885562,7.0219487 C8.46640705,7.13250725 8.5976006,7.24157292 8.65633558,7.3003079 L9.25033558,7.8943079 C9.5432288,8.18720112 10.0181025,8.18720112 10.3109958,7.8943079 C10.603889,7.60141468 10.603889,7.12654094 10.3109958,6.83364772 Z"/> </g> </svg>
              </button>
              <h2 id="${sectionID}_2019">${section.getData()}</h2>
            </div>
          </#if>
          <div class="section-content">
            ${section.Body.getData()}
          </div>
        </section>
      </#list>
    </div>

    <div class="col-md-3 col-sm-16 page-nav">
      <#if showRightHandNav?? && getterUtil.getBoolean(showRightHandNav.getData())>
        <div class="page-nav-container">
          <#if sectionTitles?size != 0>
            <div class="page-nav-title" style="margin-bottom: 1rem" >
              <h2 class="page-nav-title-h2" >Sections</h2>
            </div>
            <nav class="page-nav-list">
              <#list Subtitle.getSiblings() as section>
                <#if section.getData() != "">
                  <div class="page-nav-item">
                    <a class="page-nav-link" data-senna-off="true" href="#${section.getData()?replace(" ", "_")?replace("\\W","", "r")}" >
                      ${section.getData()}
                    </a>
                  </div>
                </#if>
              </#list>
            </nav>
          </#if>
        </div>
      </#if>
    </div>
  </div>
  <div class="fixed-jump-to-top-button jump-to-top-button">
    <div class="row">
      <div class="col-md-8">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="19" viewBox="0 0 16 19"> <path fill="#3C5976" d="M8.70320061,4.28823998 L8.70320061,17.4126841 C8.70320061,17.8959333 8.31144977,18.2876841 7.82820061,18.2876841 C7.34495145,18.2876841 6.95320061,17.8959333 6.95320061,17.4126841 L6.95320061,4.28785174 L2.48442136,8.62526255 C2.13765366,8.96183633 1.58369594,8.95357254 1.24712216,8.60680484 C0.910548372,8.26003715 0.918812169,7.70607943 1.26557986,7.36950564 L7.82800061,1 L14.3904214,7.36950564 C14.7371891,7.70607943 14.7454528,8.26003715 14.4088791,8.60680484 C14.0723053,8.95357254 13.5183476,8.96183633 13.1715799,8.62526255 L8.70320061,4.28823998 Z"></path> </svg>
        <span>To Top</span>
      </div>
    </div>
  </div>
</section>

<section class="title-with-sections 2017">

  <div class="row page-layout">

    <div class="col-xl-3 col-sm-16">
      <div class="page-date">
        <#-- Logic is inverted because HideDateInSidebar (Boolean7kfq) is undefined by default -->
        <#if Boolean7kfq?? && getterUtil.getBoolean(Boolean7kfq.getData())>
        <#else>
          <h4 class="h4">${assetEntry.getPublishDate()?date}</h4>
        </#if>
      </div>
    </div>

    <div class="col-xl-10 col-sm-16">
      <#if Title.getData() != "">
        <div class="page-title">
          <h1 class="h1">${Title.getData()}</h1>
        </div>
      </#if>

      <#if sectionTitles?size != 0>
        <div class="mobile-page-nav">
          <select name="page-nav" class="form-control">
            <option value="" selected="true" disabled="true">Jump to section</option>
            <#list Subtitle.getSiblings() as section>
              <#if section.getData() != "">
                <option value="#${section.getData()?replace(" ", "_")}">${section.getData()}</option>
              </#if>
            </#list>
          </select>
        </div>
      </#if>

      <#list Subtitle.getSiblings() as section>
        <section>
          <#if section.getData() != "">
            <div class="section-title">
              <#assign currentUrl = themeDisplay.getPortalURL() + themeDisplay.getURLCurrent() />
              <#assign temp = section.getData()?replace(" ", "_") />
              <#assign sectionID = temp?replace("\\W","", "r") />
              <button class="section-hyperlink" data-url="#${sectionID}_2017">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20"> <g fill="#3C5976" transform="translate(2 2)"> <path d="M6.46966991,10.1913079 L7.06366991,10.7853079 C7.19742939,10.9190674 7.41355912,11.0987434 7.70019478,11.2769265 C8.57658114,11.8217201 9.54159691,11.9862244 10.4719295,11.469604 C10.6962841,11.3450182 10.90851,11.183128 11.1073301,10.9843079 L15.7473872,6.34325075 C15.8607328,6.22990523 16.0062522,6.04910633 16.1479065,5.80442489 C16.7709911,4.72816198 16.7077829,3.45910054 15.5483301,2.29964772 L14.4883301,1.23964772 C14.3545706,1.10588825 14.1384409,0.926212244 13.8518052,0.748029107 C12.9754189,0.203235524 12.0104031,0.038731182 11.0800705,0.555351622 C10.8557159,0.679937389 10.64349,0.841827652 10.4446699,1.04064772 L7.98477774,3.49953992 C7.69182498,3.79237359 7.69172844,4.26724732 7.98456211,4.56020007 C8.27739578,4.85315283 8.75226951,4.85324937 9.04522226,4.5604157 L11.5052223,2.1014157 C11.607414,1.99922402 11.7083835,1.92220234 11.8082861,1.86672574 C12.1751901,1.66298129 12.5985233,1.73514606 13.0598905,2.0219487 C13.2377414,2.13250725 13.3689349,2.24157292 13.4276699,2.3003079 L14.4876699,3.3603079 C15.1279755,4.00061344 15.1541946,4.52702838 14.8497592,5.05288402 C14.7800388,5.17331299 14.7141837,5.25513398 14.6866699,5.28264772 L10.0466128,9.92370487 C9.94458604,10.0257316 9.84361645,10.1027533 9.74371392,10.1582299 C9.37680992,10.3619743 8.95347672,10.2898096 8.49210946,10.0030069 C8.31425862,9.89244838 8.18306507,9.78338271 8.12433009,9.72464772 L7.53033009,9.13064772 C7.23743687,8.83775451 6.76256313,8.83775451 6.46966991,9.13064772 C6.1767767,9.42354094 6.1767767,9.89841468 6.46966991,10.1913079 Z"/> <path d="M10.3109958,6.83364772 L9.71699575,6.23964772 C9.58323628,6.10588825 9.36710655,5.92621224 9.08047089,5.74802911 C8.20408453,5.20323552 7.23906875,5.03873118 6.30873617,5.55535162 C6.08438152,5.67993739 5.87215565,5.84182765 5.67333558,6.04064772 L1.03327844,10.6817049 C0.919932909,10.7950504 0.774413466,10.9758493 0.632759199,11.2205307 C0.00967461158,12.2967936 0.072882768,13.5658551 1.23233558,14.7253079 L2.29233558,15.7853079 C2.42609505,15.9190674 2.64222479,16.0987434 2.92886045,16.2769265 C3.8052468,16.8217201 4.77026258,16.9862244 5.70059516,16.469604 C5.92494981,16.3450182 6.13717568,16.183128 6.33599575,15.9843079 L8.79588793,13.5254157 C9.08884069,13.232582 9.08893722,12.7577083 8.79610355,12.4647555 C8.50326988,12.1718028 8.02839616,12.1717063 7.7354434,12.4645399 L5.2754434,14.9235399 C5.1732517,15.0257316 5.07228212,15.1027533 4.97237959,15.1582299 C4.60547559,15.3619743 4.18214238,15.2898096 3.72077513,15.0030069 C3.54292429,14.8924484 3.41173073,14.7833827 3.35299575,14.7246477 L2.29299575,13.6646477 C1.65269021,13.0243422 1.62647105,12.4979272 1.93090647,11.9720716 C2.00062683,11.8516426 2.06648201,11.7698216 2.09399575,11.7423079 L6.73405289,7.10125075 C6.83607963,6.99922402 6.93704921,6.92220234 7.03695174,6.86672574 C7.40385574,6.66298129 7.82718895,6.73514606 8.2885562,7.0219487 C8.46640705,7.13250725 8.5976006,7.24157292 8.65633558,7.3003079 L9.25033558,7.8943079 C9.5432288,8.18720112 10.0181025,8.18720112 10.3109958,7.8943079 C10.603889,7.60141468 10.603889,7.12654094 10.3109958,6.83364772 Z"/> </g> </svg>
              </button>
              <h2 id="${sectionID}_2017">${section.getData()}</h2>
            </div>
          </#if>
          <div class="section-content">
            ${section.Body.getData()}
          </div>
        </section>
      </#list>
    </div>

    <div class="col-xl-3 col-sm-16 page-nav">
      <#if showRightHandNav?? && getterUtil.getBoolean(showRightHandNav.getData())>
        <div class="page-nav-container">
          <#if sectionTitles?size != 0>
            <div class="page-nav-title" style="margin-bottom: 1rem" >
              <h2 class="page-nav-title-h2">Sections</h2>
            </div>
            <nav class="page-nav-list">
              <#list Subtitle.getSiblings() as section>
                <#if section.getData() != "">
                  <div class="page-nav-item">
                    <a class="page-nav-link" data-senna-off="true" href="#${section.getData()?replace(" ", "_")?replace("\\W","", "r")}">
                      ${section.getData()}
                    </a>
                  </div>
                </#if>
              </#list>
            </nav>
          </#if>
        </div>
      </#if>
    </div>
  </div>
  <div class="fixed-jump-to-top-button jump-to-top-button">
    <div class="row">
      <div class="col-xl-3 col-md-8">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="19" viewBox="0 0 16 19"> <path fill="#3C5976" d="M8.70320061,4.28823998 L8.70320061,17.4126841 C8.70320061,17.8959333 8.31144977,18.2876841 7.82820061,18.2876841 C7.34495145,18.2876841 6.95320061,17.8959333 6.95320061,17.4126841 L6.95320061,4.28785174 L2.48442136,8.62526255 C2.13765366,8.96183633 1.58369594,8.95357254 1.24712216,8.60680484 C0.910548372,8.26003715 0.918812169,7.70607943 1.26557986,7.36950564 L7.82800061,1 L14.3904214,7.36950564 C14.7371891,7.70607943 14.7454528,8.26003715 14.4088791,8.60680484 C14.0723053,8.95357254 13.5183476,8.96183633 13.1715799,8.62526255 L8.70320061,4.28823998 Z"></path> </svg>
        <span>To Top</span>
      </div>
    </div>
  </div>
</section>

<!-- -->
<#if UseThumbnailImage?? && getterUtil.getBoolean(UseThumbnailImage.getData())>
  <#if UseThumbnailImage.ThumbnailImage.getData()?? && UseThumbnailImage.ThumbnailImage.getData() != "">
    <#assign imageURL = UseThumbnailImage.ThumbnailImage.getData() >
    <img style="display: none" alt="${UseThumbnailImage.ThumbnailImage.getAttribute("alt")}" data-fileentryid="${UseThumbnailImage.ThumbnailImage.getAttribute("fileEntryId")}" src="${UseThumbnailImage.ThumbnailImage.getData()}" />
    <!-- <meta name="twitter:description" content="${UseThumbnailImage.ThumbnailImage.getAttribute("alt")}"> <meta property="og:description" content="${UseThumbnailImage.ThumbnailImage.getAttribute("alt")}"/> -->
    <@liferay_util["html-top"]>

      <!-- Twitter -->
      <meta name="twitter:card" content="summary_large_image" />
      <meta name="twitter:title" content="${title}">
      <meta name="twitter:image" content="https://www.cmap.illinois.gov${cleanImageURL(imageURL)}">

      <!-- Facebook and LinkedIn -->

      <meta property="og:title" content="${title}" />
      <meta property="og:image" content="https://www.cmap.illinois.gov${cleanImageURL(imageURL)}" />
      <meta property="og:url" content="https://www.cmap.illinois.gov${themeDisplay.getURLCurrent()}" />

    </@>
  </#if>
</#if>

<script type="text/javascript">

  var cmap = cmap || {};
  cmap.titleWithSections = cmap.titleWithSections || {};

  cmap.titleWithSections.init = function() {
    $('.page-nav').css("width", "18.75%");

    $('.standalone-section').each(function() {
      var $this = $(this);
      var $sectionTitle = $this.find('.section-title > h2');
      if ($sectionTitle.text().length) {
        var title = $sectionTitle.data('text');
        var id = $sectionTitle.attr('id');
        $('.page-nav-list').append('<div class="page-nav-item"><a href="#' + id + '">' + title + '</a></div>')
        $('.mobile-page-nav select').append('<option value="#'+id+'">' + title + '</option>');
      }
    });
    // console.log($('.page-nav-container').offset());

    // $('.page-nav-container').data('original-offset-top', $('.page-nav-container').offset().top);

    // console.log("page-nav-container offset top: " + $('.page-nav-container').offset().top);

    // remove inline styles from content items
    var pathname = window.location.pathname.replace('/web/guest','');

    if ((pathname.indexOf('/on-to-2050/') !== 0) && (pathname.indexOf('/2050/') !== 0)) {
      $('.section-content').find('h1,h2,h3,h4,h5,h6,p,a,span,table').removeAttr('style');
    }

    // remove empty paragraphs
    //$('p').each(function(){
    //    var $p = $(this);
    //    console.log($p)
    //    if($p.html().trim() === '&nbsp;'){
    //       console.log($p)
    //        $p.remove();
    //    }
    //});

    // Stolen from stack overflow
    // https://stackoverflow.com/questions/400212/how-do-i-copy-to-the-clipboard-in-javascript
    function copyToClipboard(text) {
      if (window.clipboardData && window.clipboardData.setData) {
        // IE specific code path to prevent textarea being shown while dialog is visible.
        return clipboardData.setData("Text", text);
      } else if (document.queryCommandSupported && document.queryCommandSupported("copy")) {
        var textarea = document.createElement("textarea");
        textarea.textContent = text;
        textarea.style.position = "fixed";  // Prevent scrolling to bottom of page in MS Edge.
        document.body.appendChild(textarea);
        textarea.select();
        try {
          return document.execCommand("copy");  // Security exception may be thrown by some browsers.
        } catch (ex) {
          console.warn("Copy to clipboard failed.", ex);
          return false;
        } finally {
          document.body.removeChild(textarea);
        }
      }
    }

    $('.section-hyperlink').click(function(){
      var toCopy = window.location.origin + window.location.pathname + $(this).data('url');
      window.history.replaceState(null, '', $(this).data('url'));
      var status = copyToClipboard(toCopy);
      console.log(toCopy, Liferay.currentUrl, status);
    });

    $('.jump-to-top-button').click(function(){
      $('html,body').animate({
        scrollTop: 0
      }, 800);
    });
  };

  cmap.titleWithSections.bindEvents = function() {

    $(window).off('scroll').on('scroll', _.throttle(cmap.titleWithSections.computeScrollNav, 100));

    function moveToID(id){
      if($('.cmap-2017-theme').length) {
        id = id +  "_2017";
      } else {
        id = id + "_2019";
      };
      var push = $('#scroll-nav').innerHeight() * 1.5;
      var target = $(id).offset().top;
      $('html,body').animate({
        scrollTop: target - push
      }, 800);
    }
    $('.page-nav-item a').click(function(e){
      e.preventDefault();
      moveToID($(this).attr('href'));
    });

    $('.mobile-page-nav select').on('change', function(){
      moveToID($(this).val());
    });

    var $banner = $('#banner'), $scroll_nav = $('#scroll-nav');
    if($banner.length && $scroll_nav.length){
      $(window).scroll(_.throttle(function(){
        var this_scroll = window.scrollY + $('#ControlMenu').innerHeight();
        var target_scroll = $banner.offset().top + $banner.innerHeight();
        if(this_scroll > target_scroll){
          $scroll_nav.addClass('active');
        } else {
          $scroll_nav.removeClass('active');
        }
      },100));
    }
  };

  cmap.titleWithSections.computeScrollNav = function() {

    var titleWithSectionsNodes = document.querySelectorAll("section.title-with-sections");
    if($('.cmap-2017-theme').length){
      var titleWithSectionsNode = titleWithSectionsNodes[1];
    }
    else{
      var titleWithSectionsNode = titleWithSectionsNodes[0];
    }

    var bodyRect = document.body.getBoundingClientRect();
    var elemRect = titleWithSectionsNode ? titleWithSectionsNode.getBoundingClientRect() : null;
    var offset   = (elemRect ? elemRect.top : 0) - bodyRect.top;

    var scrollTop = $(window).scrollTop();
    var navHeight = $('#scroll-nav').height();
    var currentOffset = scrollTop + navHeight;

    if (currentOffset > offset) {
      $('.page-nav-container').addClass('fixed');
      $('.page-nav-container').css("top", "2.656em");
    } else {
      $('.page-nav-container').removeClass('fixed');
      $('.page-nav-container').css("top", "0");
    }
  };

  AUI().ready(function(){
    //cmap.titleWithSections.init();
    //cmap.titleWithSections.bindEvents()
    setTimeout(function(){cmap.titleWithSections.init()}, 500);
    setTimeout(function(){cmap.titleWithSections.bindEvents()}, 500);
  });

</script>

<script>
  Liferay.on(
          'allPortletsReady',
          function() {
            if($('.cmap-2017-theme').length){
              $('.2019').hide();
            }
            else{
              console.log("hiding 2017");
              $('.2017').hide();
            }
          }
  );
</script>
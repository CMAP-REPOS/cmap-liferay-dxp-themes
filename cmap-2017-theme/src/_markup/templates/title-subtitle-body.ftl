<!-- https://gsmblog.net/blog/date-objects-liferay-freemarker-web-content-templates/ -->
<#-- Retrieve the published date meta data field of the web content -->
<#assign displaydate = .vars['reserved-article-display-date'].data>
<#assign createdate = .vars['reserved-article-create-date'].data>
<#assign modifieddate = .vars['reserved-article-modified-date'].data>

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

<section class="title-with-sections">
  <div class="row page-layout">

    <div class="col-xl-3 col-sm-16">
      <div class="page-date">
      <#-- Logic is inverted because HideDateInSidebar (Boolean7kfq) is undefined by default -->
      <#if Boolean7kfq?? && getterUtil.getBoolean(Boolean7kfq.getData())>
      <#else>
        <h4 class="h4">${modifieddate?date}</h4>
      </#if>
      </div>
    </div>

    <div class="col-xl-10 col-sm-12 col-xs-16">
      <#if Title.getData() != "">
      <div class="page-title">
        <h1 class="h1">${Title.getData()}</h1>
      </div>
      </#if>

      <#list Subtitle.getSiblings() as section>
        <section>
          <#if section.getData() != "">
          <div class="section-title">
            <h2 id="${section.getData()?replace(" ", "_")}">${section.getData()}</h2>
          </div>
          </#if>
          <div class="section-content">
            ${section.Body.getData()}
          </div>
        </section>
      </#list>
    </div>

    <div class="col-xl-3 col-sm-4 page-nav">
      <div class="page-nav-container">
        <div class="page-nav-title">
          <h3>Sections</h3>
        </div>
        <nav class="page-nav-list">
          <#list Subtitle.getSiblings() as section>
            <#if section.getData() != "">
              <div class="page-nav-item">
                <a href="#${section.getData()?replace(" ", "_")}">
                  ${section.getData()}
                </a>
              </div>
            </#if>
          </#list>
        </nav>
        <div class="page-nav-top"></div>
      </div>
    </div>
  </div>
</section>

<script type="text/javascript">

var cmap = cmap || {};
cmap.titleWithSections = cmap.titleWithSections || {};

cmap.titleWithSections.init = function() {

  $('.standalone-section').each(function() {
    var $this = $(this);
    var $sectionTitle = $this.find('.section-title > h2');
    $('.page-nav-list').append('<div class="page-nav-item"><a href="#' +  $sectionTitle.attr('id') + '">' +  $sectionTitle.data('text') + '</a></div>')
  });

  $('.page-nav-container').data('original-offet-top', $('.page-nav-list').offset().top);

  // remove inline styles from content items
  $('.section-content').find('h1,h2,h3,h4,h5,h6,p,a,span,table').removeAttr('style');

  // remove empty paragraphs
  $('p').each(function(){
    var $p = $(this);
    if($p.html().trim() === '&nbsp;'){
      $p.remove();
    }
  });

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
};



cmap.titleWithSections.bindEvents = function() {

  // disable sticky nav in control panel
  if (!Liferay.ThemeDisplay.isSignedIn()) {
    $(window).off('scroll').on('scroll', _.throttle(cmap.titleWithSections.computeScrollNav, 100));
  }

  $('.page-nav-item a').click(function(e){
    e.preventDefault();
    var push = $('#scroll-nav').innerHeight();
    var href = $(this).attr('href');
    var target = $(href).offset().top;
    $('html,body').animate({
      scrollTop: target - push
    }, 800);
  });
};



cmap.titleWithSections.computeScrollNav = function() {

  var scrollTop = $(window).scrollTop();
  var navHeight = $('#scroll-nav').height();

  var currentOffset = scrollTop + navHeight;
  var fourUnits = $('.page-nav-top').innerHeight();
  var originalOffset = $('.page-nav-container').data('original-offet-top') - fourUnits;

  if (currentOffset > originalOffset) {
    $('.page-nav-container').addClass('fixed');
  } else {
    $('.page-nav-container').removeClass('fixed');
  }

  console.log(currentOffset > originalOffset, currentOffset, originalOffset, fourUnits);

  // $('.page-nav-container')
  //   .css('position', 'absolute')
  //   .animate({ marginTop, marginTop }, 100);

  // $('.page-nav-container').css('position', 'fixed');
};



$(function(){
  cmap.titleWithSections.init();
  cmap.titleWithSections.bindEvents();
});

</script>
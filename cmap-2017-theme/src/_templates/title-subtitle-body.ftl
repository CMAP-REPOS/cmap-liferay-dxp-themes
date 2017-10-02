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

<div class="row">

  <div class="col-xl-3 col-sm-16">
    <div class="page-date">
      <h4 class="h4">${modifieddate?date}</h4>
    </div>
  </div>

  <div class="col-xl-10 col-sm-10">
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


  <div class="col-xl-3 col-sm-6 page-nav">
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
  </div>
</div>

<script type="text/javascript">
(function($) {
  $('body').addClass('structured-template');

  // Title with Sections - Jump to section
  $('.page-nav-item a').click(function(e){
    e.preventDefault();
    var push = $('#scroll-nav').innerHeight();
    var href = $(this).attr('href');
    var target = $(href).offset().top;
    $('html,body').animate({
      scrollTop: target - push
    }, 800);
  });
})(jQuery);
</script>

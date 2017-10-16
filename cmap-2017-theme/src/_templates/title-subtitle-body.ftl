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
  <div class="row">

    <div class="col-xl-3 col-sm-16">
      <div class="page-date">
        <h4 class="h4">${modifieddate?date}</h4>
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


  <div class="row scrolling-page-nav">

    <div class="col-xl-3 col-sm-16"> </div>
    <div class="col-xl-10 col-sm-12 col-xs-16"></div>

    <div class="col-xl-3 col-xl-offset-13 col-sm-4 col-sm-offset-12 page-nav">
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
</section>

<script type="text/javascript">
(function($) {
  // $('body').addClass('structured-template');

  // Jump to section on page
  $('.page-nav-item a').click(function(e){
    e.preventDefault();
    var push = $('#scroll-nav').innerHeight();
    var href = $(this).attr('href');
    var target = $(href).offset().top;
    $('html,body').animate({
      scrollTop: target - push
    }, 800);
  });


  // Sticky page nav
  var top = $('.page-nav-list').offset().top;
  var height = $('.page-nav-list').innerHeight();

  function computeScrollNav(){
    if(window.scrollY > (top + height)){
      $('.scrolling-page-nav').fadeIn();
    } else {
      $('.scrolling-page-nav').fadeOut();
    }
  }
  $(window).scroll(_.throttle(computeScrollNav,100));
  computeScrollNav();

  // remove inline styles from content items
  $('.section-content *').removeAttr('style');

  // Tables
  $('.portlet-body table').each(function(){
    var $table = $(this);
    var $container = $('<div class="table-container"> </div>');
    var number_of_col = $table.find('tr:first-of-type td').length;

    // we don't want any inline styles floating around
    $table.removeAttr('style');
    // start with fresh classes, makes it easier to manipulate later
    $table.find('td').removeAttr('class');

    // init the grid
    $table.find('tr').addClass('row');
    $table.find('td').addClass('col-xl-1');
    $table.find('th').addClass('col-xl-1');

    // find the tallest row (problem)
    var max_height = 0, $max_row = null;
    $table.find('tr').each(function(i){
      // console.log('ROW', i, $(this), $(this).text().length);
      var $row = $(this), row_height = $row.innerHeight();
      if(row_height > max_height){
        max_height = row_height;
        $max_row = $row;
      }
    });


    function normalizeColumn(){
      var $cell = $(this);

      $cell.find('p').each(function(){
        var $p = $(this);
        $p.parent().append($p.html());
        $p.remove();
      });

      while($cell[0].clientWidth < $cell[0].scrollWidth){
        var old_width = parseInt($cell.attr('class').charAt(7));
        var new_width = old_width + 1;
        $cell.removeAttr('class');
        $cell.addClass('col-xl-' + new_width);
        if(new_width > largest_col){
          largest_col = new_width;
        }
      }
    }

    for(var i=1; i<=number_of_col; i++){
      var selector = 'tr td:nth-of-type('+i+'), th:nth-of-type('+i+')';
      var largest_col = 0;

      console.log($table.find(selector));
      $table.find(selector).each(normalizeColumn);
      $table.find(selector).removeAttr('class');
      $table.find(selector).addClass('col-xl-'+largest_col);
    }

  });
})(jQuery);
</script>

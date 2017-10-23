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
      $('.page-layout .page-nav').addClass('hidden');
    } else {
      $('.scrolling-page-nav').fadeOut();
      $('.page-layout .page-nav').removeClass('hidden');
    }
  }
  $(window).off('scroll.page-nav');
  $(window).on('scroll.page-nav', _.throttle(computeScrollNav,100));
  computeScrollNav();

  // remove inline styles from content items
  // $('.section-content *').removeAttr('style');
  $('.section-content p').removeAttr('style');

  // Tables
  $('.portlet-body table').each(function(){
    var $table = $(this);
    
    var number_of_col = $table.find('tr:first-of-type td').length;

    $table.wrap('<div class="table-container"></div>');

    // we don't want any inline styles floating around, telling the table how wide to be
    // $table.removeAttr('style');

    var $last_row = $table.find('tr:last-of-type');
    console.log($last_row);
    $last_row.find('td').each(function(i,el){
      console.log(i, el);
    });

    // start with fresh classes, makes it easier to manipulate later
    // $table.find('td, th').removeAttr('class');

    // init the grid
    // $table.find('tr').addClass('row');

    // we might want to disallow some tags in the table
    // function removeTag(el, tag){
    //   $(el).find(tag).each(function(){
    //     var $tag = $(this);
    //     $tag.after($tag.html());
    //     $tag.remove();
    //   });
    // }
    // $table.find('td, th').each(function(){
    //   removeTag(this, 'p');
    // });

    // find the width of all columns, based on the amount of text in the cells
    // var col_widths = [], row_width = 0;
    // for(var i=1; i<=number_of_col; i++){
    //   var $cells = $table.find('tr td:nth-of-type('+i+'), th:nth-of-type('+i+')');
    //   var width = $cells.text().trim().length;
    //   col_widths[i-1] = width;
    //   row_width += width;
    // }

    // compute a 16 grid equivelent based on amount of text in each col
    // col_widths.forEach(function(width, i){
    //   var $cells = $table.find('tr td:nth-of-type('+(i+1)+'), th:nth-of-type('+(i+1)+')');
    //   var this_width = Math.round((width / row_width) * 16);
    //   $cells.removeAttr('class');
    //   $cells.addClass('col-xl-'+this_width);
    // });


    // add an index to each cell, makes easier to reference later
    // var y = 0;
    // $table.find('tr').each(function(){
    
    //   var x = 0;
    //   $(this).find('td, th').each(function(){
    //     var $cell = $(this);
    //     $cell.attr('data-x', x);
    //     $cell.attr('data-y', y);

    //     var ratio = this.offsetWidth / this.scrollWidth;

    //     if(ratio < 0.9){ // we have overflow!
    //       console.log("overflow", this, this.offsetWidth, this.scrollWidth, ratio);
    //     } else {
    //       console.log(this, this.offsetWidth, this.scrollWidth, ratio);
    //     }
    //     x += 1;
    //   });
    //   y += 1;
    // });
    
    // $container.append($table);
    // console.log($container, $table.after());
    // $table.after($container);
    // $table.remove();
  });
})(jQuery);
</script>

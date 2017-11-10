<div id="scroll-nav">
  <div class="row">
    <div class="col-xl-3 col-sm-4 col-xs-16">
      <#include "${full_templates_path}/components/hamburgur.ftl" />
      <#include "${full_templates_path}/components/logo.ftl" />
    </div>
    <div class="col-xl-13 col-sm-12 col-xs-16">
    </div>
  </div>
  
</div>


<header id="main-header" role="banner">
  <nav class="nav-row-one row">
    <div class="left col-xl-13 col-sm-12 col-xs-8">
      <div class="side-nav-trigger">
        <#include "${full_templates_path}/components/hamburgur.ftl" />
      </div>

      <#include "${full_templates_path}/components/logo.ftl" />
    </div>
    
    <div class="right col-xl-3 col-sm-4 col-xs-8">
      <#include "${full_templates_path}/components/search_widget.ftl" />
    </div>
  </nav>

  <nav class="nav-row-two row">
    <div class="main-nav-links col-xl-16">
      <#include "${full_templates_path}/components/site_pages.ftl" />
    </div>
  </nav>

</header>

<script>
$(document).ready(function(){
  $('.search-widget-field').focus(function(){
    $(this).parent().find('.search-placeholder-text').fadeOut();
  });

  $('.search-widget-field').blur(function(){
    if($(this).val().trim() === ''){
      $(this).parent().find('.search-placeholder-text').fadeIn();
    }
  });

  $('.search-widget-decorators .search-icon').on('click', function (e) {
    console.log('site-search-button click');
    e.preventDefault();
    var value = $(this).parent().parent().find('.search-widget-field').val();
    document.location = "/search?q=" + escape(value);
  });

  $('.search-widget-field').on('keypress', function (e) {
    console.log('site-search-input keypress');
    var p = e.which;
    if (p == 13) {
      document.location = "/search?q=" + escape($(this).val());
      $(this).blur();
    }
  });
});
</script>

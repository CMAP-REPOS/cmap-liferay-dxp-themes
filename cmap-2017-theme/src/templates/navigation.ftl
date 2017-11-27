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

    <div class="left col-xl-13 col-lg-12 col-md-11 col-sm-8">
      <div class="side-nav-trigger">
        <#include "${full_templates_path}/components/hamburgur.ftl" />
      </div>
      <#include "${full_templates_path}/components/logo.ftl" />
    </div>
    
    <div class="right col-xl-3 col-lg-4 col-md-5 col-sm-8">
      <#include "${full_templates_path}/components/search_widget.ftl" />
    </div>

  </nav>

  <nav class="nav-row-two row">
    <div class="main-nav-links col-xl-16">
      <#include "${full_templates_path}/components/site_pages.ftl" />
    </div>
  </nav>

</header>

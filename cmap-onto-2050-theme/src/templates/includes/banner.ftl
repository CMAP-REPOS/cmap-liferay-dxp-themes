<header id="banner" class="container-fluid">
  <#include "${full_templates_path}/includes/header.ftl" />
  <nav class="${nav_css_class}" id="navigation" role="navigation">
    <div class="row">
      <div class="col-lg-12 col-md-16">
        <div class="hide-accessible"><@liferay.language key="navigation" /></div>
        <ul aria-label="<@liferay.language key="site-pages" />" role="menubar" class="site-nav list-inline list-unstyled">
          <li>
            <a href="/2050/about" role="menuitem">
            	<span>About the Plan</span>
            </a>
          </li>
          <li>
            <a href="/2050/principles" role="menuitem">
            	<span>Principles</span>
            </a>
          </li>
          <li>
            <a href="/2050/our-region-today" role="menuitem">
            	<span>Our Region Today</span>
            </a>
          </li>
          <li>
            <a href="/2050/chapters" role="menuitem">
            	<span>Chapters</span>
            </a>
          </li>
          <li>
            <a href="/2050/resources" role="menuitem">
            	<span>Resources</span>
            </a>
          </li>
          <li>
            <a href="/2050/implementing-the-plan" role="menuitem">
            	<span>Implementing the Plan</span>
            </a>
          </li>
        </ul>
      </div>
      <div class="col-lg-4 hidden-md">
        <a class="return-to-cmap" href="/" role="menuitem">
          <span> Back to CMAP.gov </span>
        </a>
      </div>
    </div>
  </nav>
  <#include "${full_templates_path}/includes/scroll_nav.ftl" />
</header>

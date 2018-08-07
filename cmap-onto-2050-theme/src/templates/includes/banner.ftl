<header id="banner" class="container-fluid">
  <#include "${full_templates_path}/includes/header.ftl" />
  <nav class="${nav_css_class}" id="navigation" role="navigation">
    <div class="row">
      <div class="col-lg-12 col-md-16">
        <div class="hide-accessible"><@liferay.language key="navigation" /></div>
        <ul aria-label="<@liferay.language key="site-pages" />" role="menubar" class="site-nav list-inline list-unstyled">
          <li>
            <a href="/on-to-2050/about-the-plan/" role="menuitem"><span> About the Plan </span></a>
          </li>
          <li>
            <a href="/on-to-2050/introduction/" role="menuitem"><span> Introduction </span></a>
          </li>
          <li>
            <a href="/on-to-2050/principles/" role="menuitem"><span> Principles </span></a>
          </li>
          <li>
            <a href="/on-to-2050/topics/" role="menuitem"><span> Topics </span></a>
          </li>
          <li>
            <a href="/on-to-2050/resources/" role="menuitem"><span> Resources </span></a>
          </li>
          <li>
            <a href="/on-to-2050/implementing-the-plan/" role="menuitem"><span> Implementing the Plan </span></a>
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

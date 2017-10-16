<div id="scroll-nav">
  <button class="hamburger hamburger--elastic" type="button">
    <span class="hamburger-box">
      <span class="hamburger-inner"></span>
    </span>
  </button>

  <div class="logo custom-logo">
    <h1 class="site-title">
      <a href="http://74.82.140.34/web/guest" title="Go to CMAP">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"> <title>CMAP Logo Icon</title> <g fill="none" fill-rule="evenodd"> <path fill="#008FD5" d="M8.702,0.269 L17.404,0.269 L17.404,11.871 C12.018,11.736 8.702,6.363 8.702,0.269"/> <path fill="#6DAE4E" d="M0,0.269 L0,0.269 L0,17.673 L17.404,17.673 L17.404,14.508 C12.018,14.341 7.459,7.789 7.459,0.269 L0,0.269 Z"/> </g> </svg>
        <span class="site-name" title="Go to CMAP"> CMAP </span>
      </a>
    </h1>
  </div>
</div>

<header id="main-header" role="banner">
  <nav class="nav-row-one row">
    <div class="left col-xl-12 col-sm-10 col-xs-8">
      <div class="side-nav-trigger">
        <button class="hamburger hamburger--elastic" type="button">
          <span class="hamburger-box">
            <span class="hamburger-inner"></span>
          </span>
        </button>
      </div>
      <div class="logo custom-logo">
        <h1 class="site-title">
          <a href="http://74.82.140.34/web/guest" title="Go to CMAP">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"> <title>CMAP Logo Icon</title> <g fill="none" fill-rule="evenodd"> <path fill="#008FD5" d="M8.702,0.269 L17.404,0.269 L17.404,11.871 C12.018,11.736 8.702,6.363 8.702,0.269"/> <path fill="#6DAE4E" d="M0,0.269 L0,0.269 L0,17.673 L17.404,17.673 L17.404,14.508 C12.018,14.341 7.459,7.789 7.459,0.269 L0,0.269 Z"/> </g> </svg>
            <span class="site-name" title="Go to CMAP"> CMAP </span>
          </a>
        </h1>
      </div>
    </div>

    <div class="right col-xl-4 col-sm-6 col-xs-8">
      <div class="search-widget">
        <span class="search-widget-decorators">
          <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 19 19" width="19" height="19"> <path stroke="#3C5976" stroke-width="2" fill="none" d="M11.5,11.5c1-1,1.6-2.4,1.6-3.9c0-3.1-2.5-5.6-5.6-5.6S2,4.5,2,7.6c0,3.1,2.5,5.6,5.6,5.6 C9.1,13.2,10.5,12.5,11.5,11.5L18,18L11.5,11.5z"/> </svg>
          <span class="search-placeholder-text">Search</span>
        </span>
        <input class="search-widget-field" type="text" aria-describedby="site-search-addon">
      </div>
    </div>
  </nav>

  <nav class="nav-row-two row">
    <div class="main-nav-links col-xl-16">
      <ul aria-label="Site Pages" role="menubar">
        <li role="presentation">
          <a href="/onto2050" role="menuitem"><span> ON TO 2050 </span></a>
        </li>
        <li role="presentation">
          <a href="/about" role="menuitem"><span> About CMAP </span></a>
        </li>
        <li role="presentation">
          <a href="/programs-and-resources" role="menuitem"><span> Programs &amp; Resources </span></a>
        </li>
        <li role="presentation">
          <a href="/about/involvement/committees" role="menuitem"><span> Committees </span></a>
        </li>
        <li role="presentation">
          <a href="/data" role="menuitem"><span> Data &amp; Analysis </span></a>
        </li>
        <li role="presentation">
          <a href="/about/updates" role="menuitem"><span> Updates &amp; News </span></a>
        </li>
        <li role="presentation">
          <a href="/contact-us" role="menuitem"><span> Contact Us </span></a>
        </li>
      </ul>
    </div>
  </nav>

</header>

<script>
$(document).ready(function(){
  $('.search-widget-field').focus(function(){
    $(this).parent().find('.search-placeholder-text').fadeOut();
  });
  $('.search-widget-field').blur(function(){
    $(this).parent().find('.search-placeholder-text').fadeIn();
  });
});
</script>

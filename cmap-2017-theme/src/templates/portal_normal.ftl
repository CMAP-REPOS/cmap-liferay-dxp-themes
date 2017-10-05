<!DOCTYPE html>

<#include init />

<html class="${root_css_class}" dir="<@liferay.language key=" lang.dir " />" lang="${w3c_language_id}">

<head>
	<title>${the_title} - ${company_name}</title>

	<meta content="initial-scale=1.0, width=device-width" name="viewport" />

	<link rel="stylesheet" type="text/css" href="https://cloud.typography.com/7363556/6800792/css/fonts.css" />
    <link href="https://cloud.webtype.com/css/2f300d46-99ee-4656-bf09-870688012aaf.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="https://cloud.typography.com/7947314/7427752/css/fonts.css" />

	<@liferay_util["include"] page=top_head_include />
</head>

<body class="${css_class}">

	<script>
		var pageClassName = window.location.pathname.replace(/\//g,'-').substring(1);
		if(pageClassName === ''){
			pageClassName = 'home-page'
		} else {
			pageClassName=pageClassName+'-page';
		}
		document.body.className += ' '+pageClassName;
	</script>

	<div id="viewport">
		<@liferay_ui["quick-access"] contentId="#main-content" />

		<@liferay_util["include"] page=body_top_include />

		<@liferay.control_menu />

		<div id="side-nav">
			<div class="logo custom-logo">
				<h1 class="site-title">
		      <a href="http://74.82.140.34/web/guest" title="Go to CMAP">
		        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"> <title>CMAP Logo Icon</title> <g fill="none" fill-rule="evenodd"> <path fill="#008FD5" d="M8.702,0.269 L17.404,0.269 L17.404,11.871 C12.018,11.736 8.702,6.363 8.702,0.269"/> <path fill="#6DAE4E" d="M0,0.269 L0,0.269 L0,17.673 L17.404,17.673 L17.404,14.508 C12.018,14.341 7.459,7.789 7.459,0.269 L0,0.269 Z"/> </g> </svg>
		        <span class="site-name" title="Go to CMAP"> CMAP </span>
		      </a>
		    </h1>
			</div>

			<div class="side-nav-links">
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

			<div class="search-widget">
				<span class="search-widget-decorators">
		      <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 19 19" width="19" height="19"> <path stroke="#3C5976" stroke-width="2" fill="none" d="M11.5,11.5c1-1,1.6-2.4,1.6-3.9c0-3.1-2.5-5.6-5.6-5.6S2,4.5,2,7.6c0,3.1,2.5,5.6,5.6,5.6 C9.1,13.2,10.5,12.5,11.5,11.5L18,18L11.5,11.5z"/> </svg>
		      <span class="search-placeholder-text">Search</span>
				</span>
				<input class="search-widget-field" id="header-search-field" type="text" aria-describedby="site-search-addon">
			</div>

			<div class="change-text-size">
				<div class="option small-text active">
					<span>A</span>
				</div>
				<div class="option medium-text">
					<span>A</span>
				</div>
				<div class="option large-text">
					<span>A</span>
				</div>
			</div>
		</div>

		<div id="wrapper">

			<#if has_navigation && is_setup_complete>
				<#include "${full_templates_path}/navigation.ftl" />
			</#if>

			<section id="content">
				<h1 class="hide-accessible">${the_title}</h1>

				<nav id="breadcrumbs">
					<#-- makes sure that the breadcrumbs are full-width by default -->
					<#assign VOID=freeMarkerPortletPreferences.setValue( "portletSetupPortletDecoratorId", "full-width-content")>
					<@liferay.breadcrumbs default_preferences="${freeMarkerPortletPreferences}" />
					<#assign VOID=freeMarkerPortletPreferences.reset() />
				</nav>

				<#if selectable>
					<@liferay_util["include"] page=content_include />
				<#else>
					${portletDisplay.recycle()} ${portletDisplay.setTitle(the_title)}
					<@liferay_theme["wrap-portlet"] page="portlet.ftl">
						<@liferay_util["include"] page=content_include />
					</@>
				</#if>

			</section>

			<#include "${full_templates_path}/footer.ftl" />
		</div>
	</div>

	<@liferay_util["include"] page=body_bottom_include />
	<@liferay_util["include"] page=bottom_include />

	<!-- inject:js -->
	<script src="${javascript_folder}/vendor/modernizr.min.js" type="text/javascript"></script>
	<script src="https://s7.addthis.com/js/300/addthis_widget.js#async=1" type="text/javascript"></script>
	<!-- endinject -->

	<script type="text/javascript">
	  var _gauges = _gauges || [];
	  (function() {
	    var t   = document.createElement('script');
	    t.type  = 'text/javascript';
	    t.async = true;
	    t.id    = 'gauges-tracker';
	    t.setAttribute('data-site-id', '59d253f87218b5093901d989');
	    t.setAttribute('data-track-path', 'https://track.gaug.es/track.gif');
	    t.src = 'https://d36ee2fcip1434.cloudfront.net/track.js';
	    var s = document.getElementsByTagName('script')[0];
	    s.parentNode.insertBefore(t, s);
	  })();
	</script>
</body>

</html>

<!DOCTYPE html>

<#include init />

<html class="${root_css_class}" dir="<@liferay.language key=" lang.dir " />" lang="${w3c_language_id}">

<head>
	<title>${the_title} - ${company_name}</title>

	<!-- Google Tag Manager -->
	<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
	new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
	j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
	'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
	})(window,document,'script','dataLayer','GTM-NLF8Z5B');</script>
	<!-- End Google Tag Manager -->

	<meta content="initial-scale=1.0, width=device-width" name="viewport" />
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
	<link rel="icon" href="/favicon.ico" type="image/x-icon">

	<#assign currentUrl = theme_display.getURLPortal() + themeDisplay.getURLCurrent() />
	<link rel="canonical" href="${currentUrl}" />

	<#if currentUrl?contains("asset_publisher_web_portlet")>
		<meta name="robots" content="noindex">
	</#if>

  <link href="https://cloud.webtype.com/css/2f300d46-99ee-4656-bf09-870688012aaf.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" type="text/css" href="https://cloud.typography.com/7947314/7427752/css/fonts.css" />

	<@liferay_util["include"] page=top_head_include />
</head>

<body class="${css_class} cmap-2017-theme">

	<!-- Google Tag Manager (noscript) -->
	<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NLF8Z5B"
	height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
	<!-- End Google Tag Manager (noscript) -->	

	<@liferay_ui["quick-access"] contentId="#main-content" />

	<@liferay_util["include"] page=body_top_include />

	<@liferay.control_menu />

	<#include "${full_templates_path}/side_nav.ftl" />

	<div id="wrapper">

		<#if has_navigation && is_setup_complete>
			<#include "${full_templates_path}/navigation.ftl" />
		</#if>

		<section id="content">

			<#if currentUrl == '/' ||
				currentUrl == '/home' ||
				currentUrl == '/home/' ||
				currentUrl == '/web/guest' ||
				currentUrl == '/web/guest/' >
			<#else>

			<nav id="breadcrumbs">
				<#-- makes sure that the breadcrumbs are full-width by default -->
				<#assign VOID=freeMarkerPortletPreferences.setValue( "portletSetupPortletDecoratorId", "full-width-content")>
				<@liferay.breadcrumbs default_preferences="${freeMarkerPortletPreferences}" />
				<#assign VOID=freeMarkerPortletPreferences.reset() />


			</nav>
			</#if>

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

	<@liferay_util["include"] page=body_bottom_include />
	<@liferay_util["include"] page=bottom_include />

	<!-- inject:js -->
	<!-- <script src="${javascript_folder}/vendor/modernizr.min.js" type="text/javascript"></script> -->
	<script src="${javascript_folder}/custom.js" type="text/javascript"></script>
	<#-- <script src="${javascript_folder}/main.js" type="text/javascript"></script> -->

	<!-- Analytics -->
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
	<!-- endinject -->

	<!-- TRACER -->
	<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5a0c6f5e0a5ca918"></script>

</body>

</html>

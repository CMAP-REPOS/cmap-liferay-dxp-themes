<!DOCTYPE html>

<#include init />

<html class="${root_css_class}" dir="<@liferay.language key="lang.dir" />" lang="${w3c_language_id}">

<head>
	<title>${the_title} - ${company_name}</title>

	<meta content="initial-scale=1.0, width=device-width" name="viewport" />

	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
	<link rel="icon" href="/favicon.ico" type="image/x-icon">

	<meta property="og:site_name" content="${site_name}" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="${the_title}" />
	<meta property="og:description" content="${themeDisplay.getLayout().getDescriptionCurrentValue()}" />
	<meta property="og:image" content="${themeDisplay.getPathThemeImages()}/onto2050-social.png" />
	<meta property="og:url" content="${themeDisplay.getPortalURL()}${themeDisplay.getURLCurrent()}" />
	<meta name="twitter:card" content="summary_large_image">
	<meta name="twitter:title" content="${the_title}">
	<meta name="twitter:description" content="${themeDisplay.getLayout().getDescriptionCurrentValue()}">
	<meta name="twitter:image" content="${themeDisplay.getPathThemeImages()}/onto2050-social.png">

	<link rel="canonical" href="${themeDisplay.getPortalURL()}${themeDisplay.getURLCurrent()}" />

	<@liferay_util["include"] page=top_head_include />

	<link href="https://cloud.webtype.com/css/2f300d46-99ee-4656-bf09-870688012aaf.css" rel="stylesheet" type="text/css" />
	<!-- Clark -->
	<!--  <link rel="stylesheet" type="text/css" href="https://cloud.typography.com/7363556/6800792/css/fonts.css" />  -->
	<!-- CMAP -->
  <link rel="stylesheet" type="text/css" href="https://cloud.typography.com/7947314/7427752/css/fonts.css" />
</head>

<body class="${css_class} cmap-2019-theme">

<a class="skip-to-content" href="#main-content" tabindex="0">Skip to Content</a>

<@liferay_util["include"] page=body_top_include />

<@liferay.control_menu />

<div id="wrapper">

	<#include "${full_templates_path}/includes/banner.ftl" />

	<section id="content">
	
		<nav id="breadcrumbs">
		<@liferay_portlet["runtime"]
				defaultPreferences=""
				portletProviderAction=portletProviderAction.VIEW
				portletProviderClassName="com.liferay.portal.kernel.servlet.taglib.ui.BreadcrumbEntry"
			/>
		</nav>

		<#if selectable>
			<@liferay_util["include"] page=content_include />
		<#else>

			${portletDisplay.recycle()}
			${portletDisplay.setTitle(the_title)}

			<@liferay_theme["wrap-portlet"] page="portlet.ftl">
				<@liferay_util["include"] page=content_include />
			</@>
		</#if>
	</section>

	<#include "${full_templates_path}/footer.ftl" />
</div>

<#include "${full_templates_path}/includes/mobile_nav.ftl" />

<@liferay_util["include"] page=body_bottom_include />

<@liferay_util["include"] page=bottom_include />

<!-- inject:js -->
<!-- endinject -->

<script type="text/javascript">
  var _gauges = _gauges || [];
  (function() {
    var t   = document.createElement('script');
    t.type  = 'text/javascript';
    t.async = true;
    t.id    = 'gauges-tracker';
    t.setAttribute('data-site-id', '5b6200d80d10f35b5de337ff');
    t.setAttribute('data-track-path', 'https://track.gaug.es/track.gif');
    t.src = 'https://d2fuc4clr7gvcn.cloudfront.net/track.js';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(t, s);
  })();
</script>

</body>

</html>

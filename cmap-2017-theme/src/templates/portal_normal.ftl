<!DOCTYPE html>

<#include init />

<html class="${root_css_class}" dir="<@liferay.language key=" lang.dir " />" lang="${w3c_language_id}">

<head>
	<title>${the_title} - ${company_name}</title>

	<meta content="initial-scale=1.0, width=device-width" name="viewport" />

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


	<@liferay_ui["quick-access"] contentId="#main-content" />

	<@liferay_util["include"] page=body_top_include />

	<@liferay.control_menu />

	<#include "${full_templates_path}/side_nav.ftl" />

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

	<@liferay_util["include"] page=body_bottom_include />
	<@liferay_util["include"] page=bottom_include />

	<!-- inject:js -->
	<script src="${javascript_folder}/vendor/modernizr.min.js" type="text/javascript"></script>
	<script src="${javascript_folder}/custom.js" type="text/javascript"></script>
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

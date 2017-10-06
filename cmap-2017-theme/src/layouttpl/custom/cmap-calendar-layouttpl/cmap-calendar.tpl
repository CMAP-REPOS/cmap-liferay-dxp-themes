<!--
https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/liferay-themedisplay
<p>getPathThemeRoot: $themeDisplay.getPathThemeRoot()</p>
<p>getPathThemeTemplates: $themeDisplay.getPathThemeTemplates()</p>
<p>getPathThemeJavaScript: $themeDisplay.getPathThemeJavaScript()</p>
<p>getPathThemeCss: $themeDisplay.getPathThemeCss()</p>
<p>getPathThemeImages: $themeDisplay.getPathThemeImages()</p>
 -->

<script>
    define._amd = define.amd;
    define.amd = false;
</script>

<!-- https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/using-external-libraries -->
<script type="text/javascript" src="$themeDisplay.getPathThemeJavaScript()/vendor/arrive.min.js"></script>
<script type="text/javascript" src="$themeDisplay.getPathThemeJavaScript()/calendar.js"></script>

<script>
    define.amd = define._amd;
</script>

<div class="cmap-calendar-layout" id="main-content" role="main">
	<div class="portlet-layout">
		<div class="portlet-column portlet-column-only" id="column-1">
			$processor.processColumn("column-1", "portlet-column-content portlet-column-content-only")
		</div>
	</div>
</div>

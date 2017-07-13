<!-- 
<p>getPathThemeRoot: $themeDisplay.getPathThemeRoot()</p>
<p>getPathThemeTemplates: $themeDisplay.getPathThemeTemplates()</p>
<p>getPathThemeJavaScript: $themeDisplay.getPathThemeJavaScript()</p>
<p>getPathThemeCss: $themeDisplay.getPathThemeCss()</p>
<p>getPathThemeImages: $themeDisplay.getPathThemeImages()</p>
 -->

<script type="text/javascript"
	src="$themeDisplay.getPathThemeRoot()/vendor/leaflet/leaflet.js"></script>
<script src='https://api.mapbox.com/mapbox.js/v3.0.1/mapbox.js'></script>

<link rel="stylesheet"
	href="$themeDisplay.getPathThemeRoot()/vendor/leaflet/leaflet.css" />
<link rel="stylesheet"
	href="https://api.mapbox.com/mapbox.js/v3.0.1/mapbox.css" />

<div class="storymap" id="main-content" role="main">
	<div class="portlet-layout row">
		<div class="col-md-12 portlet-column portlet-column-only"
			id="column-1">$processor.processColumn("column-1",
			"portlet-column-content portlet-column-content-only")</div>
	</div>
</div>

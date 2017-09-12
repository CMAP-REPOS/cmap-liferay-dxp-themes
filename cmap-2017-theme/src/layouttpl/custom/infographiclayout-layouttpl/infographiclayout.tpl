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
<script type="text/javascript" src="$themeDisplay.getPathThemeJavaScript()/vendor/d3.min.js"></script>
<script type="text/javascript" src="$themeDisplay.getPathThemeJavaScript()/vendor/c3.min.js"></script>
<script type="text/javascript" src="$themeDisplay.getPathThemeJavaScript()/infographics.js"></script>
    
<script>
    define.amd = define._amd;
</script>

<link rel="stylesheet"
	href="$themeDisplay.getPathThemeCss()/vendor/c3.min.css" />

<div class="infographiclayout" id="main-content" role="main">
	<div class="portlet-layout row">
		<div class="col-md-16 portlet-column portlet-column-only">
			<nav class="infographic-nav clearfix">
			    <div class="col-xs-13 col-sm-offset-1">
			    $layout.getName($locale)
			    </div>
			    <div class="col-sm-2 share hidden-xs">
		        	<a data-toggle="popover" data-content="<div id='social-bookmarks-container'></div>" data-placement="bottom" title="Share">
		        		<span class="icon-share"></span> Share</a>
					<div class="share-wrapper"></div>
			    </div>
			</nav>
		</div>
	</div>
	<div class="portlet-layout row">
		<div class="col-md-16 portlet-column portlet-column-only"
			id="column-1">$processor.processColumn("column-1",
			"portlet-column-content portlet-column-content-only")</div>
	</div>
</div>

<!-- 
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

<!-- 
workaround to include external libraries that are defined as modules but should not be picked up by Liferay AMD Loader
https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/using-external-libraries
 -->

<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script> -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.js"></script>
<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script> -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.js"></script>
    
<script>
    define.amd = define._amd;
</script>

<link rel="stylesheet"
	href="$themeDisplay.getPathThemeCss()/vendor/c3.min.css" />
	
<div class="infographic" id="main-content" role="main">
	<div class="infographic-nav">
		<div class="vertical-centered grid-align">
			<div class="middle">
				<div class="infospacer"></div>
				<div class="pageTitle">$layout.getName()</div>
			</div>
			<div id="shareModule" class="right-button">
				<div class="share-this-block">
					<label for="share-this-toggle" id="share-this-label" class="share">
						<span class="icon icon-share-light"></span>Share
					</label>
					<div class="share-wrapper drilldown"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="portlet-layout row">
		<div class="col-md-12 portlet-column portlet-column-only"
			id="column-1">$processor.processColumn("column-1",
			"portlet-column-content portlet-column-content-only")</div>
	</div>
</div>

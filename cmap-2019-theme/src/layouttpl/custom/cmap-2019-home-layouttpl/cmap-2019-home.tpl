<script>
    define._amd = define.amd;
    define.amd = false;
</script>

<!-- https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/using-external-libraries -->
<script type="text/javascript" src="$themeDisplay.getPathThemeJavaScript()/vendor/d3.min.js"></script>
<script type="text/javascript" src="$themeDisplay.getPathThemeJavaScript()/vendor/c3.min.js"></script>
<script type="text/javascript"
 src="$themeDisplay.getPathThemeJavaScript()/infographics.js"></script>
<script type="text/javascript" src="https://unpkg.com/imagesloaded@4/imagesloaded.pkgd.min.js"></script>

<script>
    define.amd = define._amd;
</script>

<div class="container-fluid cmap-2019-main-content" id="main-content" role="main">
	<div class="portlet-layout row row-with-padding">
		<div class="no-padding col-md-13 col-sm-16 portlet-column portlet-column-first" id="column-1">
			$processor.processColumn("column-1", "portlet-column-content portlet-column-content-first")
		</div>
		<div class="no-padding col-md-3 col-sm-16 portlet-column portlet-column-last" id="column-2">
			$processor.processColumn("column-2", "portlet-column-content portlet-column-content-last")
		</div>
	</div>

	<div class="portlet-layout row">
		<div class="no-padding col-md-16 col-sm-16 portlet-column portlet-column-only" id="column-3">
			$processor.processColumn("column-3", "portlet-column-content portlet-column-content-only")
		</div>
	</div>
	
	<div class="portlet-layout row">
		<div class="no-padding col-md-16 col-sm-16 portlet-column portlet-column-only" id="column-4">
			$processor.processColumn("column-4", "portlet-column-content portlet-column-content-only")
		</div>
	</div>

	<div class="portlet-layout row">
		<div class="no-padding col-md-16 col-sm-16 portlet-column portlet-column-only" id="column-5">
			$processor.processColumn("column-5", "portlet-column-content portlet-column-content-only")
		</div>
	</div>

	<div class="portlet-layout row">
		<div class="no-padding col-md-16 col-sm-16 portlet-column portlet-column-only" id="column-6">
			$processor.processColumn("column-6", "portlet-column-content portlet-column-content-only")
		</div>
	</div>

</div>

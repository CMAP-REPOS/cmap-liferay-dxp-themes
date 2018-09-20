<script>
    define._amd = define.amd;
    define.amd = false;
</script>

<!-- https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/using-external-libraries -->
<script type="text/javascript" src="$themeDisplay.getPathThemeJavaScript()/vendor/d3.min.js"></script>
<script type="text/javascript" src="$themeDisplay.getPathThemeJavaScript()/vendor/c3.min.js"></script>
<script type="text/javascript"
 src="$themeDisplay.getPathThemeJavaScript()/infographics.js"></script>

<script>
    define.amd = define._amd;
</script>

<div class="container-fluid" id="main-content" role="main">
	<div class="portlet-layout row">
		<div class="col-md-16 col-sm-16 portlet-column portlet-column-only" id="column-1">
			$processor.processColumn("column-1", "portlet-column-content portlet-column-content-only")
		</div>
	</div>
	<div class="portlet-layout row">
		<div class="col-lg-4 col-md-3 col-sm-16 portlet-column portlet-column-first" id="column-2">
			$processor.processColumn("column-2", "portlet-column-content portlet-column-content-first")
		</div>
		<div class="col-lg-8 col-md-10 col-sm-16 portlet-column" id="column-3">
			$processor.processColumn("column-3", "portlet-column-content")
		</div>
		<div class="col-lg-4 col-md-3 col-sm-16 portlet-column portlet-column-last" id="column-4">
			$processor.processColumn("column-4", "portlet-column-content portlet-column-content-last")
		</div>
	</div>
	<div class="portlet-layout row">
		<div class="col-md-16 col-sm-16 portlet-column portlet-column-only" id="column-5">
			$processor.processColumn("column-5", "portlet-column-content portlet-column-content-only")
		</div>
	</div>
	<div class="portlet-layout row">
		<div class="col-lg-4 col-md-3 col-sm-16 portlet-column portlet-column-first" id="column-6">
			$processor.processColumn("column-6", "portlet-column-content portlet-column-content-first")
		</div>
		<div class="col-lg-8 col-md-10 col-sm-16 portlet-column" id="column-7">
			$processor.processColumn("column-7", "portlet-column-content")
		</div>
		<div class="col-lg-4 col-md-3 col-sm-16 portlet-column portlet-column-last" id="column-8">
			$processor.processColumn("column-8", "portlet-column-content portlet-column-content-last")
		</div>
	</div>
	<div class="portlet-layout row">
		<div class="col-md-16 col-sm-16 portlet-column portlet-column-only" id="column-9">
			$processor.processColumn("column-9", "portlet-column-content portlet-column-content-only")
		</div>
	</div>
	<div class="portlet-layout row">
		<div class="col-lg-4 col-md-3 col-sm-16 portlet-column portlet-column-first" id="column-10">
			$processor.processColumn("column-10", "portlet-column-content portlet-column-content-first")
		</div>
		<div class="col-lg-8 col-md-10 col-sm-16 portlet-column" id="column-11">
			$processor.processColumn("column-11", "portlet-column-content")
		</div>
		<div class="col-lg-4 col-md-3 col-sm-16 portlet-column portlet-column-last" id="column-12">
			$processor.processColumn("column-12", "portlet-column-content portlet-column-content-last")
		</div>
	</div>
	<div class="portlet-layout row">
		<div class="col-md-16 col-sm-16 portlet-column portlet-column-only" id="column-13">
			$processor.processColumn("column-13", "portlet-column-content portlet-column-content-only")
		</div>
	</div>
</div>

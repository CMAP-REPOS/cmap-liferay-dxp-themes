<script>
    define._amd = define.amd;
    define.amd = false;
</script>

<script type="text/javascript" src="$themeDisplay.getPathThemeJavaScript()/vendor/jquery.watch.min.js"></script>
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

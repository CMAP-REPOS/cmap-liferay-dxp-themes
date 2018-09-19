<#assign colors = []>
<#assign classes = ["chart-graphic-2050", "${ChartType.getData()}"]>

<#if Description.getData()?? && Description.getData() != "">
	<#assign classes = classes + ["has_description"]>
</#if>

<#if getterUtil.getBoolean(Bars.DisplayHorizontally.getData())>
	<#assign classes = classes + ["horizontal"]>
</#if>

<#if MultiTypeColumnName.getData()?? && MultiTypeColumnName.getData() != "">
	<#assign classes = classes + ["${MultiTypeColumnName.getData()?lower_case}"]>
</#if>
	
<#if Colors.BarLineColor.getSiblings()?has_content>
	<#list Colors.BarLineColor.getSiblings() as cur_Color>
		<#assign color = cur_Color.getData()>
		<#assign colors = colors + [color]>
	</#list>
</#if>

<#if CustomHeight?? && CustomHeight.getData()?? && CustomHeight.getData() != "">
	<#assign chartHeight = CustomHeight.getData()>
<#else>
	<#assign chartHeight = "320">
</#if>

<#if Anchor.getData()?? && Anchor.getData() != "">
  <a id="${Anchor.getData()}"></a>
</#if>

<div class="chart-graphic-2050-container">
	<#if Description.getData()?? && Description.getData() != "">
	<div id="${randomNamespace}chart" style="height:${chartHeight}px" class="${classes?join(" ")}"></div>
	<div class="chart-graphic-2050-description-container">
		<div class="chart-graphic-2050-description">
		${Description.getData()}
		</div>
	</div>
	<#else>
	<div id="${randomNamespace}chart" style="height:${chartHeight}px" class="${classes?join(" ")}"></div>
	</#if>
</div>

<script type="text/javascript">

AUI().ready(

	function() {

	d3.csv('${File.getData()}', function (error, d) {

		var options = {
			d: d,
			chartId: '${randomNamespace}chart',
			chartType: '${ChartType.getData()}', 
			data_url: '${File.getData()}',
<#if getterUtil.getBoolean(Tooltip.DisplayTooltip.getData())>
			display_tooltip: true,
<#else>
			display_tooltip: false,
</#if> 
<#if getterUtil.getBoolean(Bars.DisplayHorizontally.getData())>
			display_horizontally: true,
<#else>
			display_horizontally: false,
</#if>
			bar_width_ratio: '${Bars.BarWidthRatio.getData()}',
<#if getterUtil.getBoolean(Axes.RotateXAxisLabel.getData())>
			rotate_x_axis_label: true,
<#else>
			rotate_x_axis_label: false,
</#if>
			axis_x_label_position: '${Axes.XAxisLabelPosition.getData()}',
			axis_x_label_text: '${Axes.XAxisLabel.getData()}',
			axis_x_padding: '${Axes.XPadding.getData()}',
			axis_y_label_position: '${Axes.YAxisLabelPosition.getData()}',
			axis_y_label_text: '${Axes.YAxisLabel.getData()}',
			axis_y_padding: '${Axes.YPadding.getData()}',
			axis_y_tick_format: '${Axes.YAxisNumberFormat.getData()}',
		<#if getterUtil.getBoolean(Axes.DisableXAxisLabelResizing.getData())>
			disableXAxisLabelResizing: true,
		<#else>
			disableXAxisLabelResizing: false,
		</#if>
		<#if getterUtil.getBoolean(Axes.DisableYAxisLabelResizing.getData())>
			disableYAxisLabelResizing: true,
		<#else>
			disableYAxisLabelResizing: false,
		</#if>

		<#if Colors.BarLineColor.getSiblings()?has_content>
			color_pattern: ['${colors?join("', '")}'],
		<#else>
			color_pattern: []
		</#if>
		};

	<#if ChartType.getData() == "area_stacked">
		var chartOptions = {};
		$.extend(options, chartOptions);
		infographics.generateAreaStacked(options);
	</#if>

	<#if ChartType.getData() == "bar_chart_grouped">
		var chartOptions = {};
		$.extend(options, chartOptions);
		infographics.generateBarGrouped(options);
	</#if>

	<#if ChartType.getData() == "bar_chart_stacked">
		var chartOptions = {};
		$.extend(options, chartOptions);
		console.log(options);
		infographics.generateBarStacked(options);
	</#if>

	<#if ChartType.getData() == "donut_chart">
		var chartOptions = {};
		$.extend(options, chartOptions);
		infographics.generateDonut(options);
		infographics.bindDonutLegendEvents({
			chartId: '${randomNamespace}chart'
		});
	</#if>

	<#if ChartType.getData() == "multi_line">
		var chartOptions = {};
		$.extend(options, chartOptions);
		infographics.generateMultiLine(options);
	</#if>

	<#if ChartType.getData() == "multi_line_area">
		var chartOptions = {
			altDataType: '${MultiTypeColumnName.getData()}'
		};
		$.extend(options, chartOptions);
		console.log(options);
		infographics.generateMultiLine(options);
	</#if>

	<#if ChartType.getData() == "multi_line_bar">
		var chartOptions = {
			altDataType: '${MultiTypeColumnName.getData()}'
		};
		$.extend(options, chartOptions);
		infographics.generateMultiLine(options);
	</#if>
		});	
	}
);
</script>
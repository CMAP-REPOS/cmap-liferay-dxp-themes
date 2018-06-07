<#if Anchor.getData()?? && Anchor.getData() != "">
  <a id="${Anchor.getData()}"></a>
</#if>

<div class="chart-graphic-2050-container">
    <#if Description.getData()?? && Description.getData() != "">
    <div id="${randomNamespace}chart" class="chart-graphic-2050 ${ChartType.getData()} has_description" ></div>
    <div class="chart-graphic-2050-description">
    ${Description.getData()}
    </div>
    <#else>
    <div id="${randomNamespace}chart" class="chart-graphic-2050 ${ChartType.getData()}" ></div>
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
<#if getterUtil.getBoolean(Axes.RotateYAxisLabel.getData())>
            rotate_y_axis_label: true,
<#else>
            rotate_y_axis_label: false,
</#if>
            axis_x_label_position: '${Axes.XAxisLabelPosition.getData()}',
            axis_x_label_text: '${Axes.XAxisLabel.getData()}',
            axis_x_padding: '${Axes.XPadding.getData()}',
            axis_x_tick_format: '${Axes.XAxisNumberFormat.getData()}',
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
            disableYAxisLabelResizing: true
        <#else>
            disableYAxisLabelResizing: false
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
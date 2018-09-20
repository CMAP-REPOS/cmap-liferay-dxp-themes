<#include "${templatesPath}/848954">

<#assign anchor = validate_field(Anchor.getData())>
<#assign description = validate_field(Description.getData())>

<#if Description.getData()?? && Description.getData() != "">
<div style="float: left; width: 75%">
  <div id="${randomNamespace}chart"></div>
</div>
<div style="float: right; width: 25%">
${Description.getData()}
</div>
<#else>

<div id="${randomNamespace}chart"></div>
</#if>

<script type="text/javascript">

AUI().ready(

	function() {

    d3.csv('${File.getData()}', function (error, d) {

        var options = {
            d: d,
            chartId: '${randomNamespace}chart',
            chartType: '${ChartType.getData()}',
            data_url: '${File.getData()}',
            axis_x_label_text: '${Axes.XAxisLabel.getData()}',
            axis_x_padding: '${Axes.XPadding.getData()}',
            axis_x_tick_format: '${Axes.XAxisNumberFormat.getData()}',
            axis_y_label_position: 'outer-top',
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
        console.log(options);
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
            altDataType: '${MultiTypeColumnName.getData()}',
            axis_x_padding_left: 0,
        };
        $.extend(options, chartOptions);
        infographics.generateMultiLine(options);
    </#if>

    <#if ChartType.getData() == "donut_chart">
        infographics.bindDonutLegendEvents({
            chartId: '${randomNamespace}chart'
        });
    </#if>

        infographics.bindEvents();
    });

    $('.infographic-info-toggle').on('click', function(e) {
        e.preventDefault();
        $('.main-info').toggleClass('hide-desc');
        $('.aside-container').toggleClass('show');
    });
	}
);

</script>

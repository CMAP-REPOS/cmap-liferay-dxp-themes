<#assign colors = []>
<#assign keyArray = []>
<#assign classes = ["chart-graphic-2050", "${ChartType.getData()}"]>

<#if Description.getData()?? && Description.getData() != "">
    <#assign classes = classes + ["has_description"]>
</#if>

<#if getterUtil.getBoolean(Bars.DisplayHorizontally.getData())>
    <#assign classes = classes + ["horizontal"]>
</#if>
	
<#if Colors.BarLineColor.getSiblings()?has_content>
	<#list Colors.BarLineColor.getSiblings() as cur_Color>
	    <#assign color = cur_Color.getData()>
	    <#assign colors = colors + [color]>
	</#list>
</#if>

<#if Anchor.getData()?? && Anchor.getData() != "">
  <a id="${Anchor.getData()}"></a>
</#if>

<#list KeyItem.getSiblings() as cur_KeyItem>
  <#assign keyName = "">
  <#assign keyImageUrl = "">
  <#assign keyImageAlt = "">

  <#if cur_KeyItem.KeyItemName.getData() ?? && cur_KeyItem.KeyItemName.getData() != "">
    <#assign keyName = cur_KeyItem.KeyItemName.getData()>
  </#if>

  <#if cur_KeyItem.KeyItemImage.getData() ?? && cur_KeyItem.KeyItemImage.getData() != "">
    <#assign keyImageUrl = cur_KeyItem.KeyItemImage.getData()>
  </#if>

  <#if cur_KeyItem.KeyItemImage.getAttribute("alt") ?? && cur_KeyItem.KeyItemImage.getAttribute("alt") != "">
    <#assign keyImageAlt = cur_KeyItem.KeyItemImage.getAttribute("alt")>
  </#if>

  <#if keyName != "">
    <#assign keyArray = keyArray + [{
      "keyName": keyName,
      "keyImageUrl": keyImageUrl,
      "keyImageAlt": keyImageAlt
    }]>
  </#if>
</#list>


<#-- Freemarker can report false positives for list content, so create a custom key array -->


<div class="chart-graphic-2050-container">
    <#if Description.getData()?? && Description.getData() != "">
    <div id="${randomNamespace}chart" class="${classes?join(" ")}"></div>
    <div class="chart-graphic-2050-description-container">
        <div class="chart-graphic-2050-description">
        ${Description.getData()}
        </div>
    </div>
    <#else>
    <div id="${randomNamespace}chart" class="${classes?join(" ")}"></div>
    </#if>
</div>

<div class="chart-legend-2050">
    <#--
    <div class="chart-legend-2050-title">
    ${Title.getData()}
    </div>
    -->
  <#if Description.getData()?has_content && Description.getData() != "">
    <div class="chart-legend-2050-description">
      <p><strong>Chart</strong></p>
      ${Description.getData()}
    </div>
  </#if>
    
  <#if keyArray?size != 0>
    <div class="chart-legend-2050-key">
      <p><strong>Key</strong></p>
      <ul class="list-unstyled chart-legend-2050-key-list">
        <#list keyArray as key>
          <li>
            <img alt="${key.keyImageAlt}" src="${key.keyImageUrl}" />
            ${key.keyName}
          </li>
        </#list>
      </ul>
    </div>
  </#if>

  <#if Source.getData()?has_content && Source.getData() != "">
    <div class="chart-legend-2050-source">
      <p><strong>Source</strong></p>
      ${Source.getData()}
    </div>
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
        bar_width_ratio: '${Bars.BarWidthRatio.getData()}',
        axis_x_label_position: '${Axes.XAxisLabelPosition.getData()}',
        axis_x_label_text: '${Axes.XAxisLabel.getData()}',
        axis_x_padding: '${Axes.XPadding.getData()}',
        axis_y_label_position: '${Axes.YAxisLabelPosition.getData()}',
        axis_y_label_text: '${Axes.YAxisLabel.getData()}',
        axis_y_padding: '${Axes.YPadding.getData()}',
        axis_y_tick_format: '${Axes.YAxisNumberFormat.getData()}',

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
        <#if getterUtil.getBoolean(Axes.RotateXAxisLabel.getData())>
          rotate_x_axis_label: true,
        <#else>
          rotate_x_axis_label: false,
        </#if>
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
          color_pattern: [],
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



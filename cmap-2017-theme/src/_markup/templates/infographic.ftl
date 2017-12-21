<section class="infographic-content clearfix">
    <div class="">
        <section class="infographic-info ${randomNamespace}chart-info row">
            <a href="#" class="infographic-info-toggle visible-xs-block"><span class="icon-info-sign"></span> <span class="sr-only">Toggle Chart Info</span></a>
            <div class="">
                <div class="main-info col-sm-16 col-sm-offset-0 col-md-10 col-lg-11 col-xl-12 col-xl-offset-1">
                    <div class="infographic-title">
                        ${Title.getData()}
                    </div>
                    <div class="infographic-description">
                        ${Info.getData()}
                    </div>
                </div>
                <div class="aside-container col-sm-16 col-sm-offset-0 col-md-5 col-lg-4 col-xl-3">
                    <div class="infographic-aside">
                        ${Aside.getData()}
                    </div>
                    <div class="infographic-source">
                        ${Source.getData()}
                    </div>
                </div>
                <#if ChartType.getData() == "area_stacked">
                <div class="infographic-buttons col-sm-16 col-sm-offset-0 col-xl-15 col-xl-offset-1">
                    <#if ToggledItem.getSiblings()?has_content>
                    	<#list ToggledItem.getSiblings() as cur_ToggledItem>
                    		<button id="infographic-button${cur_ToggledItem?index}" class="infographic-button">
                    		    <span>${cur_ToggledItem.ToggledItemLabel.getData()}</span>
                    		    <span class="pair-icons"> <span class="icon icon-paragraphh-white"></span> <span class="icon icon-close-white"></span> </span>
                    		</button>
                    	</#list>
                    </#if>
                </div>
                </#if>
            </div>
        </section>
                
        <#if ChartType.getData() == "donut_chart">
        <div class="donut-flex">
        </#if>
        <section id="${randomNamespace}chart" class="infographic-chart ${ChartType.getData()}">
        </section>
        <section class="infographic-legend ${randomNamespace}chart-legend">
            <div class="legend-data col-xl-16 col-xl-offset-2 col-xs-offset-1">
            </div>
            <div class="mobile-legend-icons">
                <span class="icon icon-paragraphh-white"></span><span class="icon icon-key-white activated"></span>
            </div>
        </section>
        <#if ChartType.getData() == "donut_chart">
        </div>
        </#if>
        
        <div class="side-narratives col-xs-12 col-xs-offset-1">
        <#if ToggledItem.getSiblings()?has_content>
            <#list ToggledItem.getSiblings() as cur_ToggledItem>
                <div id="side-narrative${cur_ToggledItem?index}">${cur_ToggledItem.ToggledItemContent.getData()}</div>
            </#list>
        </#if>
        </div>
    </div>
    <div class="col-sm-2">
    </div>
</section>

<script type="text/javascript">
    /*
    var chartID = '${randomNamespace}chart';
	<#if getterUtil.getBoolean(DisableXAxisLabelResizing.getData())>
            var disableXAxisLabelResizing = true;
        <#else>
            var disableXAxisLabelResizing = false;
        </#if>

        <#if getterUtil.getBoolean(DisableYAxisLabelResizing.getData())>
            var disableYAxisLabelResizing = true;
        <#else>
            var disableYAxisLabelResizing = false;
        </#if>
    */

AUI().ready(

	function() {

        d3.csv('${File.getData()}', function (error, d) {
        <#if getterUtil.getBoolean(DisableXAxisLabelResizing.getData())>
            var disableXAxisLabelResizing = true;
        <#else>
            var disableXAxisLabelResizing = false;
        </#if>

        <#if getterUtil.getBoolean(DisableYAxisLabelResizing.getData())>
            var disableYAxisLabelResizing = true;
        <#else>
            var disableYAxisLabelResizing = false;
        </#if>

            var options = {
                d: d,
                chartId: '${randomNamespace}chart',
                chartType: '${ChartType.getData()}', 
                data_url: '${File.getData()}',
                axis_x_label_text: '${XAxisLabel.getData()}',
                axis_x_padding: '${XPadding.getData()}',
                axis_x_tick_format: '${XAxisNumberFormat.getData()}',
                axis_y_label_position: 'outer-top',
                axis_y_label_text: '${YAxisLabel.getData()}',
                axis_y_padding: '${YPadding.getData()}',
                axis_y_tick_format: '${YAxisNumberFormat.getData()}',
                disableYAxisLabelResizing: disableYAxisLabelResizing,
                disableXAxisLabelResizing: disableXAxisLabelResizing,
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
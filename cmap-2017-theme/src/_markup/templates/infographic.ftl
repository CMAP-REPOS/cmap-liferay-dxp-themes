<section class="infographic-content clearfix">
    <section class="infographic-info ${randomNamespace}chart-info row">
        <a href="#" class="infographic-info-toggle"><span class="icon-info-sign"></span> <span class="sr-only">Toggle Chart Info</span></a>
        <div class="aside-container col-xl-3 col-lg-4 col-md-4 col-sm-16">
            <div class="infographic-aside">
                ${Aside.getData()}
            </div>
            <div class="infographic-source">
                ${Source.getData()}
            </div>
        </div>
        <div class="main-info col-xl-9 col-lg-12 col-md-12 col-sm-16">
            <div class="infographic-title">
                ${Title.getData()}
            </div>
            <div class="infographic-description">
                ${Info.getData()}
            </div>
            <div class="infographic-aside">
                ${Aside.getData()}
            </div>
            <div class="infographic-source">
                ${Source.getData()}
            </div>
            <#if ChartType.getData() == "area_stacked">
            <div class="infographic-buttons">
                <#if ToggledItem.getSiblings()?has_content>
                    <#list ToggledItem.getSiblings() as cur_ToggledItem>
                        <button id="infographic-button${cur_ToggledItem?index}" class="infographic-button">
                            <span>${cur_ToggledItem.ToggledItemLabel.getData()}</span>
                            <span class="pair-icons"> <span class="icon icon-paragraph-white"></span> <span class="icon icon-close-white"></span> </span>
                        </button>
                    </#list>
                </#if>
            </div>
            </#if>
        </div>
    </section>

    <#if ChartType.getData() == "donut_chart">
    <section class="row">
        <div class="col-xl-9 col-lg-12 col-md-12 col-sm-16">
            <section id="${randomNamespace}chart" class="infographic-chart ${ChartType.getData()}">
            </section>
        </div>
        <div class="col-xl-3 col-lg-4 col-md-4 col-sm-16">
            <section class="infographic-legend ${randomNamespace}chart-legend">
                <div class="legend-data col-xl-16">
                </div>
                <#--  <div class="mobile-legend-icons">
                    <span class="icon icon-paragraph-white"></span><span class="icon icon-key-white activated"></span>
                </div>  -->
            </section>
        </div>
    </section>
    <#else>
    <section id="${randomNamespace}chart" class="infographic-chart ${ChartType.getData()} row">
    </section>
    <section class="infographic-legend ${randomNamespace}chart-legend row">
        <div class="legend-data col-xl-16">
        </div>
        <#--  <div class="mobile-legend-icons">
            <span class="icon icon-paragraph-white"></span><span class="icon icon-key-white activated"></span>
        </div>  -->
    </section>
    </#if>

    <div class="side-narratives col-xs-12 col-xs-offset-1">
    <#if ToggledItem.getSiblings()?has_content>
        <#list ToggledItem.getSiblings() as cur_ToggledItem>
            <div id="side-narrative${cur_ToggledItem?index}">${cur_ToggledItem.ToggledItemContent.getData()}</div>
        </#list>
    </#if>
    </div>
</section>

<script type="text/javascript">

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
                    disableXAxisLabelResizing: disableXAxisLabelResizing
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
                $('.infographic-description').toggle();
                $('.main-info .infographic-aside, .main-info .infographic-source').toggle();
            });
        }
    );
</script>
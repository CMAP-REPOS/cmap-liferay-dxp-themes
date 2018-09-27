<link rel="stylesheet" href="http://10.13.12.163:8080/o/cmap-onto-2050-theme/css/vendor/c3.min.css" />
<link rel="stylesheet" href="${themeDisplay.getPathThemeCss()}/vendor/c3.min.css" />

<style>
#industry-clusters { border: 1px solid #ccc; }
.industry-clusters-list { height: 500px; padding: 0; overflow-x: hidden; overflow-y: auto; }
.industry-clusters-details { }
.industry-clusters-list .industry { display: block; height: 80px; margin: 0; border: none !important; outline:none; }
.industry-clusters-list .industry.selected { background-color: #246A8C; }
.industry-clusters-list .industry.selected .industry-name { color: #FFF; }
.industry-clusters-list .industry-image, .industry-clusters-list .industry-name { display: flex; align-items: center; height: 100%; padding: 0 10px; }
.industry-clusters-list .industry-name { font-size: 13px; font-weight: bold; }
.current-industry .industry-name { margin-top:20px; font-size: 22px; font-weight: bold; color: #000; }
.current-industry .chart-container { margin-bottom: 10px; }
.current-industry .nationalAverage { display: none; height: 1px; position: relative; margin: 0 12px; border-top: 2px solid #CFCFE6; padding-top: 10px; text-align: right; text-transform: uppercase; font-size: 13px; font-weight: bold; color: #CFCFE6; }
.current-industry .nationalAverage.below { top: 28px; }
.current-industry .nationalAverage.above { bottom: 18px; }
#current-industry-chart .c3-line { stroke-width: 2px; }
#current-industry-chart .c3-circle { stroke-width: 2px; fill: #000 !important; }
#current-industry-chart .c3-circle:first-child { fill: #1D6989 !important; }
#current-industry-chart .c3-circle:last-child { fill: #A8532F !important; }
.current-industry .startYear { text-align: left; }
.current-industry .indicator { text-align: center; font-size: 50px; color: #903E25; }
.current-industry .endYear { text-align: right; }
.current-industry .year { font-size: 24px; }
.current-industry .startValue, .current-industry .currentValue { font-size: 35px; font-weight: 900; }
.current-industry .startValue { color: #1D6989; }
.current-industry .currentValue { color: #A8532F; }
.current-industry .regional-performance { margin-top: 40px; }
.current-industry .regional-performance .header { margin-bottom:10px; font-size: 18px; font-weight: bold; color: #000; }
.current-industry .regional-performance .value { font-size: 16px; color: #000; }
</style>

<div id="industry-clusters" class="row">
	<div class="industry-clusters-list col-xs-16 col-sm-4">
		<#list Industry.getSiblings() as cur_Industry>
			<#assign industryIndex = cur_Industry?index>
			<#assign industryName = cur_Industry.Name.getData()>
			<#assign industryDataURL = "">
			<a href="${cur_Industry.Data.getData()}" class="industry row" data-index="${industryIndex}">
				<div class="industry-image col-xs-8">
					<#if cur_Industry.Thumbnails.Normal.getData() != '' && cur_Industry.Thumbnails.Highlight.getData() != ''>
					<img src="${cur_Industry.Thumbnails.Normal.getData()}" class="normal" alt="${industryName} thumnbnail" height="60%" />
					<img src="${cur_Industry.Thumbnails.Highlight.getData()}" class="highlight" style="display:none" alt="${industryName} thumnbnail" height="60%" />
					</#if>
				</div>
				<div class="industry-name col-xs-8">
					<span>${industryName}</span>
				</div>
			</a>
		</#list>
	</div>
	<div class="current-industry col-xs-16 col-sm-12">
		<div class="industry-name"></div>
		<div class="chart-container">
			<div class="nationalAverage below row">
				<div class="col-16">National Average</div>
			</div>
			<div id="current-industry-chart" style="height:200px"></div>
			<div class="nationalAverage above row">
				<div class="col-16">National Average</div>
			</div>
		</div>
		<div class="industry-detail">
			<div class="row">
				<div class="startYear col-xs-7">
					<div class="year">2001</div>
					<div class="startValue"></div>
				</div>
				<div class="indicator col-xs-2"></div>
				<div class="endYear col-xs-7">
					<div class="year">2017</div>
					<div class="currentValue"></div>
				</div>
			</div>
			<div class="regional-performance row">
				<div class="header col-xs-16">Regional Performance</div>
				<div class="col-xs-16">
					<span class="value"></span>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
var industries = [];
<#list Industry.getSiblings() as cur_Industry>
	<#assign startValue = 0>
	<#assign currentValue = 0>
	<#if cur_Industry.StartValue.getData()?? && cur_Industry.StartValue.getData() != ''>
		<#assign startValue = cur_Industry.StartValue.getData()?number>
	</#if>
	<#if cur_Industry.CurrentValue.getData()?? && cur_Industry.CurrentValue.getData() != ''>
		<#assign currentValue = cur_Industry.CurrentValue.getData()?number>
	</#if>
industries.push({
	name:					"${cur_Industry.Name.getData()}",
	nationalAvg:			"${cur_Industry.NationalAverageReference.getData()}",
	startValue:				${startValue?string("0.##")},
	currentValue:			${currentValue?string("0.##")},
	regionalPerformance:	"${cur_Industry.RegionalPerformance.getData()}",
});
</#list>
$('.industry-clusters-list').find('.industry').on('click', function(e){
	e.preventDefault();

	var $selectedIndustry = $( this ),
		$currentIndutryDetails = $('.current-industry'),
		index = $selectedIndustry.data("index"),
		name = industries[ index ].name,
		nationalAvg = industries[ index ].nationalAvg,
		dataURL = $selectedIndustry.attr("href"),
		startValue = industries[ index ].startValue,
		currentValue = industries[ index ].currentValue;

	$('.industry-clusters-list').find('.industry.selected').find('.industry-image .highlight').hide();
	$('.industry-clusters-list').find('.industry.selected').find('.industry-image .normal').show();
	$('.industry-clusters-list').find('.industry').removeClass('selected');
	$selectedIndustry.addClass('selected');
	$selectedIndustry.find('.industry-image .normal').hide();
	$selectedIndustry.find('.industry-image .highlight').show();
	$currentIndutryDetails.find('.industry-name').html( name );

	$currentIndutryDetails.find('.nationalAverage').hide();
	if (nationalAvg == "Above") {
		$currentIndutryDetails.find('.nationalAverage.above').show();
	}
	else {
		$currentIndutryDetails.find('.nationalAverage.below').show();
	}

	$currentIndutryDetails.find('.startValue').html( industries[ index ].startValue );
	$currentIndutryDetails.find('.currentValue').html( industries[ index ].currentValue );

	$currentIndutryDetails.find('.indicator').html("");
	if (startValue != "" & currentValue != "") {
		if (startValue < currentValue) {
			$currentIndutryDetails.find('.indicator').html( "&#11014;" )
		}
		if (startValue > currentValue) {
			$currentIndutryDetails.find('.indicator').html( "&#11015;" )
		}
	}

	$currentIndutryDetails.find('.regional-performance .value').html( industries[ index ].regionalPerformance );

	if( dataURL != ''){
		d3.csv(dataURL , function (error, d) {
			var chart = c3.generate({
				bindto: '#current-industry-chart',
				line: {
					connectNull: true
				},
				data: {
					url: dataURL,
					type: 'line',
					x: "Year",
					onclick: function (e) {
						var selectedYear = e.x,
							selectedYearValue = e.value.toFixed(2);
						$('.current-industry')
							.find('.startYear .year').html( selectedYear );
						$('.current-industry')
							.find('.startYear .startValue').html( selectedYearValue );
					},
				},
				tooltip: { show: false },
				axis: {
					x: { show: false },
					y: { show: false }
				},
				legend: { show: false },
				color: {
					pattern: ['#A7B4D6']
				},
				point: { r: 5 }
			});
		});
	}
	else {
		$("#current-industry-chart").html("");
	}
});
$('.industry-clusters-list').find('.industry').first().click();
</script>
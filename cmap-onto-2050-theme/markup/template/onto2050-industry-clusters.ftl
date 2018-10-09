<link rel="stylesheet" href="http://10.13.12.163:8080/o/cmap-onto-2050-theme/css/vendor/c3.min.css" />
<link rel="stylesheet" href="${themeDisplay.getPathThemeCss()}/vendor/c3.min.css" />

<style>
#industry-clusters { border: 1px solid #ccc; }
.industry-clusters-list { height: 480px; padding: 0; overflow-x: hidden; overflow-y: auto; }
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
#stacked-bar-chart .c3-bar { stroke:#FFF !important; stroke-width:5 !important; }
.current-industry .startYear { text-align: left; }
.current-industry .indicator { text-align: center; }
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
	<div class="industry-clusters-list col-xs-16 col-md-4">
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
	<div class="current-industry col-xs-16 col-md-12">
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
<div id="stacked-bar-chart" style="height:80px"></div>

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
			$currentIndutryDetails.find('.indicator').html( '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 84 84.5"><defs><style>.arrow-up{fill:#5f469c;}</style></defs><path class="arrow-up" d="M4.36,80.7C4.36,80.49,42.71,4,42.77,4.06c.22.26,38.37,76.65,38.3,76.68s-8.69-3.69-19.21-8.24L42.73,64.22,23.64,72.5C13.14,77.05,4.5,80.77,4.45,80.77A.08.08,0,0,1,4.36,80.7Z"/></svg>' )
		}
		if (startValue > currentValue) {
			$currentIndutryDetails.find('.indicator').html( '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 84 84.5"><defs><style>.arrow-down{fill:#8b4f21}</style></defs><path class="arrow-down" d="M81.35,4.14c0,.21-38.35,76.71-38.41,76.63C42.72,80.52,4.58,4.12,4.65,4.1s8.69,3.69,19.2,8.24L43,20.62l19.09-8.28C72.58,7.79,81.21,4.06,81.26,4.06A.09.09,0,0,1,81.35,4.14Z"/></svg>' )
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

var industrySizes = [];

<#list Industry.getSiblings() as cur_Industry>
	<#assign currentValue = 0>
	<#if cur_Industry.CurrentValue.getData()?? && cur_Industry.CurrentValue.getData() != ''>
		<#assign currentValue = cur_Industry.CurrentValue.getData()?number>
	</#if>
industrySizes.push(['industry_${cur_Industry?index}', ${currentValue}]);
</#list>

var chart = c3.generate({
	bindto: '#stacked-bar-chart',
    data: {
		type: 'bar',
		columns: industrySizes,
		groups: [
			[
				<#list Industry.getSiblings() as cur_Industry>
				'industry_${cur_Industry?index}',
				</#list>
			]
		],
		order: null
    },
	padding: { top: 0, right: 0, bottom: 0, left: 0 },
	axis: {
		rotated: true,
		x: { show: false, padding: 0 },
		y: { show: false, padding: 0 }
	},
	bar: {
		width: { ratio: 1 },
		height: { ratio: 0.5 }
	},
	color: { pattern: ['#dfe3e4'] },
	legend: { show: false },
	tooltip: { show: false }
});
</script>
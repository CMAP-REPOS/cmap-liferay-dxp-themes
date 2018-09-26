<link rel="stylesheet" href="http://10.13.12.163:8080/o/cmap-onto-2050-theme/css/vendor/c3.min.css" />
<link rel="stylesheet" href="${themeDisplay.getPathThemeCss()}/vendor/c3.min.css" />

<style>
#industry-clusters { border: 1px solid #ccc; }
.industry-clusters-list { height: 500px; padding: 0; overflow-x: hidden; overflow-y: auto; }
.industry-clusters-details { }
.industry-clusters-list .industry { display: block; height: 80px; margin: 0; border: none !important; }
.industry-clusters-list .industry.selected { background-color: #8A4E11; }
.industry-clusters-list .industry.selected .industry-name { color: #FFF; }
.industry-clusters-list .industry-image, .industry-clusters-list .industry-name { display: flex; align-items: center; height: 100%; padding: 0 10px; }
.industry-clusters-list .industry-name { font-size: 13px; font-weight: bold; }
.current-industry .industry-name { margin-top:20px; font-size: 22px; font-weight: bold; color: #000; }
.current-industry .chart-container { margin-bottom: 10px; }
.current-industry .nationalAverage { display: none; height: 1px; position: relative; margin: 0 12px; border-top: 1px solid #E4E5AD; padding-top: 10px; text-align: right; text-transform: uppercase; font-size: 13px; color: #BBB; }
.current-industry .nationalAverage.below { top: 28px; }
.current-industry .nationalAverage.above { bottom: 18px; }
#current-industry-chart circle { cursor: pointer !important; }
#current-industry-chart .c3-circle { stroke-width: 2px; fill: #786A1C !important; }
#current-industry-chart .c3-circle:first-child { fill: #5F489A !important; }
#current-industry-chart .c3-circle:last-child { fill: #8C4323 !important; }
.current-industry .startYear { text-align: left; }
.current-industry .indicator { text-align: center; font-size: 50px; color: #903E25; }
.current-industry .endYear { text-align: right; }
.current-industry .year { font-size: 24px; }
.current-industry .startValue, .current-industry .currentValue { font-size: 35px; font-weight: 900; }
.current-industry .startValue { color: #5C4799; }
.current-industry .currentValue { color: #903E25; }
</style>

<div id="industry-clusters" class="row">
	<div class="industry-clusters-list col-xs-16 col-sm-4">
		<#list Industry.getSiblings() as cur_Industry>
			<#assign industryIndex = cur_Industry?index>
			<#assign industryName = cur_Industry.Name.getData()>
			<#assign industryDataURL = "">
			<a href="${cur_Industry.Data.getData()}" class="industry row" data-index="${industryIndex}">
				<div class="industry-image col-xs-8">
					<img src="https://picsum.photos/100/50" alt="${industryName} thumnbnail" height="60%" />
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
		</div>
	</div>
</div>

<script>
var industries = [];
<#list Industry.getSiblings() as cur_Industry>
	<#assign startValue = 0>
	<#assign currentValue = 0>
	<#if cur_Industry.StartValue?? && cur_Industry.StartValue.getData()?? && cur_Industry.StartValue.getData() != ''>
		<#assign startValue = cur_Industry.StartValue.getData()>
	</#if>
	<#if cur_Industry.CurrentValue?? && cur_Industry.CurrentValue.getData()?? && cur_Industry.CurrentValue.getData() != ''>
		<#assign currentValue = cur_Industry.CurrentValue.getData()>
	</#if>
industries.push({
	idx:			${cur_Industry?index},
	name:			"${cur_Industry.Name.getData()}",
	nationalAvg:	"cur_Industry.NationalAverageReference.getData()",
	startValue:		${startValue},
	currentValue:	${currentValue}
});
</#list>
$('.industry-clusters-list').find('.industry').on('click', function(e){
	e.preventDefault();

	var $selectedIndustry = $( this ),
		$currentIndutryDetails = $('.current-industry'),
		industryIndex = $selectedIndustry.data("index"),
		industryName = industries[ industryIndex ].industryName,
		industryNationalAvgReference = industries[ industryIndex ].nationalAvg,
		industryDataURL = $selectedIndustry.attr("href"),
		industryStartValue = industries[ industryIndex ].startValue,
		industryCurrentValue = industries[ industryIndex ].currentValue;

	$('.industry-clusters-list').find('.industry').removeClass('selected');
	$selectedIndustry.addClass('selected');
	$currentIndutryDetails.find('.industry-name').html( industryName );

	$currentIndutryDetails.find('.nationalAverage').hide();
	if (industryNationalAvgReference == "Above") {
		$currentIndutryDetails.find('.nationalAverage.above').show();
	}
	else {
		$currentIndutryDetails.find('.nationalAverage.below').show();
	}

	$currentIndutryDetails.find('.startValue').html( industries[ industryIndex ].startValue );
	$currentIndutryDetails.find('.currentValue').html( industries[ industryIndex ].currentValue );

	$currentIndutryDetails.find('.indicator').html("");
	if (industryStartValue != "" & industryCurrentValue != "") {
		if (industryStartValue < industryCurrentValue) {
			$currentIndutryDetails.find('.indicator').html( "&#11014;" )
		}
		if (industryStartValue > industryCurrentValue) {
			$currentIndutryDetails.find('.indicator').html( "&#11015;" )
		}
	}

	if( industryDataURL != ''){
		d3.csv(industryDataURL , function (error, d) {
			var chart = c3.generate({
				bindto: '#current-industry-chart',
				line: {
					connectNull: true
				},
				data: {
					url: industryDataURL,
					type: 'line',
					x: "Year",
					onclick: function (e) {
						var selectedYear = e.x,
							selectedYearValue = e.value;
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
					pattern: ['#E4D880']
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
<link rel="stylesheet" href="${themeDisplay.getPathThemeCss()}/vendor/c3.min.css" />

<div id="industry-clusters" class="row">
	<div class="industry-clusters-list col-xs-16 col-sm-16 col-md-8 col-lg-4">
		<#list Industry.getSiblings() as cur_Industry>
			<#assign industryIndex = cur_Industry?index>
			<#assign industryName = cur_Industry.Name.getData()>
			<#assign industryDataURL = "">
			<a href="${cur_Industry.Data.getData()}" class="industry row" data-index="${industryIndex}">
				<div class="industry-image hidden-xs hidden-sm col-md-8">
					<#if cur_Industry.Thumbnails.Normal.getData() != '' && cur_Industry.Thumbnails.Highlight.getData() != ''>
					<img src="${cur_Industry.Thumbnails.Normal.getData()}" class="normal" alt="${industryName} thumnbnail" height="60%" />
					<img src="${cur_Industry.Thumbnails.Highlight.getData()}" class="highlight" style="display:none" alt="${industryName} thumnbnail" height="60%" />
					</#if>
				</div>
				<div class="industry-name col-xs-16 col-sm-16 col-md-8"><span>${industryName}</span></div>
			</a>
		</#list>
	</div>
	<div class="current-industry col-xs-16 com-sm-16 col-md-8 col-lg-12">
		<div class="industry-name"></div>
		<div class="chart-container">
			<div id="current-industry-chart" style="height:200px"></div>
		</div>
		<div class="employment">
			<div class="startYear">
				<div class="year">2001</div>
				<div class="startValue"></div>
			</div>
			<div class="change"></div>
			<div class="endYear">
				<div class="year">2017</div>
				<div class="currentValue"></div>
			</div>
		</div>
		<div class="regional-performance">
			<div class="header">Regional Performance</div>
			<div>
				<span class="laborSkill"></span><span class="changeDirection"></span>
				<div href="#" id="whats-this" class="whats-this">
					<div class="main">What's this?</div>
					<div class="popup">Clusters are considered more or less specialized based on how regional employment in such industries compares to the national average.<br>The arrow indicates how this measure of cluster competitiveness changed between 2001-17.</div>
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
	<#if currentValue gt startValue>
		<#assign employmentChange = "growth">
	</#if>
	<#if currentValue lt startValue>
		<#assign employmentChange = "loss">
	</#if>
industries.push({
	name:					"${cur_Industry.Name.getData()}",
	startValue:				${startValue?string("0.##")},
	currentValue:			${currentValue?string("0.##")},
	employmentChange:		"${employmentChange}",
	skillLevel:				"${cur_Industry.RegionalPerformance.LaborSkillLevel.getData()}",
	changeDirection:		"${cur_Industry.RegionalPerformance.DirectionOfChange.getData()}"
});
</#list>
$('.industry-clusters-list').find('.industry').on('click', function(e){
	e.preventDefault();

	var $selectedIndustry = $( this ),
		$currentIndutryDetails = $('.current-industry'),
		index = $selectedIndustry.data("index"),
		name = industries[ index ].name,
		dataURL = $selectedIndustry.attr("href"),
		startValue = industries[ index ].startValue,
		currentValue = industries[ index ].currentValue,
		employmentChange = industries[ index ].employmentChange,
		changeDirection = industries[ index ].changeDirection;

	$('.industry-clusters-list').find('.industry.selected').find('.industry-image .highlight').hide();
	$('.industry-clusters-list').find('.industry.selected').find('.industry-image .normal').show();
	$('.industry-clusters-list').find('.industry').removeClass('selected');
	$selectedIndustry.addClass('selected');
	$selectedIndustry.find('.industry-image .normal').hide();
	$selectedIndustry.find('.industry-image .highlight').show();
	$currentIndutryDetails.find('.industry-name').html( name );

	$currentIndutryDetails.find('.startValue').html( industries[ index ].startValue );
	$currentIndutryDetails.find('.currentValue').html( industries[ index ].currentValue );

	$currentIndutryDetails.find('.change').html("");

	$(".industry").removeClass("growth loss");
	$currentIndutryDetails.removeClass("growth loss");
	if (employmentChange == "growth") {
		$currentIndutryDetails.find('.change').html( '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 84 84.5"><path d="M4.36,80.7C4.36,80.49,42.71,4,42.77,4.06c.22.26,38.37,76.65,38.3,76.68s-8.69-3.69-19.21-8.24L42.73,64.22,23.64,72.5C13.14,77.05,4.5,80.77,4.45,80.77A.08.08,0,0,1,4.36,80.7Z"/></svg>' )
	}
	if (employmentChange == "loss") {
		$currentIndutryDetails.find('.change').html( '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 84 84.5"><path d="M81.35,4.14c0,.21-38.35,76.71-38.41,76.63C42.72,80.52,4.58,4.12,4.65,4.1s8.69,3.69,19.2,8.24L43,20.62l19.09-8.28C72.58,7.79,81.21,4.06,81.26,4.06A.09.09,0,0,1,81.35,4.14Z"/></svg>' )
	}
	$selectedIndustry.addClass( employmentChange );
	$currentIndutryDetails.addClass( employmentChange );

	$currentIndutryDetails.find('.regional-performance .laborSkill').html( industries[ index ].skillLevel );

	
	switch( industries[ index ].changeDirection ) {
		case "Up":
			$currentIndutryDetails.find('.regional-performance .changeDirection').html( '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 84 84.5"><path class="arrow-up" d="M4.36,80.7C4.36,80.49,42.71,4,42.77,4.06c.22.26,38.37,76.65,38.3,76.68s-8.69-3.69-19.21-8.24L42.73,64.22,23.64,72.5C13.14,77.05,4.5,80.77,4.45,80.77A.08.08,0,0,1,4.36,80.7Z"/></svg>' );
			break;
		case "Down":
			$currentIndutryDetails.find('.regional-performance .changeDirection').html( '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 84 84.5"><path class="arrow-down" d="M81.35,4.14c0,.21-38.35,76.71-38.41,76.63C42.72,80.52,4.58,4.12,4.65,4.1s8.69,3.69,19.2,8.24L43,20.62l19.09-8.28C72.58,7.79,81.21,4.06,81.26,4.06A.09.09,0,0,1,81.35,4.14Z"/></svg>' );
			break;
		default:
			$currentIndutryDetails.find('.regional-performance .changeDirection').html( '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 96.74 84"><path class="stable" d="M56.34,7.15c.18,0,38.15,33.42,38.08,33.48-.23.2-38.1,36.28-38.13,36.22s3.36-7.9,7.49-17.46L71.31,42,63.79,24.67c-4.14-9.54-7.52-17.39-7.52-17.43A.08.08,0,0,1,56.34,7.15Z"/><path class="stable" d="M40.41,7.15c-.19,0-38.16,33.42-38.09,33.48.23.2,38.11,36.28,38.13,36.22S37.1,69,33,59.39L25.44,42,33,24.67c4.13-9.54,7.52-17.39,7.52-17.43A.08.08,0,0,0,40.41,7.15Z"/></svg>' );
	}

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
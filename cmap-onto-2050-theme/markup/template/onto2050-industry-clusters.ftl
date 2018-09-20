<link rel="stylesheet" href="http://10.13.12.163:8080/o/cmap-onto-2050-theme/css/vendor/c3.min.css" />
<link rel="stylesheet" href="${themeDisplay.getPathThemeCss()}/vendor/c3.min.css" />

<style>
.industry header {
	font-size: 18px;
	font-weight: bold;
	color: #000;
}
.industry .chartContainer {
	margin-bottom: 10px;
}
.industry .nationalAverage {
	display: none;
	height: 1px;
	position: relative;
	margin: 0 12px;
	border-top: 1px solid #E4E5AD;
	padding-top: 10px;
	text-align: right;
	text-transform: uppercase;
	font-size: 13px;
	color: #BBB;
}
.industry .nationalAverage.below {
	top: 28px;
}
.industry .nationalAverage.above {
	bottom: 18px;
}
.industry circle {
	cursor: pointer;
}
.industry .c3-circle {
	
	stroke-width: 2px;
	fill: #786A1C !important;
}
.industry .c3-circle:first-child {
	fill: #5F489A !important;
}
.industry .c3-circle:last-child {
	fill: #8C4323 !important;
}
.industry .startYear {
	text-align: left;
}
.industry .indicator {
	text-align: center;
	font-size: 50px;
	color: #903E25;
}
.industry .endYear {
	text-align: right;
}
.industry .year {
	font-size: 24px;
}
.industry .startValue,
.industry .currentValue {
	font-size: 35px;
	font-weight: 900;
}
.industry .startValue {
	color: #5C4799;
}
.industry .currentValue {
	color: #903E25;
}
</style>

<#list Industry.getSiblings() as cur_Industry>
	<#assign industryIndex = cur_Industry?index>

	<div id="industry_${randomNamespace}_${industryIndex}" class="industry">

		<header>${cur_Industry.Name.getData()}</header>

		<#if cur_Industry.Data.getData()?? && cur_Industry.Data.getData() != "">
			<div class="chartContainer">
				<div class="nationalAverage below row">
					<div class="col-16">National Average</div>
				</div>

				<div id="chart_${randomNamespace}_${industryIndex}" style="height:200px">
				</div>

				<div class="nationalAverage above row">
					<div class="col-16">National Average</div>
				</div>
			</div>
			<script>
				<#if cur_Industry.NationalAverageReference?? && cur_Industry.NationalAverageReference.getData() ?? && cur_Industry.NationalAverageReference.getData() != "">
					<#if cur_Industry.NationalAverageReference.getData() == "Above">
					$('#industry_${randomNamespace}_${industryIndex} .nationalAverage.above').show();
					<#else>
					$('#industry_${randomNamespace}_${industryIndex} .nationalAverage.below').show();
					</#if>
				</#if>
				d3.csv('${cur_Industry.Data.getData()}', function (error, d) {
					var chart = c3.generate({
						bindto: '#chart_${randomNamespace}_${industryIndex}',
						line: {
							connectNull: true
						},
						data: {
							url: '${cur_Industry.Data.getData()}',
							type: 'line',
							x: "Year",
							onclick: function (e) {
								var selectedYear = e.x,
									selectedYearValue = e.value;
								$('#industry_${randomNamespace}_${industryIndex}')
									.find('.startYear .year').html( selectedYear );
								$('#industry_${randomNamespace}_${industryIndex}')
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
			</script>
		</#if>

		<#assign startValue = 0>
		<#assign currentValue = 0>
		<#if cur_Industry.StartValue?? && cur_Industry.StartValue.getData()?? && cur_Industry.StartValue.getData() != ''>
			<#assign startValue = cur_Industry.StartValue.getData()?number>
		</#if>
		<#if cur_Industry.CurrentValue?? && cur_Industry.CurrentValue.getData()?? && cur_Industry.CurrentValue.getData() != ''>
			<#assign currentValue = cur_Industry.CurrentValue.getData()?number>
		</#if>

		<div class="row">
			<div class="startYear col-xs-7">
				<div class="year">2001</div>
				<div class="startValue">${startValue}</div>
			</div>
			<div class="indicator col-xs-2">
				<#if startValue < currentValue>
					<span>&#11014;</span>
				<#else>
					<span>&#11015;</span>
				</#if>
			</div>
			<div class="endYear col-xs-7">
				<div class="year">2017</div>
				<div class="currentValue">${currentValue}</div>
			</div>
		</div>
	</div>
</#list>
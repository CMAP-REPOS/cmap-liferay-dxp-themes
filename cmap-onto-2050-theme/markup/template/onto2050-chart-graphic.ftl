<#if Anchor.getData()?? && Anchor.getData() != "">
	<#assign anchor = Anchor.getData()>
<#else>
	<#assign anchor = ''>
</#if>

<#if Description.getData()?? && Description.getData() != "">
	<#assign description = Description.getData()>
<#else>
	<#assign description = ''>
</#if>


<div class="row">
  <#if description == ''>
    <div class="col-sm-16">
      <canvas id="${randomNamespace}" width="400" height="400"></canvas>
    </div>
  <#else>
    <div class="col-sm-8">
      <canvas id="${randomNamespace}" width="400" height="400"></canvas>
    </div>
    <div class="col-sm-8">
      ${description}
    </div>
  </#if>
</div>

<button class="chart-selector" data-type="line">Line</button>
<button class="chart-selector" data-type="bar">Bar</button>
<button class="chart-selector" data-type="donut">Donut</button>
<button class="chart-selector" data-type="area">Area</button>

<script>
var myChart = null;
function buildChart(type){
  if(myChart){
    myChart.destroy();
  }
  var config_object = {};
  if(type === 'bar'){
    config_object.type = 'bar';
    config_object.data = {
      labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
      datasets: [{
        label: '# of Votes',
        data: [12, 19, 3, 5, 2, 3],
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(255, 206, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(153, 102, 255, 0.2)',
          'rgba(255, 159, 64, 0.2)'
        ],
        borderColor: [
          'rgba(255,99,132,1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)',
          'rgba(153, 102, 255, 1)',
          'rgba(255, 159, 64, 1)'
        ],
        borderWidth: 1
      }]
    };
    config_object.options = {
      tooltips: {
        mode: 'y'
      },
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero:true
          }
        }]
      }
    }
  }


  if(type === 'line'){

    var example_data = [3, 2, 5, 4, 19, 12, 20, 1, 5, 16, 3, 2, 5, 4, 19, 12, 20, 1, 5, 16,3, 2, 5]
    var example_data2 = example_data.reverse();
    config_object.type = 'line';
    config_object.data = {
      labels: ["1995","","","","","","","","","","","","","","","","","","","","","","2017"],
      datasets: [
        {
          label: '1 Unit',
          data: example_data,
          borderColor: '#DF824C',
          backgroundColor: 'transparent',
        },
        {
          label: '2+ Units',
          data: example_data2,
          borderColor: '#F4C357',
          backgroundColor: 'transparent',
        }
      ]
    };
  }

  myChart = new Chart($('#${randomNamespace}'), config_object);
}

Liferay.on(
	'allPortletsReady',
	function() {
    $('.chart-selector').click(function(e){
      e.preventDefault();
      buildChart($(e.target).data('type'));
    })
	}
);

require(['https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js'], function(Chart){
  buildChart('bar');
});
</script>

<#assign url = request.attributes["CURRENT_URL"]/>
<#assign query = httpUtil.getParameter(url, "q", false)/>
<#assign from = httpUtil.getParameter(url, "from", false)/>

<#if from=="allUpdates">
  <p>All Updates Search</p>
  <#assign cx="002317912170329299193:96ahgvbuc6u" />
<#elseif from=="policyUpdates">
  <p>Policy Updates Search</p>
  <#assign cx="004289794693594110260:cdffjnh2ieg" />
<#elseif from=="weeklyUpdates">
  <p>Weekly Updates Search</p>
  <#assign cx="004289794693594110260:w59v4jvxbds" />
<#else>
  <#assign cx="004289794693594110260:midq7iuukta" />
</#if>



<section class="search-results-widget">
  <div class="row">
    <div class="col-xl-3 col-sm-2 col-xs-0"> </div>

    <div id="search-col" class="col-xl-10 col-sm-12 col-xs-16">
      <header class="row">
        <div class="search-bar col-xl-16">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 19 19">
            <path d="M11.5,11.5c1-1,1.6-2.4,1.6-3.9c0-3.1-2.5-5.6-5.6-5.6S2,4.5,2,7.6c0,3.1,2.5,5.6,5.6,5.6 C9.1,13.2,10.5,12.5,11.5,11.5L18,18L11.5,11.5z"/> 
          </svg>
          <input class="search-bar-input" value="${query}" placeholder="Search..." />
          <button class="search-bar-submit">Update Search</button>
        </div>
      </header>

      <div class="row search-filters">
      	<div class="col-xl-8">
      		<div class="search-filter type-filter">
	      		<label class="search-filter-label">Show</label>
	      		<button class="active search-filter-button" data-action="all">All</button>
	      		<button class="search-filter-button" data-action="web-pages">Web pages</button>
	      		<button class="search-filter-button" data-action="documents">Documents</button>
	      	</div>
      	</div>
      	<div class="col-xl-8">
      		<div class="search-filter sort-filter">
      			<label class="search-filter-label">Sort by</label>
      			<button class="active search-filter-button" data-action="relevance">Relevance</button>
	      		<button class="search-filter-button" data-action="date">Date</button>
      		</div>
      	</div>
      </div>

      <div class="search-results row">

      </div>
    </div>

    <div class="col-xl-3 col-sm-2 col-xs-0"></div>  
  </div>
</section>



<!-- TRACER -->
<script>


// var renderGCSE = function(){
//   google.search.cse.element.render({
//     div: 'searchResultsNode',
//     tag: 'search'
//   });
//   var $container = $('#search-col');
//   var $input = $('#searchResultsNode input');
//   $input.removeAttr('style');
//   var $search_button = $('#searchResultsNode input.gsc-search-button');
//   $search_button.attr('Value', 'Update Search');
//   $container.find('header .search-bar').append($input);
//   // lets the user pick between date and relevant sorting
//   var $sortFilter = $('.gsc-option-menu-container').remove();
//   $('.search-filters .sort-filter').append($sortFilter);
//   // place the main guts of the search in the right place
//   // var $searchResults = $('.gsc-wrapper').remove();
//   // $('.search-results.row').append($searchResults.addClass('col-xl-16'));
//   // console.log(google.search.cse.element.getAllElements());
//   $('.gsc-webResult.gsc-result').each(function(){
//   	// console.log(this);
//   })
//   // we don't need this anymore
//  	$('.gsc-resultsHeader').remove();
// };
// next three functions do all the work
// loading the script and starting the callback
// https://developers.google.com/custom-search/docs/element
// var myCallback = function() {
//   if (document.readyState == 'complete') {
//     renderGCSE();
//   } else {
//     google.setOnLoadCallback(function() {
//       renderGCSE();
//     }, true);
//   }
// };
// window.__gcse = {
//   parsetags: 'explicit',
//   callback: myCallback
// };
// (function() {
//   var cx = '${cx}';
//   var gcse = document.createElement('script');
//   gcse.type = 'text/javascript';
//   gcse.async = true;
//   gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
//   var s = document.getElementsByTagName('script')[0];
//   s.parentNode.insertBefore(gcse, s);
// })();




$(document).ready(function(){


	function buildResult(data){
		var $item = $('<div class="search-result col-xl-8"></div>');

		// this field is undefined for "web pages"
		var type = 'Web page';
		if(data.fileFormat){
			type = 'Document'
		}
		var $type = $('<h4 class="search-result-type">'+type+'</h4>');
		$item.append($type);

		var $title = $('<a class="search-result-title" href="'+data.link+'"><h3>'+data.title+'</h3></a>');
		$item.append($title);

		var $preview = $('<p class="search-result-preview"></p>');
		$preview.html(data.htmlSnippet);
		$item.append($preview);

		var $link = $('<a class="search-result-link" href="'+data.link+'">Read more</a>');
		$item.append($link);

		return $item;
	}

	function buildPage(data){

		var $container = $('.search-results.row');
		
		if(!data.items){
			alert("I'm sorry but we could not find any results. </br>Please try another query");
		} else {
			data.items.forEach(function(d){
				var $item = buildResult(d);			
				$container.append($item);
			});
		}
	}
	
	var startIndex = 0;
	var searchQuery = {
    "q": "${query}",
    "key": "AIzaSyBUUcEmcgKPeyRCWRC_iubAJyfVqHaG0Ik",
    "cx": "004289794693594110260:midq7iuukta",
  }
	if(startIndex > 0){
		searchQuery.start = startIndex.toString();
	}

	jQuery.ajax({
    url: "https://www.googleapis.com/customsearch/v1",
    type: "GET",
    data: searchQuery,
	})
	.done(function(data, textStatus, jqXHR) {
		console.log(data);
    buildPage(data);
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
    alert('Search failed: ', textStatus);
	})
	.always(function() {
	  // don't quite need this yet
	});
});
</script>

<style>
.gsc-option-menu-invisible{
	display: block;
}
.gsc-option-menu-item{
	padding: 0;
	display: inline-block;
	margin-left: 0.2em;
}
.gsc-option-menu-item-highlighted{
	background-color: blue;
	border: none;
}
.gsc-selected-option-container.gsc-inline-block{
	display: none;
}


table.gsc-search-box{
	display: none;
}
.gsc-above-wrapper-area{
	display: none;
}
</style>

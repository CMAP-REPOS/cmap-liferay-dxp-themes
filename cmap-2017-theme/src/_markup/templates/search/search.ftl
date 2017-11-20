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

  <div class="jump-to-top row">
  	<div class="col-xl-3 col-sm-2 col-xs-0">
  		Jump to Top
  	</div>  
  	<div class="col-xl-10 col-sm-12 col-xs-16"></div>
  	<div class="col-xl-3 col-sm-2 col-xs-0"></div>  
  </div>
</section>


<script>

var cmap = cmap || {};
cmap.search = cmap.search || {};

cmap.search.query = '${query}';
cmap.search.totalResults = 0;
cmap.search.fetchNum = 10;
cmap.search.currentStart = 1;
cmap.search.sort = '';
cmap.search.type = 'all';

cmap.search.buildResult = function(data){
	var $item = $('<div class="search-result col-xl-8"></div>');

	$item.append($('<hr class="search-result-divider" />'));

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
	$preview.find('br').remove();
	$item.append($preview);

	var $link = $('<a class="search-result-link" href="'+data.link+'">Read more</a>');
	$item.append($link);

	return $item;
}

cmap.search.clear = function(){
	var $container = $('.search-results.row');
	cmap.search.currentStart = 1;
	cmap.search.fetchNum = 10;
	$container.empty();
	$container.html('<div class="loading"> <div class="spinner"> <div class="dot1"></div> <div class="dot2"></div> </div> </div>');
}

cmap.search.addResultsToDOM = function(elements){
	elements.forEach(function(d){
		var $item = cmap.search.buildResult(d);			
		$('.search-results.row').append($item);
	});
}

cmap.search.buildPage = function(data){
	if(cmap.search.totalResults === 0){
		alert("I'm sorry but we could not find any results. Please try a different query");
		console.log(data);
	} else {
		cmap.search.addResultsToDOM(data.items);
	}
	

	var $more = $('<button class="more-results">Load more results</button>');
	$more.click(function(){
		cmap.search.currentStart += 10;
		$more.remove();
		console.log(cmap.search.totalResults, cmap.search.currentStart);
		if(cmap.search.totalResults > cmap.search.currentStart ){
			cmap.search.hitAPI();
		}
	});
	if(data.items && data.items.length === 10){
		$('.search-results.row').append($more);
	}
}


cmap.search.hitAPI = function(){

	// crunch the parameters to build your request data
	var q = cmap.search.query;
	if(cmap.search.type !== 'all'){
		if(cmap.search.type === 'web-pages'){
			q += ' -filetype:pdf';
		}
		if(cmap.search.type === 'documents'){
			q += ' filetype:pdf';
		}
	}
	var searchQuery = {
    "q": q,
    "key": "AIzaSyBUUcEmcgKPeyRCWRC_iubAJyfVqHaG0Ik",
    "cx": "004289794693594110260:midq7iuukta",
    "start": cmap.search.currentStart,
    "num": cmap.search.fetchNum
  };
  if(cmap.search.sort !== ''){
		if(cmap.search.sort === 'date'){
			searchQuery.sort = 'date';
		}
	}
  
	jQuery.ajax({
    url: "https://www.googleapis.com/customsearch/v1",
    type: "GET",
    data: searchQuery,
	})
	.done(function(data, textStatus, jqXHR) {
		console.log(data);
		cmap.search.totalResults = parseInt(data.searchInformation.totalResults);
		cmap.search.buildPage(data);
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
    alert('Search failed: ', textStatus);
	})
	.always(function() {
	  $('.loading').hide();
	});
}


cmap.search.watchForInput = function(){
	var $input = $('.search-bar .search-bar-input');
	$input.keydown(function(e){
		if(e.which === 13){
			cmap.search.query = e.target.value;
			cmap.search.clear();
			cmap.search.hitAPI();
		}
	});
	var $searchButton = $('.search-bar-submit');
	$searchButton.click(function(e){
		cmap.search.query = $input.val();
		cmap.search.clear();
		cmap.search.hitAPI();
	});

	var $sortFilter = $('.sort-filter');
	var $typeFilter = $('.type-filter');

	$sortFilter.find('.search-filter-button').click(function(){
		var $this = $(this), action = $this.data('action');
		cmap.search.sort = action;
		cmap.search.query = $input.val();
		cmap.search.clear();
		cmap.search.hitAPI();
		$sortFilter.find('*').removeClass('active');
		$this.addClass('active');
	});

	$typeFilter.find('.search-filter-button').click(function(){
		var $this = $(this), action = $this.data('action');
		cmap.search.type = action;
		cmap.search.query = $input.val();
		cmap.search.clear();
		cmap.search.hitAPI();
		$typeFilter.find('*').removeClass('active');
		$this.addClass('active');
	});

}

$(document).ready(function(){
	cmap.search.clear();
	cmap.search.hitAPI();
	cmap.search.watchForInput();
});
</script>

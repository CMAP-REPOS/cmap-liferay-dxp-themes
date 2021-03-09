<#assign url = themeDisplay.getURLCurrent() />
<#-- <#assign url = request.attributes["CURRENT_URL"]/> -->
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
		<div class="col-xl-3 col-md-2 col-sm-0"> </div>

		<div id="search-col" class="col-xl-10 col-md-12 col-sm-16">
			<header class="row">
				<div class="search-bar col-xl-16">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 19 19">
						<path d="M11.5,11.5c1-1,1.6-2.4,1.6-3.9c0-3.1-2.5-5.6-5.6-5.6S2,4.5,2,7.6c0,3.1,2.5,5.6,5.6,5.6 C9.1,13.2,10.5,12.5,11.5,11.5L18,18L11.5,11.5z"/>
					</svg>
					<input class="search-bar-input" value="${query}" placeholder="Search..." />
					<button class="search-bar-submit search-button">Update Search</button>
				</div>
			</header>

			<div class="row search-filters">
				<div class="col-xl-8 col-lg-16">
					<div class="search-filter type-filter">
						<label class="search-filter-label">Show</label>
						<button class="active filter-button" data-action="all">All</button>
						<button class="filter-button" data-action="web-pages">Web pages</button>
						<button class="filter-button" data-action="documents">Documents</button>
					</div>
				</div>
				<div class="col-xl-8 col-lg-16">
					<div class="search-filter sort-filter">
						<label class="search-filter-label">Sort by</label>
						<button class="active filter-button" data-action="relevance">Relevance</button>
						<button class="filter-button" data-action="date">Date</button>
					</div>
				</div>
			</div>

			<div class="search-results row">
			</div>
		</div>

		<div class="col-xl-3 col-md-2 col-sm-0"></div>
	</div>
	<div class="jump-to-top row">
		<div class="col-xl-3 col-sm-2 col-xs-0">
			<div class="return-back-to-top">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="19" viewBox="0 0 16 19">
					<path fill="#3C5976" d="M8.70320061,4.28823998 L8.70320061,17.4126841 C8.70320061,17.8959333 8.31144977,18.2876841 7.82820061,18.2876841 C7.34495145,18.2876841 6.95320061,17.8959333 6.95320061,17.4126841 L6.95320061,4.28785174 L2.48442136,8.62526255 C2.13765366,8.96183633 1.58369594,8.95357254 1.24712216,8.60680484 C0.910548372,8.26003715 0.918812169,7.70607943 1.26557986,7.36950564 L7.82800061,1 L14.3904214,7.36950564 C14.7371891,7.70607943 14.7454528,8.26003715 14.4088791,8.60680484 C14.0723053,8.95357254 13.5183476,8.96183633 13.1715799,8.62526255 L8.70320061,4.28823998 Z"/> </svg>
				<span>To Top</span>
			</div>
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
        var $item = $('<div class="search-result col-xl-8 col-lg-16"></div>');

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

    cmap.search.clear = function () {
        var $container = $('.search-results.row');
        cmap.search.currentStart = 1;
        cmap.search.fetchNum = 10;
        $container.empty();
        $container.html('<div class="loading"> <div class="spinner"> <div class="dot1"></div> <div class="dot2"></div> </div> </div>');
    };

    cmap.search.addResultsToDOM = function(elements){
        elements.forEach(function(d){
            var $item = cmap.search.buildResult(d);
            $('.search-results.row').append($item);
        });
    }

    cmap.search.buildPage = function(data){

        if(cmap.search.totalResults === 0){
            console.log(data);
            var query = data.queries.request[0].searchTerms;
            alert("I'm sorry but we could not find any results for: "+query+". Please try a different query");
        } else {
            cmap.search.addResultsToDOM(data.items);
        }

        var $more = $('<button class="more-results search-button">Load more results</button>');
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


    cmap.search.hitAPI = function () {

        // crunch the parameters to build your request data
        var q = cmap.search.query;

        if ($.trim(q).length) {
            if (cmap.search.type !== 'all') {
                if (cmap.search.type === 'web-pages') {
                    q += ' -filetype:pdf';
                }
                if (cmap.search.type === 'documents') {
                    q += ' filetype:pdf';
                }
            }
            var searchQuery = {
                'q': q,
                'key': 'AIzaSyBUUcEmcgKPeyRCWRC_iubAJyfVqHaG0Ik',
                'cx': '004289794693594110260:midq7iuukta',
                'start': cmap.search.currentStart,
                'num': cmap.search.fetchNum
            };
            if (cmap.search.sort !== '') {
                if (cmap.search.sort === 'date') {
                    searchQuery.sort = 'date';
                }
            }

            jQuery.ajax({
                url: "https://www.googleapis.com/customsearch/v1",
                type: "GET",
                data: searchQuery,
            })
                .done(function (data, textStatus, jqXHR) {
                    console.log(data);
                    cmap.search.totalResults = parseInt(data.searchInformation.totalResults);
                    cmap.search.buildPage(data);
                })
                .fail(function (jqXHR, textStatus, errorThrown) {
                    alert('Search failed: ', textStatus);
                    console.log(jqXHR, textStatus, errorThrown);
                })
                .always(function () {
                    $('.loading').hide();
                });
        }
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

        $sortFilter.find('.filter-button').click(function(){
            var $this = $(this), action = $this.data('action');
            cmap.search.sort = action;
            cmap.search.query = $input.val();
            cmap.search.clear();
            cmap.search.hitAPI();
            $sortFilter.find('*').removeClass('active');
            $this.addClass('active');
        });

        $typeFilter.find('.filter-button').click(function(){
            var $this = $(this), action = $this.data('action');
            cmap.search.type = action;
            cmap.search.query = $input.val();
            cmap.search.clear();
            cmap.search.hitAPI();
            $typeFilter.find('*').removeClass('active');
            $this.addClass('active');
        });

        $('.return-back-to-top').click(function(){
            $('body,html').animate({
                scrollTop: 0
            }, 800);
        });
    }

    $(document).ready(function () {
        cmap.search.clear();
        cmap.search.checkQueryString();
        cmap.search.hitAPI();
        cmap.search.watchForInput();
    });

    cmap.search.checkQueryString = function () {
        var re = /q=(.*?)($|\&)/i;
        var query = window.location.search;
        if (query.length &&
            re.test(query) &&
            query.match(re).length > 1) {
            cmap.search.query = unescape(query.match(re)[1]);
            $('.search-bar .search-bar-input').val(cmap.search.query);
        }
    };

</script>
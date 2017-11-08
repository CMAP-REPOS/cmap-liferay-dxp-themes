<#assign url=request.attributes["CURRENT_URL"]/>
<#assign query=httpUtil.getParameter(url, "q", false)/>
<#assign from=httpUtil.getParameter(url, "from", false)/>

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

<div id="searchResultsNode"></div>


<section class="search-results">
  <div class="row scrolling-page-nav">
    <div class="col-xl-3 col-sm-2 col-xs-0"> </div>
    <div id="search-col" class="col-xl-10 col-sm-12 col-xs-16">
      
      <header>
        <div class="search-bar">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 19 19">
            <path d="M11.5,11.5c1-1,1.6-2.4,1.6-3.9c0-3.1-2.5-5.6-5.6-5.6S2,4.5,2,7.6c0,3.1,2.5,5.6,5.6,5.6 C9.1,13.2,10.5,12.5,11.5,11.5L18,18L11.5,11.5z"/> 
          </svg>

        </div>

      </header>
      <div class="gsc-results"></div>
    </div>
    <div class="col-xl-3 col-sm-2 col-xs-0"></div>  
  </div>
</section>


<script>

var renderGCSE = function(){
  google.search.cse.element.render({
    div: 'searchResultsNode',
    tag: 'search'
  });

  var $container = $('#search-col');
  var $input = $('#searchResultsNode input');
  $input.removeAttr('style');
  
  var $search_button = $('#searchResultsNode input.gsc-search-button');
  $search_button.attr('Value', 'Update Search');

  $container.find('header .search-bar').append($input);

  $('.gsc-results.gsc-webResult').remove();
  console.log($('.gsc-results').remove());
};

var myCallback = function() {
  if (document.readyState == 'complete') {
    renderGCSE();
  } else {
    google.setOnLoadCallback(function() {
      renderGCSE();
    }, true);
  }
};

window.__gcse = {
  parsetags: 'explicit',
  callback: myCallback
};

(function() {
  var cx = '${cx}';
  var gcse = document.createElement('script');
  gcse.type = 'text/javascript';
  gcse.async = true;
  gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
  var s = document.getElementsByTagName('script')[0];
  s.parentNode.insertBefore(gcse, s);
})();

</script>

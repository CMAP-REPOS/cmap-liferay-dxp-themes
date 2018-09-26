
<script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-linkify/2.1.7/linkify.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-linkify/2.1.7/linkify-jquery.min.js"></script>
<script>

window.endnotes = window.endnotes || {};
window.endnotes.count = 0;
window.endnotes.query_for_page = window.endnotes.query_for_page || function(url, parent){
  jQuery.ajax({
    url: url,
    type: "GET"
  })
  .done(function(data, textStatus, jqXHR) {
    console.log("HTTP Request Succeeded: " + jqXHR.status);
    window.endnotes.build_page(data, parent, url);
  })
  .fail(function(jqXHR, textStatus, errorThrown) {
    console.log("HTTP Request Failed");
  })
  .always(function() {
    /* ... */
  });
}

window.endnotes.build_page = window.endnotes.build_page || function(html, parent, url) {
  var $html = $(html);
  var $page_title = $html.find('#scroll-nav .desktop-row .page-title');
  var $endnotes = $html.find('.onto2050-endnote');

  if($endnotes.length){
    var $section = $('<div class="page-section row"></div>');
    $section.append('<header><a class="whitney-small bold" href="'+url+'" target="_blank">'+$page_title.text()+'</a></header>');

    var $links = $('<div class="page-endnotes col-sm-16"></div>');

    $endnotes.each(function(i,el){
      console.log(el, i);
      var $endnote_row = $('<div class="endnote-row presna-normal" id="'+$page_title.text()+'-endnote-'+(i+1)+'"></div>');
      $endnote_row.append('<span class="endnote-number">'+(i+1)+'</span>');
      var $endnote_details = $('<span class="endnote-details"></span>');
      var reference = $(el).attr('reference');
      $endnote_details.html(reference);
      $endnote_details.linkify();
      $endnote_details.append('<a class="backlink" href="'+url+'#endnote-'+(i+1)+'">In situ</a>');
      $endnote_row.append($endnote_details);
      $links.append($endnote_row);
    });
    $section.append($links);

    $(parent).append($section);
  }
  window.endnotes.count -= 1;
  window.endnotes.check_finish();
}

window.endnotes.check_finish = window.endnotes.check_finish || function(){
  if(window.location.hash && window.endnotes.count === 0){
    $('html,body').animate({
      scrollTop: $(window.location.hash).offset().top - $('#scroll-nav').innerHeight()
    });
  }
};
</script>

<div class="onto2050-endnotes-page">
<#if Section.getSiblings()?has_content>
<script>
  Liferay.on(
    'allPortletsReady',
    function() {
    }
  );
</script>
	<#list Section.getSiblings() as current_section>
    <div class="endnotes-section ${current_section.getData()}-section">
      
      <h2 class="section-sub-headline bold alt-color onto2050-basic-web-content"><a name="${current_section.getData()}" id="${current_section.getData()}">${current_section.getData()}</a></h2>
      
      <#if current_section.PageWithEndnotes.getSiblings()?has_content>
      	<#list current_section.PageWithEndnotes.getSiblings() as current_page>
          <script>
            Liferay.on(
              'allPortletsReady',
              function() {
                window.endnotes.count += 1;
                window.endnotes.query_for_page(
                  window.location.origin+'${current_page.getFriendlyUrl()}', 
                  '.${current_section.getData()}-section'
                );
              }
            );
          </script>
        </#list>
      </#if>
    </div>
	</#list>
</#if>
</div>
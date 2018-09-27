
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
    if(jqXHR.status != 200){
      console.log("HTTP Request Status: " + jqXHR.status);
    }
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

  if($html.find('h1').length){
    $page_title = $html.find('h1');
    $page_title.find('.section-sub-headline').remove();
    $page_title.find('br').remove();
  }

  var friendly_page_title = $page_title.text().toLowerCase().replace(/ /g, '-').replace(/-/g,'').trim();

  var $endnotes = $html.find('.onto2050-endnote');

  if($endnotes.length){
    var $section = $('<div class="page-section row"></div>');
    $section.append('<header><a class="whitney-small bold" href="'+url+'" target="_blank">'+$page_title.text()+'</a></header>');

    var $links = $('<div class="page-endnotes"></div>');
    $endnotes.each(function(i,el){
      var $endnote_row = $('<div class="endnote-row col-sm-16" id="'+friendly_page_title+'-endnote-'+(i+1)+'"></div>');
      $endnote_row.append('<span class="endnote-number">'+(i+1)+'</span>');
      var $endnote_details = $('<span class="endnote-details"></span>');
      var reference = $(el).attr('reference');
      $endnote_details.html(reference);
      $endnote_details.linkify();
      $endnote_details.append('<a class="backlink" href="'+url+'#endnote-'+(i+1)+'" target="_blank">Back</a>');
      $endnote_row.append($endnote_details);
      $links.append($endnote_row);
    });
    $section.append($links);

    $(parent).append($section);
  }
  window.endnotes.count -= 1;
  window.endnotes.check_finish();
}

window.endnotes.already_focused = false;
window.endnotes.check_finish = window.endnotes.check_finish || function(){
  if(window.location.hash){
    console.log($(window.location.hash));
    if($(window.location.hash).length){

      if(!window.endnotes.already_focused){
        var jump = $(window.location.hash).offset().top - $('#scroll-nav').innerHeight();

        if($('#ControlMenu').length){
          jump += $('#ControlMenu').innerHeight();
        }

        $('html,body').animate({
          scrollTop: jump
        });

        $(window.location.hash).addClass('active');
        window.endnotes.already_focused = true;
      }
      
    } 
  }
};
</script>

<div class="onto2050-endnotes-page">
<#if Section.getSiblings()?has_content>
	<#list Section.getSiblings() as current_section>

    <#assign friendly_url = current_section.getData()?lower_case?replace(" ", "-") />
    <div class="endnotes-section ${friendly_url}-section">
      
      <h2 class="section-sub-headline bold alt-color onto2050-basic-web-content"><a name="${friendly_url}" id="${friendly_url}">${current_section.getData()}</a></h2>
      
      <#if current_section.PageWithEndnotes.getSiblings()?has_content>
      	<#list current_section.PageWithEndnotes.getSiblings() as current_page>
          <script>
            Liferay.on(
              'allPortletsReady',
              function() {
                window.endnotes.count += 1;
                window.endnotes.query_for_page(
                  window.location.origin+'${current_page.getFriendlyUrl()}', 
                  '.${friendly_url}-section'
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
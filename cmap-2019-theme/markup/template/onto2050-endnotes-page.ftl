<script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-linkify/2.1.7/linkify.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-linkify/2.1.7/linkify-jquery.min.js"></script>

<script>
window.endnotes = window.endnotes || {};
window.endnotes.query_for_page = window.endnotes.query_for_page || function(url, index){
  jQuery.ajax({
    url: url,
    type: "GET"
  })
  .done(function(data, textStatus, jqXHR) {
    if(jqXHR.status != 200){
      console.log("HTTP Request Status: " + jqXHR.status);
    }
    window.endnotes.build_page(data, url, index);
  })
  .fail(function(jqXHR, textStatus, errorThrown) {
    console.log("HTTP Request Failed");
  })
  .always(function() {
    /* ... */
  });
}

window.endnotes.build_page = window.endnotes.build_page || function(html, url, index) {
  var $html = $(html);
  var $page_title = $html.find('#scroll-nav .desktop-row .page-title');

  if($html.find('h1').length){
    $page_title = $html.find('h1');
    $page_title.find('.section-sub-headline').remove();
    $page_title.find('br').remove();
  }

  var friendly_page_title = $page_title.text().replace(/,/g,'').replace(/\'/g, '').replace(/ /g, '-');
  friendly_page_title = friendly_page_title.toLowerCase().trim()

  var $endnotes = $html.find('.onto2050-endnote');

  if($endnotes.length){
    var $section = $('<div class="page-section row"></div>');
    $section.append('<header><a class="whitney-small bold" href="'+url+'" target="_blank">'+$page_title.text()+'</a></header>');

    var $links = $('<div class="page-endnotes"></div>');
    $endnotes.each(function(i,el){
      var $endnote_row = $('<div class="endnote-row col-sm-16"></div>');
      $endnote_row.append('<span class="endnote-number">'+(i+1)+'</span>');
      var $endnote_details = $('<span class="endnote-details"></span>');
      var reference = $(el).attr('reference');
      $endnote_details.html(reference);
      $endnote_details.linkify();
      $endnote_details.append('<a class="backlink" href="'+url+'#endnote-'+(i+1)+'" target="_blank">Back</a>');
      $endnote_row.append($endnote_details);
      $endnote_row.append('<div class="endnote-row-anchor" id="'+friendly_page_title+'-endnote-'+(i+1)+'"></div>');
      $links.append($endnote_row);
    });
    $section.append($links);

    $('.endnotes-page-'+index).append($section);

    $('.endnote-row').each(function(){
      var $this = $(this), height = $this.innerHeight();
      if($('#scroll-nav').length){
        height += $('#scroll-nav').innerHeight();
      }
      if($('#ControlMenu').length){
        height += $('#ControlMenu').innerHeight();
      }
      $this.find('.endnote-row-anchor').css('height', height);
    });
  }
}
</script>

<div class="onto2050-endnotes-page">
  <#if Introduction?has_content>
    <header>
      ${Introduction.getData()}
    </header>
  </#if>

  <#if PageWithEndnotes.getSiblings()?has_content>
    <#list PageWithEndnotes.getSiblings() as current_page>
      <div class="endnotes-page endnotes-page-${current_page?index}">
        <script>
          Liferay.on(
            'allPortletsReady',
            function() {
              window.endnotes.query_for_page(window.location.origin+'${current_page.getFriendlyUrl()}', ${current_page?index});
            }
          );
        </script>
      </div>
    </#list>
  </#if>
</div>
<#if Partners.getSiblings()?has_content>
<section class="partner-slider slider" id="${randomNamespace}">

  <header class="row">
    <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
      <div class="buttons">
        <h3>Partner Spotlight</h3>
        <div class="view-all">
          <a href="/view-all">View all</a>
        </div>
      </div>
    </div>
  </header>

  <div class="slider-container"></div>
  <#list Partners.getSiblings() as Partner>
    <div class="partner col-xl-5 col-md-8">
      <div class="partner-logo">
        <#if Partner.Logo.getData()?? && Partner.Logo.getData() != "">
          <div class="slide-background">
            <img data-fileentryid="${Partner.Logo.getAttribute("fileEntryId")}" alt="${Partner.Logo.getAttribute("alt")}" src="${Partner.Logo.getData()}" />
          </div>
        </#if>
      </div>
      <div class="partner-description">
        <#if Partner.Description.getSiblings()?has_content>
          ${Partner.Description.getData()}
        </#if>
      </div>
    </div>
  </#list>
</section>
</#if>

<script>
  // takes the content as outputed from Liferay
  // and formats it into two column rows
  // with 3 column gutters on the right and left
  $(document).ready(function(){
    var $this = $('#${randomNamespace}');
    var $container = $this.find('.slider-container');
    var $spacer = $("<div class='col-xl-3 col-md-0'></div>");
    var $largeSpacer = $("<div class='col-xl-5 col-md-8'></div>");
    var $nav = $("<nav class='slider-nav'></nav>");

    var items = $this.find('.partner');
    var container = $('<div class="partner-slide slider-slide"></div>');
    var row = $('<div class="row"></div>');

    function addItem(dom){
      if(dom){
        row.append(dom);
      } else {
        row.append($largeSpacer.clone());
      }
    }

    // one iteration for each row of two items
    for(let i=0; i<Math.ceil(items.length / 2); i++){

      // reset the row element
      container = $('<div class="partner-slide slider-slide"></div>');
      row = $('<div class="row"></div>');

      var $navItem = $('<div class="nav-item"></div>');
      if(i===0){ $navItem.addClass('active'); }
      $navItem.click(function(){
        $container.css('transform', 'translateX(-'+(i*100)+'%)');
        $nav.find('.nav-item.active').removeClass('active');
        $(this).addClass('active');
      });
      $nav.append($navItem);

      // builds a row
      row.append($spacer.clone());
      addItem(items[(i*2)]);
      addItem(items[(i*2)+1]);
      row.append($spacer.clone());

      console.log(container, row, $container);
      container.append(row); // wrapping the bootstrap row
      $container.append(container);
    }

    $this.append($nav);
  });
</script>

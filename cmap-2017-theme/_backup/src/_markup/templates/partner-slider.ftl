<#if Partners.getSiblings()?has_content>
<section class="partner-slider slider" id="${randomNamespace}">

  <header class="row">
    <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
      <div class="buttons">
        <h3>Partner Spotlight</h3>
      </div>
    </div>
  </header>

  <div class="slider-container"></div>
  <#list Partners.getSiblings() as Partner>
    <div class="partner col-xl-4 col-md-8 col-xs-16">
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
    // var $spacer = $("<div class='col-xl-3 col-md-0'></div>");
    // var $largeSpacer = $("<div class='col-xl-5 col-md-8'></div>");
    var $nav = $("<nav class='slider-nav'></nav>");
    var items = $this.find('.partner');
    var container, row, active_row;
    var rows = [];
    var active_index = 0;

    function addItem(dom){
      if(dom){
        row.append(dom);
      }
    }

    function setHeight(index){
      console.log(rows, active_index);
      if(rows[active_index]){

        $container.css('height', rows[active_index].innerHeight());
      } else {
        $container.css('height', 'auto');
      }
    }

    for(let i=0; i<Math.ceil(items.length / 4); i++){

      container = $('<div class="partner-slide slider-slide"></div>');
      row = $('<div class="row"></div>');
      var $navItem = $('<div class="nav-item"></div>');

      $navItem.click(function(){
        $container.css('transform', 'translateX(-'+(i*100)+'%)');
        $nav.find('.nav-item.active').removeClass('active');
        $(this).addClass('active');
        active_index = i;
        setHeight();
      });
      $nav.append($navItem);

      addItem(items[(i*4)])
      addItem(items[(i*4)+1])
      addItem(items[(i*4)+2])
      addItem(items[(i*4)+3])

      rows.push(row);
      container.append(row);
      $container.append(container);

      if(i===0){
        $navItem.addClass('active');
        setHeight();
      }
    }

    $(window).resize(_.throttle(setHeight, 100));

    $this.append($nav);
  });
</script>

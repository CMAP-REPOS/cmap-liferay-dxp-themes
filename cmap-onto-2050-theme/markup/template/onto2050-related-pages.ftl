
<#assign headline = Headline.getData()>
<div id="${randomNamespace}" class="onto2050-related-pages">

  <#if headline != ''>
    <div class="headline-container row">
      <div class="col-md-8 col-md-offset-4">
        <h5>${headline}</h5>
      </div>
    </div>
  </#if>

  <#if PageTitle.getSiblings()?has_content>
    <div class="page-item-container row">
    	<#list PageTitle.getSiblings() as Page>
        <#assign title = Page.getData()>
        <#assign link = Page.PageLink.getData()>
        <#assign description = Page.PageDescription.getData()>
        <div class="page-item">
          <#assign PageDate_Data = getterUtil.getString(Page.PageDate.getData())>
          <#if validator.isNotNull(PageDate_Data)>
            <#assign PageDate_DateObj = dateUtil.parseDate("yyyy-MM-dd", PageDate_Data, locale)>
            <h5 class="page-item-date">${dateUtil.getDate(PageDate_DateObj, "MMMM dd, yyyy", locale)}</h5>
          <#else>
            <h5 class="page-item-date empty">July 26, 2018</h5>
          </#if>
          <#if link != ''> 
            <h4 class="page-item-title"><a class="page-item-link" href="${link}">${title}</a></h4>
          <#else>
            <h4 class="page-item-title">${title}</h4>
          </#if>
          <p class="page-item-description"> ${description} </p>
          <#if link != ''> <a class="page-item-link" href="${link}">Read more</a> </#if>
        </div>
    	</#list>
    </div>
  </#if>

</div>

<script>
Liferay.on(
	'allPortletsReady',
	function() {
    var $this = $('#${randomNamespace}');
    var $items = $this.find('.page-item');
    var $nav = $('<nav class="dot-nav"></nav>');
    var $container = $('<div class="related-pages-container"></div>');
    var center = $this.parents('.portlet-layout').find('> .col-md-8').length;
    var full = $this.parents('.portlet-layout').find('> .col-md-16').length;
    var rows = [];

    var $row = $('<div class="page-item-row row"></div>');
    var $blank_item = $('<div class="page-item"></div>');

    if(full){
      $blank_item.addClass('col-xs-16 col-sm-8 col-md-4');
      $items.addClass('col-xs-16 col-sm-8 col-md-4');
    }
    if(center){
      $blank_item.addClass('col-sm-16 col-md-8');
      $items.addClass('col-sm-16 col-md-8');
    }

    function activate_row(i){
      $this.find('.page-item-row').each(function(index){
        if(index === i){
          $(this).fadeIn();
        } else {
          $(this).hide();
        }
      });
      $this.find('.nav-item').each(function(index){
        if(index === i){
          $(this).addClass('active');
        } else {
          $(this).removeClass('active');
        }
      });
    }

    function new_row(){
      var $nav_item = $('<div class="nav-item"></div>');
      var l = rows.length;
      rows.push($row.clone());
      $container.append($row.clone());

      $nav_item.click(function(){
        activate_row(l)
      });
      $nav.append($nav_item);
      $row = $('<div class="page-item-row row"></div>');
    }
    var normal_count = Math.floor($items.length / 4) * 4;

    $items.each(function(index){
      // normal row with at least 4 items
      if(index < normal_count){
        $row.append($(this));
        if(index % 4 === 3){
          new_row();
        }
      } else {
        switch($items.length % 4){
          case(1):
            $row.append($blank_item.clone());
            $row.append($items[$items.length - 1]);
            $row.append($blank_item.clone());
            $row.append($blank_item.clone());
            new_row();
            return false;
          case(2):
            $row.append($blank_item.clone());
            $row.append($items[$items.length - 2]);
            $row.append($items[$items.length - 1]);
            $row.append($blank_item.clone());
            new_row();
            return false;
          case(3):
            $row.append($blank_item.clone());
            $row.append($items[$items.length - 3]);
            $row.append($items[$items.length - 2]);
            $row.append($items[$items.length - 1]);
            new_row();
            return false;
        }
      }
    });


    $this.append($container);
    $this.append($nav);
    activate_row(0);

    function setCentered(){
      var $headline = $this.find('.headline-container');
      $headline.removeClass('row');
      $headline.find('.col-md-8').removeClass('col-md-8 col-md-offset-4');
    }
    if(center){
      setCentered();
    }
  }
);
</script>


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
            ${dateUtil.getDate(PageDate_DateObj, "MMMM dd, yyyy", locale)}
          </#if>
          <#if link != ''> <a href="${link}"> </#if>
          <h4>${title}</h4>
          <#if link != ''> </a> </#if>
          <p> ${description} </p>
          <#if link != ''> <a href="${link}">Read more</a> </#if>
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
    var center = $this.parents('.portlet-layout').find('> .col-md-8').length;
    var full = $this.parents('.portlet-layout').find('> .col-md-16').length;

    if(full){
      var $row = $('<div class="page-item-row row"></div>');

      $items.each(function(index){
        $(this).addClass('col-xs-16 col-sm-8 col-md-4');
        $row.append($(this));
        if(index === $items.length - 1 || index % 4 === 3){
          var $nav_item = $('<div class="nav-item"></div>')
          $nav.append($nav_item);
          $nav_item.click(function(){
            console.log(this);
          });
          $this.append($row.clone());
          $row = $('<div class="page-item-row row"></div>');
        }
      });

      $($this.find('.page-item-row')[0]).addClass('active');
      $this.append($nav);
    }
    if(center){
      alert('center');
    }
  }
);
</script>

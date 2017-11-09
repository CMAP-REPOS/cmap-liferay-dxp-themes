<#if entries?has_content>
<section class="site-map" id="${randomNamespace}">
  <div class="row">
    <ul class="root-pages col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
      <h1 class="page-title whitney-huge">Sitemap</h1>
      <hr />
    	<#list entries as entry>
        <@buildRow 1 entry />
    	</#list>
    </ul>
  </div>
</section>
</#if>

<#macro buildRow depth page>
  <#assign pageType = page.getLayoutType() />
  <li class="list-item" data-depth="${depth}">
    <div class="icons">
      <div class="close-icon">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
          <g fill="#587387">
            <polygon points="5 10 13 10 13 8 5 8"/>
            <path d="M9,17.5 C4.30585763,17.5 0.5,13.6941424 0.5,9 C0.5,4.30585763 4.30585763,0.5 9,0.5 C13.6941424,0.5 17.5,4.30585763 17.5,9 C17.5,13.6941424 13.6941424,17.5 9,17.5 Z M9,16.5 C13.1418576,16.5 16.5,13.1418576 16.5,9 C16.5,4.85814237 13.1418576,1.5 9,1.5 C4.85814237,1.5 1.5,4.85814237 1.5,9 C1.5,13.1418576 4.85814237,16.5 9,16.5 Z"/>
          </g>
        </svg>
      </div>
      <div class="open-icon">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
          <g fill="#3A5776">
            <path d="M10,8 L10,5 L8,5 L8,8 L5,8 L5,10 L8,10 L8,13 L10,13 L10,10 L13,10 L13,8 L10,8 Z"/>
            <path d="M9,17.5 C4.30585763,17.5 0.5,13.6941424 0.5,9 C0.5,4.30585763 4.30585763,0.5 9,0.5 C13.6941424,0.5 17.5,4.30585763 17.5,9 C17.5,13.6941424 13.6941424,17.5 9,17.5 Z M9,16.5 C13.1418576,16.5 16.5,13.1418576 16.5,9 C16.5,4.85814237 13.1418576,1.5 9,1.5 C4.85814237,1.5 1.5,4.85814237 1.5,9 C1.5,13.1418576 4.85814237,16.5 9,16.5 Z"/>
          </g>
        </svg>
      </div>
    </div>
    <div class="list-item-text">
      <#if pageType.isBrowsable()>
        <a href="${portalUtil.getLayoutURL(page, themeDisplay)}">
          ${page.getName(locale)}
        </a>
        <hr />
      <#else>
        <span>
          ${page.getName(locale)}
        </span>
        <hr />
      </#if>

      <@displayPages depth=depth+1 pages=page.getChildren() />
    </div>
  </li>
</#macro>

<#macro displayPages depth pages>
	<#if pages?has_content && ((depth < displayDepth?number) || (displayDepth?number == 0))></#if>

	<ul class="child-pages">
		<#list pages as page>
      <@buildRow depth page />
		</#list>
	</ul>
</#macro>

<script>
$(function() {

  // hide icons that we don't need
  $('#${randomNamespace} .list-item').each(function(){
    if(!$(this).find('.child-pages').length){
      $(this).find('.icons').hide();
    }
  });
  $('.portlet-site-map ul li').each(function() {
    var $item = $(this);
    if ($('> .child-pages', $item).length) {
      $('> a', $item).before('<a href="#" class="toggler collapsed"><i class="icon-plus-sign"></i></a> ');
    } else {
      $('> a', $item).before('<i class="icon-sign-blank"></i> ');
    }
  });

  $('.open-icon').click(function(){
    var $this = $(this);
    var list = $this.parent().parent().find('> .list-item-text > ul');
    var closeIcon = $this.parent().find('.close-icon');
    list.slideDown();
    closeIcon.show();
    $this.hide();
  });
  $('.close-icon').click(function(){
    var $this = $(this);
    var list = $this.parent().parent().find('> .list-item-text > ul');
    var openIcon = $this.parent().find('.open-icon');
    list.slideUp();
    openIcon.show();
    $this.hide();
  });

  $('.toggler').on('click', function(e) {
     e.preventDefault();
     var $this = $(this);
     if ($this.hasClass('collapsed')) {
       $this.siblings('ul').slideDown();
     } else {
       $this.siblings('ul').slideUp();
     }
     $this.toggleClass('collapsed');
     $this.find('i').toggleClass('icon-plus-sign').toggleClass('icon-minus-sign');
  });

  $('ul li ul').slideUp();
});
</script>

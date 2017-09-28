<div class="container-fluid">
  <div class="row-fluid">
    <div class="span8 the-content">
      <#if Title.getData() != "">
        <h1>${Title.getData()}</h1>
      </#if>
      <#list Subtitle.getSiblings() as section>
        <div class="clearfix">
          <#if section.getData() != "">
            <h2 id="${section.getData()?replace(" ", "_")}">${section.getData()}</h2>
          </#if>
          ${section.Body.getData()}
        </div>
      </#list>
    </div>
    <div class="span4 in-page-anchors">
      <div class="span8 pull-right">
        <ul class="items">
          <#list Subtitle.getSiblings() as section>
            <#if section.getData() != "">
              <li>
                <a href="${section.getData()?replace(" ", "_")}">${section.getData()}</a>
              </li>
            </#if>
          </#list>
        </ul>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
(function($) {
  $('body').addClass('structured-template');
})(jQuery);
</script>

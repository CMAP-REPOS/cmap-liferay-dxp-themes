<#if Section.getSiblings()?has_content>
<section class="split-summary" id="${randomNamespace}">
	<div class="row">
		<#list Section.getSiblings() as S>
      <div class="item">

        <#if S.Title.getData()?? && S.Title.getData() != "">
					<#if S.CallToActionPage.getFriendlyUrl() != ''>
	        	<h3> <a href="${S.CallToActionPage.getFriendlyUrl()}"> ${S.Title.getData()} </a> </h3>

					<#elseif S.CallToActionLink.getData()?? && S.CallToActionLink.getData() != "">
						<h3> <a href="${S.CallToActionLink.getData()}"> ${S.Title.getData()} </a> </h3>

					<#else>
						<h3>${S.Title.getData()}</h3>
					</#if>
				</#if>

				<#if S.Description.getData()?? && S.Description.getData() != "">
          <div class="summary-description">
            ${S.Description.getData()}
          </div>
				</#if>

        <#if S.CallToActionPage.getFriendlyUrl() != ''>
          <a class="read-more-link" href="${S.CallToActionPage.getFriendlyUrl()}">
          	Read More
          </a>
        </#if>

				<#if S.CallToActionPage.getFriendlyUrl() == ''>
					<#if S.CallToActionLink.getData()?? && S.CallToActionLink.getData() != "" >
	          <a class="read-more-link" href="${S.CallToActionLink.getData()}">
	          	Read More
	          </a>
					</#if>
        </#if>

      </div>

		</#list>
	</div>
</section>
</#if>

<script>
$(document).ready(function(){
	var $this = $('#${randomNamespace}');
	var $row = $this.find('.row');
	var $items = $this.find('.item');

	$items.each(function(){

		var classes = null;
		switch($items.length){
			case(1):
			  classes = "col-xl-16";
				break;
			case(2):
				classes = "col-xl-8";
				break;
			case(3):
				alert('Please add a different number of summaries in the Split Summary widget. Three items does not fit in the grid, please use two items or four items');
				break;
			case(4):
				classes = "col-xl-4";
				break;
		}

		$(this).addClass(classes);
	});
});
</script>

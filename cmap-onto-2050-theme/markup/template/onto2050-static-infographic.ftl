<#assign itemsArray = []>

<#list Infographic.getSiblings() as cur_Infographic>
	<#assign itemImage = "">
	<#assign itemDescription = "">
	<#assign itemWidth = "">

	<#if cur_Infographic.Image?? && cur_Infographic.Image.getData() ?? && cur_Infographic.Image.getData() != "">
		<#assign itemImage = cur_Infographic.Image.getData()>
	</#if>

	<#if cur_Infographic.Image?? && cur_Infographic.Image.getAttribute("alt") ?? && cur_Infographic.Image.getAttribute("alt") != "">
		<#assign itemDescription = cur_Infographic.Image.getAttribute("alt")>
	</#if>

	<#if cur_Infographic.ontoWidth?? && cur_Infographic.Width.getData() ?? && cur_Infographic.Width.getData() != "">
		<#assign itemWidth = cur_Infographic.Width.getData()>
	</#if>

	<#if itemImage != "">
	<#assign itemsArray = itemsArray + [{
		"itemImage": itemImage,
		"itemDescription": itemDescription,
		"itemWidth": itemWidth
	}]>
	</#if>
</#list>

<div class="static-map-2050-container">
	<div class="row">
		<#if itemsArray?size != 0>
			<#list itemsArray as item>
				<#if item.itemWidth == "half">
					<div class="col-sm-16 col-md-8">
						<div class="static-map-2050-map-container">
							<#if item.itemImage != "">
								<img class="static-map-2050-map-image" alt='${itemDescription}' src="${item.itemImage}" style="max-width:400px;" />
							</#if>
						</div>
					</div>
				<#else>
					<div class="col-sm-16 col-md-16">
						<div class="static-map-2050-map-container">
							<#if item.itemImage != "">
								<img class="static-map-2050-map-image" alt='${itemDescription}' src="${item.itemImage}" style="max-width:800px;" />
							</#if>
						</div>
					</div>
				</#if>
			</#list>
		</#if>
	</div>
</div>
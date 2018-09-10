<#-- Freemarker can report false positives for list content, so create a custom key array -->
<#assign keyArray = []>
<#assign webContentId = .vars['reserved-article-id'].data />

<#list KeyItem.getSiblings() as cur_KeyItem>
	<#assign keyName = "">
	<#assign keyImage = "">
	<#assign keyAlt = "">
	<#assign keyColor = "#FFF">

	<#if cur_KeyItem.KeyItemName?? && cur_KeyItem.KeyItemName.getData() ?? && cur_KeyItem.KeyItemName.getData() != "">
		<#assign keyName = cur_KeyItem.KeyItemName.getData()>
	</#if>

	<#if cur_KeyItem.KeyItemImage?? && cur_KeyItem.KeyItemImage.getData() ?? && cur_KeyItem.KeyItemImage.getData() != "">
		<#assign keyImage = cur_KeyItem.KeyItemImage.getData()>
	</#if>

	<#if cur_KeyItem.KeyItemImage?? && cur_KeyItem.KeyItemImage.getAttribute("alt") ?? && cur_KeyItem.KeyItemImage.getAttribute("alt") != "">
		<#assign keyAlt = cur_KeyItem.KeyItemImage.getAttribute("alt")>
	</#if>

	<#if cur_KeyItem.KeyItemColor?? && cur_KeyItem.KeyItemColor.getData() ?? && cur_KeyItem.KeyItemColor.getData() != "">
		<#assign keyColor = cur_KeyItem.KeyItemColor.getData()>
	</#if>

	<#if keyName != "">
	<#assign keyArray = keyArray + [{
		"keyName": keyName,
		"keyImage": keyImage,
		"keyAlt": keyAlt,
		"keyColor": keyColor
	}]>
	</#if>
</#list>

<div class="chart-legend-2050">
	<#if Description.getData()?has_content && Description.getData() != "">
		<div class="chart-legend-2050-description">
		<#if LegendType?? && LegendType.getData()?? && LegendType.getData()?has_content && LegendType.getData() != "">
			<div class="chart-legend-2050-section-title">${LegendType.getData()}</div>
		</#if>
		<#if LinkToDataHub?? && LinkToDataHub.getData()?? && LinkToDataHub.getData() != "">
			<div class="sr-only">Graphical representation of data follows. You can <a href="#download-link-${webContentId}">skip to data download</a></div>
		</#if>
		<div>${Description.getData()}</div>
		</div>
	</#if>
		
	<#if keyArray?size != 0>
		<div class="chart-legend-2050-key">
		<div class="chart-legend-2050-section-title">Key</div>
		<ul class="list-unstyled chart-legend-2050-key-list">
			<#list keyArray as key>
			<li>
				<#if key.keyImage != "">
				<img class="chart-legend-2050-key-image" src="${key.keyImage}" alt="${key.keyAlt}">
				<#else>
				<span class="chart-legend-2050-key-image" style="background-color: ${key.keyColor}">&nbsp;</span>
				</#if>
				<span class="chart-legend-2050-key-label">${key.keyName}</span>
			</li>
			</#list>
		</ul>
		</div>
	</#if>

	<#if Source.getData()?has_content && Source.getData() != "">
		<div class="chart-legend-2050-source">
		<div class="chart-legend-2050-section-title">Source</div>
		${Source.getData()}
		</div>
	</#if>

	<#if LinkToDataHub?? && LinkToDataHub.getData()?? && LinkToDataHub.getData() != "">
		<div class="chart-legend-2050-download">
			<a name="download-link-${webContentId}"></a>
			<a href="${LinkToDataHub.getData()}">
				<svg xmlns="http://www.w3.org/2000/svg" width="22" height="30" viewBox="0 0 22 30">
					<g fill="#3C5976" transform="translate(-1 6)">
						<path d="M2.88,15.381 L13.184,15.381 L13.184,13.119 L2.88,13.119 L2.88,15.381 Z M14.944,11.359 L14.944,17.141 L1.12,17.141 L1.12,11.359 L14.944,11.359 Z"/>
						<path d="M8.9124,10.82 C8.9124,11.3060106 8.51841058,11.7 8.0324,11.7 C7.54638942,11.7 7.1524,11.3060106 7.1524,10.82 L7.1524,2 C7.1524,1.51398942 7.54638942,1.12 8.0324,1.12 C8.51841058,1.12 8.9124,1.51398942 8.9124,2 L8.9124,10.82 Z"/>
						<path d="M10.6068201,7.96600256 C10.9739776,7.64756628 11.5297612,7.68706263 11.8481974,8.05422012 C12.1666337,8.42137761 12.1271374,8.97716117 11.7599799,9.29559744 L8.03358295,12.5275074 L4.305029,9.29577855 C3.93777149,8.97745763 3.89810054,8.42168651 4.21642145,8.054429 C4.53474237,7.68717149 5.09051349,7.64750054 5.457771,7.96582145 L8.03321705,10.1980926 L10.6068201,7.96600256 Z"/>
					</g>
				</svg>
				<span>Download the Data</span>
			</a>
		</div>
	</#if>
</div>

<style>
body.default-theme .chart-legend-2050 .chart-legend-2050-download a {
	color: #5D7A90;
	border: none;
}
</style>
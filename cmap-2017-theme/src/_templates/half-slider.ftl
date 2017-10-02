<#if HalfSlides.getSiblings()?has_content>
<section class="half-slider">
	<div class="slide">
		<div class="row">
			<#list HalfSlides.getSiblings() as Slide>
				<div class="col-xl-8">
					<#if Slide.SlideImage.getData()?? && Slide.SlideImage.getData() != "">
						<img class="slide-image" data-fileentryid="${Slide.SlideImage.getAttribute("fileEntryId")}" alt="${Slide.SlideImage.getAttribute("alt")}" src="${Slide.SlideImage.getData()}" />
					</#if>
					<div class="slide-text">
						<#if Slide.SlideText?has_content>
							<h2 class="slide-title">${Slide.SlideText.getData()}</h2>
						</#if>
						<#if Slide.SlideDescription?has_content>
							<p  class="slide-description">${Slide.SlideDescription.getData()}</p>
						</#if>
					</div>
				</div>
			</#list>
		</div>
	</div>
</section>

</#if>

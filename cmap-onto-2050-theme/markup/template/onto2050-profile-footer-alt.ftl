<section class="profile-footer-alt row">
	<#if Background.getData()?? && Background.getData() != "">
		<img class="widget-background" data-fileentryid="${Background.getAttribute("fileEntryId")}" alt="${Background.getAttribute("alt")}" src="${Background.getData()}" />
	</#if>
	<#if Text.getData()?? && Text.getData() != "">
	<div class="profile-footer-content row">
		<div class="col-lg-8 col-lg-push-4 col-md-10 col-md-push-3 col-sm-16">
			<div class="profile-footer-inner-content">
				${Text.getData()}
			</div>
		</div>
	</div>
	</#if>
</section>

<#--<#include "${templatesPath}/875701">-->
<#include "${templatesPath}/848954">

<#assign background = validate_field(Background.getData())>
<#assign content = validate_field(Content.getData())>

<div class="advertisement">
	<div class="row">
		<div class="col-md-offset-8 col-md-8 col-sm-offset-0 col-sm-12 col-xs-16">
			<div class="cmap-ad-content">
				<#if content != ''>
					${content}
				</#if>
			</div>
		</div>
	</div>
	<#if background != "">
		<img class="background" data-fileentryid="${Background.getAttribute("fileEntryId")}" alt="${Background.getAttribute("alt")}" src="${Background.getData()}" />
	<#else>
		<div class="placeholder-background"></div>
	</#if>
</div>

<script>
Liferay.on(
	'allPortletsReady',
	function() {
		function set_advertisement(){
			var $this = $(this);
			var height = $this.outerWidth() * 0.5;
			var min_height = $this.find('.cmap-ad-content').outerHeight();
			$this.css('height', height);
			$this.css('min-height', min_height);
		}
		function handle_resize(e){
			$('.advertisement').each(set_advertisement);
		}
		$(window).resize(_.throttle(handle_resize, 100));
		handle_resize();
	}
);
</script>

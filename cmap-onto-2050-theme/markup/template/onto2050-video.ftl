<#if CaptionPosition.getData() == 'top-right' || CaptionPosition.getData() == 'top-left'>
  <#assign top_bottom = 'top'>
<#else>
  <#assign top_bottom = 'bottom'>
</#if>

<#assign classes = ["onto2050-video-widget"]>

<#if MakeResponsive?? && getterUtil.getBoolean(MakeResponsive.getData())>
	<#assign classes = classes + ["responsive"]>
</#if>

<div id="${randomNamespace}" class="${classes?join(" ")}">
	<div class="video-container">
		<#if Embed.getData() != ''>
				${Embed.getData()}
		<#elseif VideoFile.getData() != ''>
			<video controls>
				<source src="${VideoFile.getData()}" type='video/mp4' />
				<#if CoverImage.getData() != "">
				<img alt='${CoverImage.getAttribute("alt")}' src="${CoverImage.getData()}" width="100%" title="Your browser does not support the <video> tag">
				</#if>
			</video>
		<#else>
			<h1> There is an error with this video widget, please specifiy a video </h1>
		</#if>
		<#if CoverImage.getData() != "" && CoverImage.FallbackOnly?? && !getterUtil.getBoolean(CoverImage.FallbackOnly.getData())>
			<div class="cover-photo" style="background: url('${CoverImage.getData()}')">
				<span class="sr-only">${CoverImage.getAttribute("alt")}</span>
				<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="150" height="150" viewBox="0 0 50 50" style="enable-background:new 0 0 50 50;"> <path stroke="#fff" d="M25,15c-5.51,0-10,4.49-10,10c0,5.51,4.49,10,10,10s10-4.49,10-10C35,19.49,30.51,15,25,15z M25,34.5 c-5.24,0-9.5-4.26-9.5-9.5c0-5.24,4.26-9.5,9.5-9.5s9.5,4.26,9.5,9.5C34.5,30.24,30.24,34.5,25,34.5z"/> <polygon fill="#fff" points="22.08,29.87 30.18,25.14 22.08,20.42 		"/> </svg>
			</div>
		</#if>
		<#if Caption.getData() != ''>
			<div class="caption-row ${top_bottom}">
				<#if CaptionPosition.getData() == "bottom-right" || CaptionPosition.getData() == "top-right">
					<div class="col-md-8 col-md-offset-8">
						<div class="picture-caption right">
							${Caption.getData()}
						</div>
					</div>
				<#else>
					<div class="col-md-8">
						<div class="picture-caption left">
							${Caption.getData()}
						</div>
					</div>
				</#if>
			</div>
		</#if>
	</div>
</div>

<script>
Liferay.on(
	'allPortletsReady',
	function() {
		var $this = $('#${randomNamespace}');
		var $caption = $this.find('.caption-row');
		var $iframe = $this.find('iframe');

		var is_full_width = $iframe.parents('.portlet-layout').find('.col-md-16').length > 0 ? true : false;
		var iframe_width, iframe_height;

		function get_iframe_size(){
			iframe_width = $iframe.attr('width');
			iframe_height = $iframe.attr('height');
		}
		function set_iframe_size() {
			if (is_full_width) {
				$iframe.css('width', window.innerWidth);
				$iframe.css('height', (window.innerWidth / iframe_width) * iframe_height);
				$this.find('.video-container').addClass('row');

				var $foo = $caption.find('.col-md-8');
				$foo.removeClass('col-md-8').addClass('col-md-5');
				if ($foo.hasClass('col-md-offset-8')) {
					$foo.removeClass('col-md-offset-8').addClass('col-md-offset-11');
				}

			} else {
				var width = $iframe.parents('.portlet-layout').find('.col-md-8 .portlet-dropzone').innerWidth();
				$iframe.css('width', width);
				$iframe.css('height', (width / iframe_width) * iframe_height);
			}
		}

		get_iframe_size();
		set_iframe_size();
		$(window).resize(_.throttle(function(){
			get_iframe_size();
			set_iframe_size();
		}, 100));

		$('.cover-photo svg').click(function(){
			$('.cover-photo').fadeOut();
		});
	}
);
</script>
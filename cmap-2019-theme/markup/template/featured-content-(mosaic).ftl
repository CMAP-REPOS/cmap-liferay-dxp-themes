<#if content.getSiblings()?has_content>
    <#assign listSize=content.getSiblings()?size />
    <#if listSize==1>
        <#assign containerClass="b-featured-mosaic--single" />
    </#if>
    <#if listSize==2>
        <#assign containerClass="b-featured-mosaic--pair" />
    </#if>
    <#if listSize==3>
        <#assign containerClass="b-featured-mosaic--triple" />
    </#if>
    <#if listSize gt 3>
        <#assign containerClass="b-featured-mosaic--multiple" />
    </#if>
    <#if title?has_content && title.getData() !="">
		<!--h1>${title.getData()}</h1-->
    </#if>

	<section id="${randomNamespace}" class="b-featured-mosaic ${containerClass}">
        <#list content.getSiblings() as item>
            <#assign linkUrl="" />
            <#assign videoUrl="" />
            <#assign hasVideoClass="" />
            <#if item.link?has_content>
                <#assign linkUrl=item.link.getFriendlyUrl() />
            </#if>
            <#if item.video?has_content && item.video.getData() !="">
                <#assign videoUrl="data-video=\" ${item.video.getData()}\"" />
                <#assign hasVideoClass="b-mosaic-item--has-video" />
            </#if>
			<div class="b-mosaic-item" data-index="${item?counter}">
				<div class="b-mosaic-item__thumbnail ${hasVideoClass}" ${videoUrl} data-title="${item.contentTitle.getData()}" style="background-image: url('${item.thumbnail.getData()}')">
                    <span class="sr-only">
                        ${item.contentTitle.getData()}
                    </span>
					<svg xmlns="http://www.w3.org/2000/svg" width="72" height="72" viewBox="0 0 72 72">
						<title>video-player-cue</title>
						<path d="M46.875,35,29.062,46.875V23.125ZM64.131,23.867A11.867,11.867,0,0,0,62,17.558a6.611,6.611,0,0,0-5.288-2.968,316.755,316.755,0,0,0-43.418,0,7.317,7.317,0,0,0-5.1,3.432,12.063,12.063,0,0,0-2.319,6.216,122.823,122.823,0,0,0,0,21.338,12.269,12.269,0,0,0,2.319,6.4,7.322,7.322,0,0,0,5.1,3.433,317.154,317.154,0,0,0,43.418,0,8.105,8.105,0,0,0,5.1-3.526,11.782,11.782,0,0,0,2.32-6.308,127.328,127.328,0,0,0,0-21.709" fill="#fff" />
					</svg>
				</div>
				<h2 class="b-mosaic-item__title">
                    <#if linkUrl!="">
						<a href="${linkUrl}">
                            ${item.contentTitle.getData()}
						</a>
                    <#else>
                        ${item.contentTitle.getData()}
                    </#if>
				</h2>
                <#if item.description?has_content>
					<p style="padding-bottom: 0px; margin-bottom: 0px;" class="b-mosaic-item__description">
                        ${item.description.getData()}
					</p>
                </#if>
			</div>
			<hr class="mobile-hr">
        </#list>
		<div class="b-video-overlay" style="display: none;">
			<div class="b-video-overlay__container">
				<div class="b-video-overlay__close">X</div>
				<div class="b-video-overlay__header">
					<h2 class="b-video-overlay__title">
						Watch Video
					</h2>
					<a class="b-video-overlay__link" href="#" target="_blank">
						Watch on YouTube
					</a>
				</div>
				<div class="b-video-overlay__body">
				</div>
			</div>
		</div>
	</section>
</#if>

<script>
    (function(){
        var $container = $('#${randomNamespace}');
        var $videoContainer = $container.find('.b-mosaic-item--has-video');
        var $overlay = $container.find('.b-video-overlay');
        var $closeOverlay = $overlay.find('.b-video-overlay__close');
        var $overlayTitle = $overlay.find('.b-video-overlay__title');
        var $overlayLink = $overlay.find('.b-video-overlay__link');
        var $overlayBody = $overlay.find('.b-video-overlay__body');


        $videoContainer.each(function(){
            var $videoItem = $(this);
            var videoUrl = $videoItem.attr('data-video').trim();
            var title = $videoItem.attr('data-title').trim();

            console.log(videoUrl);
            var videoIdRegex = videoUrl.indexOf('?v=') > 0 ? /.*watch\?v=(.*)/g : /.*be\/(.*)/g;
            var match = videoIdRegex.exec(videoUrl);

            console.log(match[1]);




            $videoItem.on('click',function(){
                $overlayTitle.text(title);
                var iframeHTML = '<iframe src="https://www.youtube.com/embed/'+match[1]+'" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>';
                $overlayLink.attr('href',videoUrl);
                $overlay.show();
                $overlayBody.empty().append(iframeHTML);
                $('body').css('overflow','hidden');
            })
        })

        $closeOverlay.on('click',function(){
            $overlay.hide();
            $overlayBody.empty();
            $('body').css('overflow','initial');
        })



    })();
</script>
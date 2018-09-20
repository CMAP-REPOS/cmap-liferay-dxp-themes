<div id="${randomNamespace}" class="onto2050-video-widget">
  <div class="video-container">
    
    <div class="embed-video-container">
      <div id="${randomNamespace}video"></div>
    </div>
    
    <#if CoverImage.getData() != "">
      <div class="cover-photo" style="background: url('${CoverImage.getData()}')">
        <span class="sr-only">${CoverImage.getAttribute("alt")}</span>
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="150" height="150" viewBox="0 0 50 50" style="enable-background:new 0 0 50 50;"> 
          <path stroke="#fff" d="M25,15c-5.51,0-10,4.49-10,10c0,5.51,4.49,10,10,10s10-4.49,10-10C35,19.49,30.51,15,25,15z M25,34.5 c-5.24,0-9.5-4.26-9.5-9.5c0-5.24,4.26-9.5,9.5-9.5s9.5,4.26,9.5,9.5C34.5,30.24,30.24,34.5,25,34.5z"/> <polygon fill="#fff" points="22.08,29.87 30.18,25.14 22.08,20.42 		"/> 
        </svg>
      </div>
    </#if>
  </div>
</div>


<script>
if(!window.video_frames){
  window.video_player = [null];
  window.video_frames = ['${Embed.getData()}'];
  window.video_ids = ['#${randomNamespace}'];
  window.video_autoplay = ['${Autoplay.getData()}'];
  window.video_loop = ['${Loop.getData()}'];
} else {
  window.video_player[window.video_player.length] = null;
  window.video_frames[window.video_frames.length] = '${Embed.getData()}';
  window.video_ids[window.video_ids.length]  = '#${randomNamespace}';
  window.video_autoplay[window.video_autoplay.length] = '${Autoplay.getData()}';
  window.video_loop[window.video_loop.length] = '${Loop.getData()}';
}
</script>

<script>
Liferay.on(
	'allPortletsReady',
	function() {

    var iframe_tag = '${Embed.getData()}';
    var is_youtube = window.youtube_url_parser(iframe_tag);

    if(is_youtube){
      var tag = document.createElement('script');
      tag.src = "https://www.youtube.com/iframe_api";
      var firstScriptTag = document.getElementsByTagName('script')[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    } else {
      $('#${randomNamespace}video').html(iframe_tag);
      window.set_iframe_video_size($('#${randomNamespace}video iframe'));
    }

    $('.cover-photo svg').click(function(){
      $('.cover-photo').fadeOut();
    });
  }
);
</script>


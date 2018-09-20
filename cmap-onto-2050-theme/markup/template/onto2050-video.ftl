<div id="${randomNamespace}" class="onto2050-video-widget">
  <div class="video-container">
    
    <div class="embed-video-container">
      <div id="video-node"></div>
    </div>

    <script src="https://www.youtube.com/iframe_api"></script>
    
    <#if CoverImage.getData() != "">
      <div class="cover-photo" style="background: url('${CoverImage.getData()}')">
        <span class="sr-only">${CoverImage.getAttribute("alt")}</span>
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="150" height="150" viewBox="0 0 50 50" style="enable-background:new 0 0 50 50;"> <path stroke="#fff" d="M25,15c-5.51,0-10,4.49-10,10c0,5.51,4.49,10,10,10s10-4.49,10-10C35,19.49,30.51,15,25,15z M25,34.5 c-5.24,0-9.5-4.26-9.5-9.5c0-5.24,4.26-9.5,9.5-9.5s9.5,4.26,9.5,9.5C34.5,30.24,30.24,34.5,25,34.5z"/> <polygon fill="#fff" points="22.08,29.87 30.18,25.14 22.08,20.42 		"/> </svg>
      </div>
    </#if>
  </div>
</div>


<script>
function youtube_url_parser(url){
  var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
  var match = url.match(regExp);
  return (match&&match[7].length==11)? match[7] : false;
}

var player;
function onYouTubeIframeAPIReady() {
  var video_id = youtube_url_parser('${Embed.getData()}');
  player = new YT.Player('video-node', {
    width: 1280,
    height: 720,
    videoId: video_id,
    playerVars: {
      <#if Autoplay.getData() == 'true'>
      autoplay: 1,
      </#if>
      <#if Loop.getData() == 'true'>
      loop: 1,
      playlist: video_id,
      </#if>
      controls: 1,
      modestbranding: 1,
      rel: 0,
      showinfo: 0,
    }, 
    events: {
      'onReady': onPlayerReady,
    }
  });
}

function onPlayerReady(){
  window.set_iframe_video_size();
}
</script>

<script>
Liferay.on(
	'allPortletsReady',
	function() {

    window.set_iframe_video_size = function(){
      var $this = $('#${randomNamespace}');
      var $iframe = $this.find('iframe');

      var is_full_width = $this.parents('.portlet-layout').find('.col-md-16').length > 0 ? true : false;
      var iframe_width, iframe_height;

      function get_iframe_size(){
        iframe_width = $iframe.attr('width');
        iframe_height = $iframe.attr('height');
      }

      function set_iframe_size(){
        if(is_full_width){
          $iframe.css('width', window.innerWidth);
          $iframe.css('height', (window.innerWidth / iframe_width) * iframe_height);
          $this.find('.video-container').addClass('row');

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
    }
    
    var tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    $('.cover-photo svg').click(function(){
      $('.cover-photo').fadeOut();
    });
  }
);
</script>


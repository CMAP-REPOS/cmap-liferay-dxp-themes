$('.iframe-container iframe').each(function(){
  var $this = $(this);

  function addLodash(){
    var head = document.getElementsByTagName('head')[0];
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = 'https://raw.githubusercontent.com/lodash/lodash/4.17.4/dist/lodash.core.min.js';
    head.appendChild(script);
  }

  function setHeight(el){
    var ratio = parseFloat($this.attr('longdesc'), 10);
    var width = $this.innerWidth();
    var height = Math.floor(width / ratio);
    $this.css('height', height);
  }

  function findID(src){
    var code_offset = src.indexOf('/embed/');
    if(code_offset >= 0){
      // remove the beginning of the URL
      var final = src.substring(code_offset + 7);

      // finds params if they are included
      var or = final.indexOf('?');
      var and = final.indexOf('&');
      var end = or > and ? and : or;

      // remove the end of the URL
      if(end){ final = final.substring(0,end); }
      return final;
    }
  }

  function addVideoTagline(data){
    var title = data.items[0].snippet.title;
    var link = `https://youtu.be/${data.items[0].id}`;
    var $container = $('<div class="video-tagline"></div>');
    var $icon = $('<div class="icon"> <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"> <g fill="#3C5976" fill-rule="evenodd"> <path fill-rule="nonzero" d="M9,17.5 C4.30585763,17.5 0.5,13.6941424 0.5,9 C0.5,4.30585763 4.30585763,0.5 9,0.5 C13.6941424,0.5 17.5,4.30585763 17.5,9 C17.5,13.6941424 13.6941424,17.5 9,17.5 Z M9,16.5 C13.1418576,16.5 16.5,13.1418576 16.5,9 C16.5,4.85814237 13.1418576,1.5 9,1.5 C4.85814237,1.5 1.5,4.85814237 1.5,9 C1.5,13.1418576 4.85814237,16.5 9,16.5 Z"/> <polygon points="6.8 5.75 6.8 12.25 12.8 8.75"/> </g> </svg> </div>');
    var $data = $('<div class="video-data"> <span> Watch <a href="'+link+'" target="_blank">'+title+'</a> </span> </div>');
    $container.append($icon);
    $container.append($data);
    $this.parent().append($container);
  }

  function addVideoCaption(){
    var vid = findID($this.attr('src'));
    $.getJSON("https://www.googleapis.com/youtube/v3/videos", {
      key: "AIzaSyC7Ab6y-6mvks4oPwdc4vMkXoKFQXBsc5E",
      part: "snippet,statistics",
      id: vid
    }, function(data) {
      if (data.items.length === 0) {
        console.error('YOUTUBE: ', 'Problem finding the video you want.');
        return;
      }
      addVideoTagline(data);
    }).fail(function(jqXHR, textStatus, errorThrown) {
      console.error('YOUTUBE: ', 'Problem making a request to get video metadata.');
    });
  }

  addLodash();
  var self = this;
  setHeight(self);
  $(window).resize(_.debounce(function(){
    setHeight(self);
  }, 100));

  addVideoCaption();

});

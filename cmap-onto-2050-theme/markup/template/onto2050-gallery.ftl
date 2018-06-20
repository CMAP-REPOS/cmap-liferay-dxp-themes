
<#assign unique = randomNamespace>
<div id="${unique}" class="onto2050-gallery row">
  <#if Image.getSiblings()?has_content>

    <#list Image.getSiblings() as Slide>
      <#if Slide.getData()?? && Slide.getData() != "">
        <#assign caption = Slide.Caption.getData()>
        <img class="slide" data-fileentryid="${Slide.getAttribute("fileEntryId")}" alt="${Slide.getAttribute("alt")}" data-caption="${caption}" src="${Slide.getData()}" />
      </#if>
  	</#list>

    <div class="gallery-container col-sm-16">
      <div class="gallery-root">
        <div class="gallery-controls">
          <div class="left">
            <svg class="svg-icon" width="20" height="20" viewBox="0 0 20 20"> <path fill="#fff" d="M8.388,10.049l4.76-4.873c0.303-0.31,0.297-0.804-0.012-1.105c-0.309-0.304-0.803-0.293-1.105,0.012L6.726,9.516c-0.303,0.31-0.296,0.805,0.012,1.105l5.433,5.307c0.152,0.148,0.35,0.223,0.547,0.223c0.203,0,0.406-0.08,0.559-0.236c0.303-0.309,0.295-0.803-0.012-1.104L8.388,10.049z"></path> </svg>
          </div>
          <div class="right">
            <svg class="svg-icon" width="20" height="20" viewBox="0 0 20 20"> <path fill="#fff" d="M11.611,10.049l-4.76-4.873c-0.303-0.31-0.297-0.804,0.012-1.105c0.309-0.304,0.803-0.293,1.105,0.012l5.306,5.433c0.304,0.31,0.296,0.805-0.012,1.105L7.83,15.928c-0.152,0.148-0.35,0.223-0.547,0.223c-0.203,0-0.406-0.08-0.559-0.236c-0.303-0.309-0.295-0.803,0.012-1.104L11.611,10.049z"></path> </svg>
          </div>
        </div>
      </div>
      <div class="nav-container"></div>
    </div>
    <div class="caption-container col-sm-16"></div>
  </#if>
</div>


<script>
Liferay.on(
	'allPortletsReady',
	function() {
    var $gallery = $('#${unique}');
    var $img_container = $gallery.find('.gallery-container .gallery-root');
    var $caption_container = $gallery.find('.caption-container ');
    var $nav_container = $gallery.find('.nav-container ');
    var $slides = $gallery.find('.slide');
    var slide_data = [];
    var current_slide = 0;
    var is_full_width = $gallery.parents('.col-md-16').length ? true : false;

    function set_active_slide(index){
      var element = slide_data[index];
      $img_container.css('height', element.height);
      $caption_container.css('height', element.caption_height);

      $caption_container.find('.caption').addClass('invis');
      element.caption.removeClass('invis');

      $nav_container.find('.nav-item').removeClass('active');
      $nav_container.find('.nav-item[data-index="'+index+'"]').addClass('active');
      
      $slides.each(function(){
        if(this == element.el){
          $(this).removeClass('invis');
        } else {
          $(this).addClass('invis');
        }
      });
    }

    function next_slide(){
      if(current_slide + 1 > slide_data.length - 1){
        current_slide = 0;
      } else {
        current_slide += 1;
      }
      set_active_slide(current_slide);
    }
    function prev_slide(){
      if(current_slide - 1 < 0){
        current_slide = slide_data.length - 1;
      } else {
        current_slide -= 1;
      }
      set_active_slide(current_slide);
    }

    function init_gallery(){
      $slides.each(function(index){
        var $slide = $(this);
        var caption = $slide.data('caption');
        var $caption = $('<div class="caption"></div>');
        var $nav = $('<div class="nav-item"></div>');

        $slide.addClass('invis');
        $slide.remove();
        $img_container.prepend($slide);

        if(is_full_width){
          $caption.addClass('col-sm-offset-8');
          $caption.addClass('col-sm-4');
        } else {
          $caption.addClass('col-sm-offset-8');
          $caption.addClass('col-sm-8');
        }
        if($slide.data('caption') == ''){
          $caption.addClass('empty');
        }

        $caption.text($slide.data('caption'));
        $caption_container.append($caption);
        $caption.addClass('invis');

        $nav.click(function(){
          set_active_slide($(this).data('index'));
        });
        $nav.attr('data-index', index);
        $nav_container.append($nav);

        var this_data = {
          height: $slide.innerHeight(),
          caption_height: $caption.innerHeight(),
          caption: $caption,
          el: this,
        };

        slide_data.push(this_data);
      });

      if($slides.length === 1){
        $gallery.find('.gallery-controls').hide();
      }

      $gallery.find('.gallery-controls .left').click(prev_slide);
      $gallery.find('.gallery-controls .right').click(next_slide);
    }

    function recompute_heights(){
      $slides.each(function(index){
        var $slide = $(this);
        // console.log(slide_data[index], $slide.innerHeight());
        slide_data[index].height = $slide.innerHeight();
        slide_data[index].caption_height = slide_data[index].caption.innerHeight();
      });
      set_active_slide(current_slide);
    }

    $(window).on('resize', _.throttle(recompute_heights, 100));
    init_gallery();
    set_active_slide(current_slide);
	}
);
</script>

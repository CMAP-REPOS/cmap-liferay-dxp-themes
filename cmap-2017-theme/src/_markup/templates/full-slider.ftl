<#if Slide.getSiblings()?has_content>
<section class="full-slider slider">
  <#list Slide.getSiblings() as S>
    <div class="slide">
      <div class="slide-text">
        <div class="slide-top row">
          <#if S.TopContent1.getSiblings()?has_content>
            <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
              <div class="top-content">
                ${S.TopContent1.getData()}
              </div>
            </div>
          </#if>
        </div>

        <div class="slide-bottom row">
          <#if S.BottomContent.getSiblings()?has_content>
            <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
              <div class="bottom-content">
                ${S.BottomContent.getData()}
              </div>
            </div>
          </#if>
        </div>
      </div>

      <#if S.Background.getData()?? && S.Background.getData() != "">
        <div class="slide-background">
          <img data-fileentryid="${S.Background.getAttribute("fileEntryId")}" alt="${S.Background.getAttribute("alt")}" src="${S.Background.getData()}" />
        </div>
      </#if>
    </div>
  </#list>
</section>
</#if>

<script>


function updateHeight(){
  $('.full-slider .slide').each(function(){
    var $this = $(this), height = $this.find('.slide-background').innerHeight()
    $this.css('height', height);
    $('.full-slider').css('height', height);
  });
}

function buildSlider(element){

  var slide_arr = [], smallest_val = 10000, smallest_index = -1;

  var $nav = $("<nav class='slider-nav'></nav>");

  $(element).find('.slide').each(function(index){
    var $this = $(this);
    var this_height = $this.innerHeight();
    slide_arr.push({
      element: $this,
      height: this_height
    });

    if(this_height < smallest_val){
      smallest_val = this_height;
      smallest_index = index;
    }
  });

  function addNavItem(index){
    var $navItem = $('<div class="nav-item" data-index="'+index+'"></div>');
    if( index === 0 ){ $navItem.addClass('active'); }
    $navItem.click(function(){
      jumpToSlide($(this).data('index'));
      $nav.find('.active').removeClass('active');
      $(this).addClass('active');
    });
    $nav.append($navItem);
  }

  function jumpToSlide(index){
    slide_arr[index].element.css('height', slide_arr[index].height);
    $(element).css('height', slide_arr[index].height);
    slide_arr.forEach(function(item, i){
      var offset = i - index;
      item.element.css('left', (100 * offset) + '%');
    });
  }

  slide_arr.forEach(function(item, i){
    addNavItem(i);
    item.element.css('position', 'absolute');
    jumpToSlide(0);
  });

  console.log($nav.find('.nav-item').length);
  if($nav.find('.nav-item').length > 1){
    $(element).append($nav);
  }
}

$(document).ready(function(){
  setTimeout(function(){
    $('.full-slider').ready(function(){
      $('.full-slider').each(function(){
        buildSlider(this);
      });
      $(window).resize(_.throttle(updateHeight, 100));
    });
  }, 500);
});

</script>

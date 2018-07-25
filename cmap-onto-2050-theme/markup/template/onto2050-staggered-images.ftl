
<#assign unique = randomNamespace>
<#assign align = Alignment.getData()>
<#assign right_caption = RightCaption.getData()>
<#assign right_image = RightImage.getData()>
<#assign left_caption = LeftCaption.getData()>
<#assign left_image = LeftImage.getData()>

<div id="${unique}" class="onto2050-staggered-images ${align}">

  <div class="left row">
    <div class="col-sm-8 col-sm-offset-1 row">
      <#if align == "left">
        <img class="col-sm-16" data-fileentryid="${LeftImage.getAttribute("fileEntryId")}" alt="${LeftImage.getAttribute("alt")}" src="${left_image}"/>
        <#if left_caption?? && left_caption != "">
          <div class="caption col-sm-12">
            ${left_caption}
          </div>
        </#if>
      <#else>
        <#if left_caption?? && left_caption != "">
          <div class="caption col-sm-12">
            ${left_caption}
          </div>
        </#if>
        <img class="col-sm-16" data-fileentryid="${LeftImage.getAttribute("fileEntryId")}" alt="${LeftImage.getAttribute("alt")}" src="${left_image}"/>
      </#if>
    </div>
  </div>
  <div class="right row">
    <div class="col-sm-8 col-sm-offset-7 row">
      <#if align == "left">
        <#if right_caption?? && right_caption != "">
          <div class="caption col-sm-12 col-sm-offset-4">
            ${right_caption}
          </div>
        </#if>
        <img class="col-sm-16" data-fileentryid="${RightImage.getAttribute("fileEntryId")}" alt="${RightImage.getAttribute("alt")}" src="${right_image}"/>
      <#else>
        <img class="col-sm-16" data-fileentryid="${RightImage.getAttribute("fileEntryId")}" alt="${RightImage.getAttribute("alt")}" src="${right_image}"/>
        <#if right_caption?? && right_caption != "">
          <div class="caption col-sm-12 col-sm-offset-4">
            ${right_caption}
          </div>
        </#if>
      </#if>
    </div>
  </div>

  <div class="mobile row">
    <img class="top-image col-sm-16" data-fileentryid="${LeftImage.getAttribute("fileEntryId")}" alt="${LeftImage.getAttribute("alt")}" src="${left_image}"/>
    <div class="caption col-sm-16">
      ${left_caption}
    </div>
    <img class="bottom-image col-sm-16" data-fileentryid="${RightImage.getAttribute("fileEntryId")}" alt="${RightImage.getAttribute("alt")}" src="${right_image}"/>
    <div class="caption col-sm-16">
      ${right_caption}
    </div>
  </div>
</div>

<script>
Liferay.on(
	'allPortletsReady',
	function() {

    function compute(){
      var $this = $('#${unique}');
      if(window.innerWidth < 800){ 
        $this.css('height', 'auto');
        return; 
      }

      var left_height = $this.find('.left.row').innerHeight(), left_size = left_height;
      var right_height = $this.find('.right.row').innerHeight(), right_size = right_height;

      if($this.hasClass('left')){
        var push = $this.find('.left img').innerHeight() * 0.666;
        push -= $this.find('.right .caption').innerHeight();
        if(push >= 0){
          $this.find('.right.row').css('top', push);
        }
        $this.css('height', push + right_height);
        right_size = push + right_height;
      }

      if($this.hasClass('right')){
        var push = $this.find('.right img').innerHeight() * 0.666;
        push -= $this.find('.left .caption').innerHeight();
        if(push >= 0){
          $this.find('.left.row').css('top', push);
        }
        $this.css('height', push + left_height);
        left_size = push + left_height;
      }

      var min_height = left_size > right_size ? left_size : right_size;
      $this.css('min-height', min_height);
    }

    compute();
    $(window).resize(_.throttle(compute, 100));
  }
);
</script>

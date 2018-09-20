<#function validate_field field_name>
  <#if field_name?? && field_name != "">
    <#return field_name>
  <#else>
    <#return ''>
  </#if>
</#function>

<#assign after_picture = validate_field(AfterImage.getData())>
<#assign after_text = validate_field(AfterText.getData())>
<#assign before_picture = validate_field(BeforeImage.getData())>
<#assign before_text = validate_field(BeforeText.getData())>

<#if before_picture != '' && after_picture != ''>
<div id="${randomNamespace}" class="before-after-widget">

  <#if Title.getData() != '' && Description.getData() != ''>
    <header class="before-after-header row">
      <div class="center">
        <#if Title.getData() != ''>
          <div class="whitney-normal bold">${Title.getData()}</div>
        </#if>
        <#if Description.getData() != ''>
          <div class="whitney-small">${Description.getData()}</div>
        </#if>
      </div>
    </header>
  </#if>

  <div class="row">
    <div class="before-after-graphic">
      <div class="before">
        <div class="before-shade shade">
          <#if before_picture != ''>
            <div class="before-graphic" style="background-image: url('${before_picture}')"></div>
            <span class="sr-only">${BeforeImage.getAttribute("alt")}</span>
          <#else>
            <div class="before-graphic placeholder-graphic"></div>
          </#if>
        </div>
      </div>
      <div class="slider">
        <div class="vertical-line"></div>
        <img class="slider-button" src="" alt="Three horizontal lines that denote an area to grab and drag around" draggable="false"/>
      </div>
      <div class="after">
        <div class="after-shade shade">
          <#if after_picture != ''>
            <div class="after-graphic" style="background-image: url('${after_picture}')"></div>
            <span class="sr-only">${AfterImage.getAttribute("alt")}</span>
          <#else>
            <div class="placeholder-image"></div>
            <div class="after-graphic placeholder-graphic"></div>
          </#if>
        </div>
      </div>
    </div>
  </div>

  <div class="label-row row">
    <div class="col-sm-8 before-label">
      <#if before_text != ''>
        <div class="whitney-normal bold">${before_text}</div>
      </#if>
    </div>
    <div class="col-sm-8 after-label">
      <#if after_text != ''>
        <div class="whitney-normal bold">${after_text}</div>
      </#if>
    </div>
  </div>

  <div class="no-js row">
    <img class="after-placeholder" alt="${AfterImage.getAttribute("alt")}" src="${after_picture}" />
    <img class="before-placeholder" alt="${BeforeImage.getAttribute("alt")}" src="${before_picture}" />
  </div>
</div>
<#else>
<div id="${randomNamespace}" class="before-after-widget">
  <div class="label-row row">
    <div class="col-sm-16">
      <h3>Both pictures are not defined, please make sure both pictures are set to display the widget.</h3>
    </div>
  </div>
</div>
</#if>

<script>
Liferay.on(
	'allPortletsReady',
	function() {
    // I do not know the static location for theme images, so I am setting it with javascript
    $('.slider-button').attr('src', Liferay.ThemeDisplay.getPathThemeImages() + '/icons/ic_slider_button.svg');

    var $this = $('#${randomNamespace}');
    var isFull = $this.parents('.col-md-16').length ? true : false;
    var pan_shift = $this.offset().left;

    function handle_pan(e){
      if(isFull){ pan_shift = 0; }
      var client_left = e.srcEvent.clientX - pan_shift;
      if(client_left > 0 && client_left < window.innerWidth - (pan_shift*2)){
        // console.log(e.srcEvent.clientX, e.srcEvent.clientX > 0);
        $this.find('.slider').css('left', client_left);
        $this.find('.before-shade').css('width', client_left);
      }
    }

    var $header = $this.find('.before-after-header');
    var $center = $header.find('.center');

    if(isFull){
      $center.addClass('col-md-6 col-sm-16 col-md-offset-5');
    } else {
      $center.addClass('col-sm-16');
    }

    function set_text_width(){
      if(isFull){
        var row = $this.find('.label-row');
        var labels = row.find('.col-sm-8').detach();
        var center = $('<div class="col-md-offset-4 col-md-8 col-sm-offset-0 col-sm-16"></div>');
        var new_row = $('<div class="row"></div>');
        new_row.append(labels);
        center.append(new_row);
        row.append(center);
      } else {
        $this.find('.before-after-graphic').wrap('<div class="col-sm-16"></div>');
        // alert('Before/After Widget is not in a supported column, please move the widget to a full width column or contect support.');
      }
    }
    function set_height(){
      var before_height = $this.find('.no-js .before-placeholder').innerHeight()
      var after_height = $this.find('.no-js .after-placeholder').innerHeight();
      var height = before_height > after_height ? before_height : after_height;
      $this.find('.before-after-graphic').css('height', height);
    }

    function set_width(){
      var widget_width = $this.find('.before-after-graphic').innerWidth();
      $this.find('.before-graphic').css('width', widget_width);
    }

    // http://hammerjs.github.io/api/
    // http://hammerjs.github.io/touch-action/
    // http://hammerjs.github.io/recognizer-pan/
    // http://hammerjs.github.io/getting-started/
    require(['https://hammerjs.github.io/dist/hammer.min.js'], function(Hammer){
      set_text_width();
      set_height();
      set_width();

      $(window).resize(_.throttle(function(){
        set_height();
        set_width();
      }, 100));

      var hammertime = new Hammer($this[0], {});
      hammertime.on('pan', handle_pan);
    });
	}
);
</script>

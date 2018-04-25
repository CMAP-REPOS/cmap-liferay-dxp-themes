<#function validate_field field_name>
  <#if field_name?? && field_name != "">
    <#return field_name>
  <#else>
    <#return ''>
  </#if>
</#function>

<#assign after_picture = validate_field(AfterImage.getData())>
<#assign before_picture = validate_field(BeforeImage.getData())>

<div id="${randomNamespace}" class="before-after-widget">

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
        <img class="slider-button" src="" draggable="false"/>
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
      <h4>${BeforeText.getData()}</h4>
    </div>
    <div class="col-sm-8 after-label">
      <h4>${AfterText.getData()}</h4>
    </div>
  </div>
  <div class="no-js row">
    <img class="after-placeholder" src="${after_picture}" />
    <img class="before-placeholder" src="${before_picture}" />
  </div>
</div>


<script>
Liferay.on(
	'allPortletsReady',
	function() {
    $('.slider-button').attr('src', Liferay.ThemeDisplay.getPathThemeImages() + '/icons/ic_slider_button.svg');

    var $this = $('#${randomNamespace}');
    var last_left = window.innerWidth / 2;
    function set_text_width(){
      var full = $this.parents('.col-md-16').length;
      var middle = $this.parents('.col-md-10').length;
      if(full){
        var row = $this.find('.label-row');
        var labels = row.find('.col-sm-8').detach();
        var center = $('<div class="col-lg-offset-4 col-lg-8 col-md-offset-3 col-md-10 col-sm-offset-0 col-sm-16"></div>');
        var new_row = $('<div class="row"></div>');
        new_row.append(labels);
        center.append(new_row);
        row.append(center);
      }
      if(!full){
        alert('Before/After Widget is not in a supported column, please move the widget to a full width column or contect support.');
      }
    }

    function calc_before_after_height(){
      var before_height = $this.find('.no-js .before-placeholder').innerHeight()
      var after_height = $this.find('.no-js .after-placeholder').innerHeight();
      var height = before_height > after_height ? before_height : after_height;
      $this.find('.before-after-graphic').css('height', height);
    }
    function init_before_after(){
      set_text_width();
      calc_before_after_height();
    }
    $this.ready(init_before_after);

    function handle_pan(e){
      if(e.srcEvent.clientX < window.innerWidth){
        $this.find('.slider').css('left', e.srcEvent.clientX);
        $this.find('.before-shade').css('width', e.srcEvent.clientX);
      } else {
        $this.find('.slider').css('left', window.innerWidth);
        $this.find('.before-shade').css('width', window.innerWidth);
      }
      last_left = e.srcEvent.clientX;
    }

    // http://hammerjs.github.io/api/
    // http://hammerjs.github.io/touch-action/
    // http://hammerjs.github.io/recognizer-pan/
    // http://hammerjs.github.io/getting-started/
    var hammertime = new Hammer($this[0], {});
    hammertime.on('pan', handle_pan);
	}
);

require(['https://hammerjs.github.io/dist/hammer.min.js'], function(Hammer){
  console.log(Hammer);
});
</script>

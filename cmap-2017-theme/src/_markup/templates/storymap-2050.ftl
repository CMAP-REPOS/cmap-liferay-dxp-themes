<#assign layers = []>
<#assign locations = []>

<div class="story-map-zoom-toggler">
  <a href="#"><i class="icon-plus"></i></a>
</div>

<#if getterUtil.getBoolean(Options.ShowLayers.getData())>
<#--  StoryOverlays were renamed to Layers  -->
<div class="story-map-layer-switcher">
    <div class="layers-menu">
    <ul>
      <li>
        <a href="#" id="layers-menu-toggler"><i class="icon-play-circle" style="color: #3C5976"></i> <span class="overlay-label">Layers</span></a>
      </li>
    <#list StoryOverlays.getSiblings() as cur_Layer>
    <#assign storyOverlaysIndex = cur_Layer?index>
      <#if cur_Layer?? 
        && cur_Layer.OverlayTitle?? 
        && cur_Layer.OverlayTitle.getData()?? 
        && cur_Layer.OverlayTitle.getData() != "">
      <li>
        <a href="#" id="button_overlay_${storyOverlaysIndex}" data-index="${storyOverlaysIndex}" class="button_overlay">
        <#if cur_Layer.LayerColor.getData()?? 
          && cur_Layer.LayerColor.getData() != "">
          <#assign layerColor = cur_Layer.LayerColor.getData()>
        <#else>
          <#--  magic value $grey-blue from _variables.scss  -->
          <#assign layerColor = "#3C5976">
        </#if>
        <i class="icon-circle-blank" style="color: ${layerColor}"></i> <span class="overlay-label">${cur_Layer.OverlayTitle.getData()}</span></a>
        </a>
      </li>
      </#if>
    </#list>
    </ul>
    </div>
</div> 
</#if>

<div class="storymap-intro-content">
  <div class="row">
    <div class="col-xl-10 col-xl-offset-3 col-sm-16 col-sm-offset-0 title-block">
      <div class="storymap-title">
      ${StoryTitle.getData()}
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-xl-3 col-sm-16 col-sm-offset-0">
      <div class="storymap-aside">
      ${Aside.getData()}
      </div>
      <div class="storymap-source">
      ${Source.getData()}
      </div>
    </div>
      <div class="col-xl-10 col-sm-16 col-sm-offset-0 ">
        <div class="storymap-info">
        ${StoryDescription.getData()}
        </div>
      </div>
      <div class="col-xl-3 col-sm-16 col-sm-offset-0 ">
        <div class="storymap-data-link">
        <a href="${LinkToDataHub.getData()}"><i class="icon-download-alt"></i> Download the Data </a>
        </div>
      </div>
  </div>
</div>

<div id="map-container">
  <div id="${randomNamespace}_map" class="story-map">
  </div>
</div>

<#if getterUtil.getBoolean(Options.ShowLocations.getData())>
<#--  StorySteps were renamed to Locations -->
<div class="row">
  <div class="storymap-nav-container">
    <div class="col-xl-10 col-xl-offset-3 col-sm-16 col-sm-offset-0 story-steps">
    <ul class="list-inline list-unstyled storymap-nav-list pull-left">
    <#list StorySteps.getSiblings() as cur_StoryStep>
    <#assign storyStepsIndex = cur_StoryStep?index>
      <#if cur_StoryStep.StepTitle.getData() != "">
      <li id="${randomNamespace}_step${storyStepsIndex}" 
          class="story-step-title" href="#"
          data-step="${cur_StoryStep?index}">
          ${cur_StoryStep.StepTitle.getData()}
      </li>
      </#if>
    </#list>
    </ul>
    </div>
  </div>
</div>
</#if>

<section class="storymap-main-content">
<#if getterUtil.getBoolean(Options.ShowLocationContent.getData())>
  <#list StorySteps.getSiblings() as cur_StoryStep>
  <#assign storyStepsIndex = cur_StoryStep?index>
    <div id="${randomNamespace}location_content${storyStepsIndex}" class="story-step-content">
    <#list cur_StoryStep.StoryStepContent.getSiblings() as cur_StoryStepContent>
    <#if getterUtil.getBoolean(cur_StoryStepContent.FullWidthContent.getData())>
      <div class="col-xl-16 story-step-content-full-width">
      ${cur_StoryStepContent.Content.getData()}
      </div>
    <#else>
      <div class="story-step-content-centered">
        <div class="row">
          <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
          ${cur_StoryStepContent.Content.getData()}
          </div>
        </div>
      </div>
    </#if>
    </#list>
    </div>
  </#list>
</#if>

<#if getterUtil.getBoolean(Options.ShowLayerContent.getData())>
  <#list StoryOverlays.getSiblings() as cur_Layer>
  <#assign layerIndex = cur_Layer?index>
      <div id="${randomNamespace}layer_content${layerIndex}" class="story-step-content">
      <#list cur_Layer.LayerContentSeparator.getSiblings() as cur_LayerContent>
      <#if getterUtil.getBoolean(cur_LayerContent.FullWidthLayerContent.getData())>
        <div class="col-xl-16 story-step-content-full-width">
        ${cur_LayerContent.LayerContent.getData()}
        </div>
      <#else>
      <div class="story-step-content-centered">
        <div class="row">
          <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
          ${cur_LayerContent.LayerContent.getData()}
          </div>
        </div>
      </div>
      </#if>
      </#list>
      </div>
  </#list>
</#if>
</section>

<script type="text/javascript">

  var cmap = cmap || {};
  cmap.storymaps = cmap.storymaps || {};

  AUI().ready(

    function () {

      L.Control.ZoomToggler = L.Control.extend({
        onAdd: function (map) {
          if ($('.story-map-zoom-toggler').length) {
            return $('.story-map-zoom-toggler').get(0);
          }
          return L.DomUtil.create('span');
        },
        onRemove: function (map) {
          // noop
        }
      });

      L.Control.LayerSwitcher = L.Control.extend({
        onAdd: function (map) {
          if ($('.story-map-layer-switcher').length) {
            return $('.story-map-layer-switcher').get(0);
          }
          return L.DomUtil.create('span');
        },
        onRemove: function (map) {
          // noop
        }
      });

      L.control.zoomToggler = function (opts) {
        return new L.Control.ZoomToggler(opts);
      }

      L.control.layerSwitcher = function (opts) {
        return new L.Control.LayerSwitcher(opts);
      }

      cmap.storymaps.storyStep = -1;
      cmap.storymaps.markerLayers = [];
      cmap.storymaps.layers = {};
      cmap.storymaps.layerData = [];
      cmap.storymaps.storySteps = [];
      cmap.storymaps.storyOverlays = [];

      cmap.storymaps.buildStorySteps = function () {
        var markers = [];
        <#list StorySteps.getSiblings() as cur_StoryStep >
          <#assign storyStepsIndex = cur_StoryStep ? index >
          <#if cur_StoryStep.StepTitle.getData() != "" >
            <#list cur_StoryStep.coords.getSiblings() as cur_Coords >
        markers.push({
          coords: ['${cur_Coords.StepLatitude.getData()}', '${cur_Coords.StepLongitude.getData()}'],
          label: '${cur_Coords.StepMarkerLabel.getData()}'
        });
            </#list>

        cmap.storymaps.storySteps.push({
          stepTitle: '${cur_StoryStep.StepTitle.getData()}',
          stepMarkers: markers
        });
        markers = [];
          </#if>
        </#list >
      };

      cmap.storymaps.buildLayerData = function () {
      <#list StoryOverlays.getSiblings() as cur_StoryOverlay >
        <#assign storyOverlaysIndex = cur_StoryOverlay ? index >
        <#if cur_StoryOverlay.OverlayTitle.getData() != "" >
        cmap.storymaps.layerData.push({
          title: '${cur_StoryOverlay.OverlayTitle.getData()}',
          file: '${cur_StoryOverlay.OverlayFile.getData()}'
        });
        </#if>
      </#list >
      };

      cmap.storymaps.loadContent = function (isLocation, index) {
        $('.story-step-content').hide();
        if (isLocation && index > -1) {
        <#if getterUtil.getBoolean(Options.ShowLocationContent.getData()) >
          $('#${randomNamespace}location_content' + index).show();
        </#if>
        } else if (index > -1) {
        <#if getterUtil.getBoolean(Options.ShowLayerContent.getData()) >
          var contentId = 'layer_content' + index;
          $('#${randomNamespace}' + contentId).show();
        </#if>
        }
      };

      cmap.storymaps.loadOverlay = function (button, index) {

        button.toggleClass('active');
        var layerData = cmap.storymaps.layerData[index];
        var overlayId = 'overlay_' + index;

        if (!cmap.storymaps.layers[overlayId]) {
          button.find('.overlay-label').html('loading...');

          $.ajax({
            dataType: "json",
            url: layerData.file,
            success: function (data) {
              cmap.storymaps.layers[overlayId] = L.geoJSON(data, { style: L.mapbox.simplestyle.style });
              cmap.storymaps.layers[overlayId].addTo(cmap.storymaps.map);
              $('.overlays').children().removeClass('disabled-loading');
            },
            error: function (jqXHR, textStatus, errorThrown) {
              console.log(errorThrown);
            },
            complete: function () {
              button.find('.overlay-label').html(layerData.title);
            }
          });
        } else {
          $('.overlays').children().removeClass('disabled-loading');
          if (cmap.storymaps.map.hasLayer(cmap.storymaps.layers[overlayId])) {
            cmap.storymaps.map.removeLayer(cmap.storymaps.layers[overlayId]);
          } else {
            cmap.storymaps.layers[overlayId].addTo(cmap.storymaps.map);
          }
        }

        if (button.hasClass('active')) {
          cmap.storymaps.loadContent(false, index);
        } else {
          cmap.storymaps.loadContent(false, -1);
        }
      };

      cmap.storymaps.showStoryStep = function (step) {
        console.log('cmap.storymaps.showStoryStep');

        $('.story-step-title').removeClass('story-active');
        $('#${randomNamespace}_step' + step).addClass('story-active');
        $('.xs-story-step-title').html(cmap.storymaps.storySteps[step].stepTitle);
        if (step > -1) {
          cmap.storymaps.setMarkerState(step);
          cmap.storymaps.setPanState(step);
          cmap.storymaps.loadContent(true, step);
          cmap.storymaps.scrollToStep();
        } else {
          // TODO: default state
        }
      };

      cmap.storymaps.scrollToStep = function () {
        console.log('cmap.storymaps.scrollToStep');
        $('html, body').animate({ scrollTop: $('.storymap-main-content').offset().top }, 600);
      };

      cmap.storymaps.setPanState = function (step) {
        console.log('cmap.storymaps.setPanState');
        var marker = cmap.storymaps.storySteps[step].stepMarkers[0];
        cmap.storymaps.map.setView(marker.coords, marker.zoom, { animate: true });
      };

      cmap.storymaps.setMarkerState = function (step) {
        console.log('cmap.storymaps.setMarkerState');

        var cmapIcon = L.divIcon({ className: 'icon-cmap icon-map-med-dark' });

        for (i = 0; i < cmap.storymaps.markerLayers.length; i++) {
          cmap.storymaps.removeLayer(cmap.storymaps.markerLayers[i]);
        }

        cmap.storymaps.markerLayers = [];

        for (i = 0; i < cmap.storymaps.storySteps[step].stepMarkers.length; i++) {
          var marker = cmap.storymaps.storySteps[step].stepMarkers[i];
          mapPin = new L.marker(marker.coords, { icon: cmapIcon, interactive: false });
          cmap.storymaps.markerLayers.push(mapPin);
          mapPin.addTo(cmap.storymaps.map);
          L.DomEvent.disableClickPropagation(mapPin);
          if ($.trim(marker.label).length) {
            mapPin.bindTooltip(marker.label).openTooltip();
          }
        }
        <#if  Options.markerColor ?? && Options.markerColor.getData() ?? && Options.markerColor.getData() != "" >
        $('.icon-map-med-dark').css('color', '${Options.markerColor.getData()}');
        <#else>
        $('.icon-map-med-dark').css('color', 'red');
        </#if>
      };

      cmap.storymaps.removeLayer = function (layer) {
        if (layer) {
          cmap.storymaps.map.removeLayer(layer);
        }
      };

      cmap.storymaps.handleResize = function () {
        <#--magic number from _variables.scss-- >
        <#--$breakpoint - tablet: 750px; -->
        if ($(window).width() >= 750) {
          $('.storymap-info, .storymap-aside, .storymap-source, .layers-menu').show();
        } else {
          $('.storymap-aside, .storymap-source, .layers-menu').hide();
        }
      };

      cmap.storymaps.toggleLayersMenu = function () {
      };

      cmap.storymaps.bindEvents = function () {

        $(window).on('resize', _.throttle(cmap.storymaps.handleResize, 200));

        $('.story-step-title').on('click', function (e) {
          e.preventDefault();
          cmap.storymaps.storyStep = $(this).data('step');
          cmap.storymaps.showStoryStep(cmap.storymaps.storyStep);
        });

        $('.button_overlay').on('click', function (e) {
          e.preventDefault();
          var $this = $(this);
          cmap.storymaps.loadOverlay($this, $this.data('index'));
        });

        $('.storymap-info-toggle').on('click', function (e) {
          e.preventDefault();
          $('.storymap-info, .storymap-aside, .storymap-source').toggle();
        });

        $('.view-layers-button').on("click", function (e) {
          $(this).children('.icon-text')
            .text(function (i, text) {
              return text === "View Layers" ? "Hide Layers" : "View Layers";
            });
          $('.layers-menu').toggle();
        });

        $('#layers-menu-toggler').on('click', function (e) {
          e.preventDefault();
          cmap.storymaps.toggleLayersMenu();
        })

      };

      cmap.storymaps.initMap = function () {

        <#if Options.styleUrl ?? && Options.styleUrl.getData() ?? && Options.styleUrl.getData() != "" >
        var url = "${Options.styleUrl.getData()}";
        <#else>
        var url = "mapbox://styles/onto2050/cj0jnlcwj007k2sulorlf0zbk";
        </#if>

        L.mapbox.accessToken = 'pk.eyJ1Ijoib250bzIwNTAiLCJhIjoiY2lzdjJycTZrMGE3dDJ5b2RsYTRvaHdiZSJ9.SIUNXOhAVC2rXywtDIrraQ';

        cmap.storymaps.map = L.mapbox.map('${randomNamespace}_map', 'mapbox.streets', {
          maxBounds: [[40.82130, -90.47900], [43.28040, -85.72192]],
          maxZoom: 12,
          minZoom: 8,
          attributionControl: false,
          infoControl: false,
          zoomControl: false
        }).setView([41.8781, -87.6298], 9);

        cmap.storymaps.map.scrollWheelZoom.disable();
        L.mapbox.styleLayer(url).addTo(cmap.storymaps.map);
        L.control.zoomToggler({ position: 'topleft' }).addTo(cmap.storymaps.map);
        L.control.layerSwitcher({ position: 'bottomright' }).addTo(cmap.storymaps.map);
      };

      cmap.storymaps.initMap();
      cmap.storymaps.buildStorySteps();
      cmap.storymaps.buildLayerData();
      cmap.storymaps.bindEvents();
    }
  );
</script>
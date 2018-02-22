<#assign layers = []>
<#assign locations = []>

<div class="story-map-zoom-toggler">
  <a href="#"><i class="icon-plus"></i> Zoom</a>
</div>

<#if getterUtil.getBoolean(Options.ShowLayers.getData())>
<div class="story-map-layer-switcher">
    <div class="layers-menu">
    <ul class="list-unstyled">
      <li>
        <a href="#" class="layers-menu-toggler"><i class="icon-play-circle" style="color: #3C5976"></i> <span class="overlay-label">Layers</span></a>
      </li>
    <#list Layer.getSiblings() as cur_Layer>
    <#assign layerIndex = cur_Layer?index>
      <#if cur_Layer?? 
        && cur_Layer.LayerLabel?? 
        && cur_Layer.LayerLabel.getData()?? 
        && cur_Layer.LayerLabel.getData() != "">
      <li>
        <a href="#" id="button_overlay_${layerIndex}" data-index="${layerIndex}" class="button_overlay">
        <#if cur_Layer.LayerColor.getData()?? 
          && cur_Layer.LayerColor.getData() != "">
          <#assign layerColor = cur_Layer.LayerColor.getData()>
        <#else>
          <#--  magic value $grey-blue from _variables.scss  -->
          <#assign layerColor = "#3C5976">
        </#if>
        <i class="icon-circle-blank" style="color: ${layerColor}"></i> <span class="overlay-label">${cur_Layer.LayerLabel.getData()}</span></a>
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
<div class="row">
  <div class="storymap-nav-container">
    <div class="col-xl-10 col-xl-offset-3 col-sm-16 col-sm-offset-0 story-steps">
    <ul class="list-inline list-unstyled storymap-nav-list pull-left">
    <#list Location.getSiblings() as cur_StoryStep>
    <#assign storyStepsIndex = cur_StoryStep?index>
      <#if cur_StoryStep.LocationLabel.getData() != "">
      <li id="${randomNamespace}_step${storyStepsIndex}" 
          class="story-step-title" href="#"
          data-step="${cur_StoryStep?index}">
          ${cur_StoryStep.LocationLabel.getData()}
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
  <#list Location.getSiblings() as cur_StoryStep>
  <#assign storyStepsIndex = cur_StoryStep?index>
    <div id="${randomNamespace}location_content${storyStepsIndex}" class="story-step-content">
    <#list cur_StoryStep.LocationContent.getSiblings() as cur_LocationContent>
    <#if getterUtil.getBoolean(cur_LocationContent.LocationContentFullWidth.getData())>
      <div class="col-xl-16 story-step-content-full-width">
      ${cur_LocationContent.LocationContentContent.getData()}
      </div>
    <#else>
      <div class="story-step-content-centered">
        <div class="row">
          <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
          ${cur_LocationContent.LocationContentContent.getData()}
          </div>
        </div>
      </div>
    </#if>
    </#list>
    </div>
  </#list>
</#if>

<#if getterUtil.getBoolean(Options.ShowLayerContent.getData())>
  <#list Layer.getSiblings() as cur_Layer>
  <#assign layerIndex = cur_Layer?index>
      <div id="${randomNamespace}layer_content${layerIndex}" class="story-step-content">
      <#list cur_Layer.LayerContent.getSiblings() as cur_LayerContent>
      <#if getterUtil.getBoolean(cur_LayerContent.LayerContentFullWidth.getData())>
        <div class="col-xl-16 story-step-content-full-width">
        ${cur_LayerContent.LayerContentContent.getData()}
        </div>
      <#else>
      <div class="story-step-content-centered">
        <div class="row">
          <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
          ${cur_LayerContent.LayerContentContent.getData()}
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

      cmap.storymaps.location = -1;
      cmap.storymaps.layerData = [];
      cmap.storymaps.defaultLayerData = -1;
      cmap.storymaps.layers = {};
      cmap.storymaps.locations = [];
      cmap.storymaps.defaultLocation = -1;
      cmap.storymaps.markerLayers = [];
      cmap.storymaps.defaultZoom = 9;

      cmap.storymaps.toggleZoom = function (l) {
        if (l > -1 && cmap.storymaps.map.getZoom() !== parseInt(cmap.storymaps.locations[l].zoom, 10)) {
          cmap.storymaps.map.setZoom(cmap.storymaps.locations[l].zoom);
          cmap.storymaps.hideLayerMenu();
        } else {
          cmap.storymaps.map.setZoom(cmap.storymaps.defaultZoom);
          cmap.storymaps.showLayerMenu();
        }
      };

      cmap.storymaps.toggleLayersMenu = function () {
        if (!$('.leaflet-bottom.leaflet-right').data('hidden')) {
          cmap.storymaps.hideLayerMenu();
        } else {
          cmap.storymaps.showLayerMenu();
        }
      };

      cmap.storymaps.hideLayerMenu = function() {
        var right = ($('.leaflet-bottom.leaflet-right').width() * -1) + 34;
        $('.leaflet-bottom.leaflet-right').animate({
          right: right,
        }, 500, function() {
          $('.leaflet-bottom.leaflet-right').data('hidden', true);
        });
      };

      cmap.storymaps.showLayerMenu = function() {
        $('.leaflet-bottom.leaflet-right').animate({
          right: '10px',
        }, 500, function() {
          $('.leaflet-bottom.leaflet-right').data('hidden', false);
        });
      };

      cmap.storymaps.scrollToContent = function () {
        <#--  magic value 50 is approximate height of scroll-nav  -->
        $('html, body').animate({ scrollTop: $('.storymap-main-content').offset().top - 50 }, 600);
      };

      cmap.storymaps.removeLayer = function (layer) {
        if (layer) {
          cmap.storymaps.map.removeLayer(layer);
        }
      };

      cmap.storymaps.setPanState = function (l) {
        var marker = cmap.storymaps.locations[l].markers[0];
        cmap.storymaps.map.setView(marker.coords, cmap.storymaps.defaultZoom, { animate: true });
      };

      cmap.storymaps.setMarkerState = function (l) {

        var cmapIcon = L.divIcon({ className: 'icon-cmap icon-map-med-dark' });

        for (i = 0; i < cmap.storymaps.markerLayers.length; i++) {
          cmap.storymaps.removeLayer(cmap.storymaps.markerLayers[i]);
        }

        cmap.storymaps.markerLayers = [];

        for (i = 0; i < cmap.storymaps.locations[l].markers.length; i++) {
          var marker = cmap.storymaps.locations[l].markers[i];
          mapPin = new L.marker(marker.coords, { icon: cmapIcon, interactive: false });
          cmap.storymaps.markerLayers.push(mapPin);
          mapPin.addTo(cmap.storymaps.map);
          L.DomEvent.disableClickPropagation(mapPin);
          if ($.trim(marker.label).length) {
            mapPin.bindTooltip(marker.label).openTooltip();
          }
        }
        <#if Options.MapPinColor ?? && Options.MapPinColor.getData() ?? && Options.MapPinColor.getData() != "" >
        $('.icon-map-med-dark').css('color', '${Options.MapPinColor.getData()}');
        <#else>
        $('.icon-map-med-dark').css('color', 'red');
        </#if>
      };

      cmap.storymaps.showLocation = function (l) {
        $('.story-step-title').removeClass('story-active');
        $('#${randomNamespace}_step' + l).addClass('story-active');
        $('.xs-story-step-title').html(cmap.storymaps.locations[l].stepTitle);
        if (l > -1) {
          cmap.storymaps.setMarkerState(l);
          cmap.storymaps.setPanState(l);
          cmap.storymaps.loadContent(true, l);
          cmap.storymaps.scrollToContent();
        } else {
          // TODO: default state
        }
      };

      cmap.storymaps.loadContent = function (isLocation, index) {
        $('.story-step-content').hide();
        if (isLocation && index > -1) {
        <#if getterUtil.getBoolean(Options.ShowLocationContent.getData()) >
          $('#${randomNamespace}location_content' + index).show();
          cmap.storymaps.scrollToContent();
        </#if>
        } else if (index > -1) {
        <#if getterUtil.getBoolean(Options.ShowLayerContent.getData()) >
          var contentId = 'layer_content' + index;
          $('#${randomNamespace}' + contentId).show();
          cmap.storymaps.scrollToContent();
        </#if>
        }
      };

      cmap.storymaps.loadOverlay = function (index) {

        var button = $('#button_overlay_'+index);
        var layerData = cmap.storymaps.layerData[index];
        var overlayId = 'overlay_' + index;
        button.toggleClass('active');

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

      cmap.storymaps.bindEvents = function () {

        $('.story-step-title').on('click', function (e) {
          e.preventDefault();
          cmap.storymaps.location = $(this).data('step');
          cmap.storymaps.showLocation(cmap.storymaps.location);
        });

        $('.button_overlay').on('click', function (e) {
          e.preventDefault();
          cmap.storymaps.loadOverlay($(this).data('index'));
        });

        $('.story-map-zoom-toggler').on('click', function (e) {
          e.preventDefault();
          cmap.storymaps.toggleZoom(cmap.storymaps.location);
        });

        $('.layers-menu-toggler').on('click', function (e) {
          e.preventDefault();
          cmap.storymaps.toggleLayersMenu();
        });
      };

      cmap.storymaps.buildLocations = function () {
        <#list Location.getSiblings() as cur_Location >
          <#if cur_Location.LocationLabel.getData() != "" >
        cmap.storymaps.locations.push({
          label: '${cur_Location.LocationLabel.getData()}',
          zoom: '${cur_Location.DetailZoomLevel.getData()}',
          <#if getterUtil.getBoolean(cur_Location.ShowLocationByDefault.getData())>
          default: true,
          <#else>
          default: false,
          </#if>
          markers: [
          <#list cur_Location.LocationCoordinates.getSiblings() as cur_Coords >
            {
              coords: ['${cur_Coords.Latitude.getData()}', '${cur_Coords.Longitude.getData()}'],
              label: '${cur_Coords.MapPinLabel.getData()}'
            },
          </#list>
          ]
        });
          </#if>
        </#list >
        for (var i = 0; i < cmap.storymaps.locations.length; i++) {
          if (cmap.storymaps.locations[i].default) {
            cmap.storymaps.location = i;            
            cmap.storymaps.showLocation(i);
            break;
          }
        }
      };

      cmap.storymaps.buildLayerData = function () {
      <#list Layer.getSiblings() as cur_Layer>
        <#if cur_Layer.LayerLabel.getData() != "" >
        cmap.storymaps.layerData.push({
          title: '${cur_Layer.LayerLabel.getData()}',
          file: '${cur_Layer.LayerFile.getData()}',
          <#if getterUtil.getBoolean(cur_Layer.ShowLayerByDefault.getData())>
          default: true
          <#else>
          default: false
          </#if>
        });
        </#if>
      </#list >
        for (var i = 0; i < cmap.storymaps.layerData.length; i++) {
          if (cmap.storymaps.layerData[i].default) {
            cmap.storymaps.loadOverlay(i);
            break;
          }
        }
      };

      cmap.storymaps.initMap = function () {

        <#if Options.MapStyleURL ?? && Options.MapStyleURL.getData() ?? && Options.MapStyleURL.getData() != "" >
        var url = "${Options.MapStyleURL.getData()}";
        <#else>
        var url = "mapbox://styles/onto2050/cjdyusjc32fyg2spij839d5up";
        </#if>

        L.mapbox.accessToken = 'pk.eyJ1Ijoib250bzIwNTAiLCJhIjoiY2lzdjJycTZrMGE3dDJ5b2RsYTRvaHdiZSJ9.SIUNXOhAVC2rXywtDIrraQ';

        cmap.storymaps.map = L.mapbox.map('${randomNamespace}_map', 'mapbox.streets', {
          maxBounds: [[40.82130, -90.47900], [43.28040, -85.72192]],
          maxZoom: 13,
          minZoom: cmap.storymaps.defaultZoom,
          attributionControl: false,
          infoControl: false,
          zoomControl: false
        }).setView([41.8781, -87.6298], cmap.storymaps.defaultZoom);

        cmap.storymaps.map.scrollWheelZoom.disable();
        L.mapbox.styleLayer(url).addTo(cmap.storymaps.map);
        L.control.zoomToggler({ position: 'topleft' }).addTo(cmap.storymaps.map);
        L.control.layerSwitcher({ position: 'bottomright' }).addTo(cmap.storymaps.map);
      };

      cmap.storymaps.initMap();
      cmap.storymaps.buildLayerData();
      cmap.storymaps.buildLocations();
      cmap.storymaps.bindEvents();
    }
  );
</script>
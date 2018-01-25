<#assign legendLabels = []>
<#assign overlayLabels = []>

<#if getterUtil.getBoolean(Options.ShowLegend.getData())>
    <#list Legend.getSiblings() as cur_Legend>
      <#if cur_Legend?? && cur_Legend.KeyLabel?? && cur_Legend.KeyLabel.getData()?? && cur_Legend.KeyLabel.getData() != "">
        <#assign legendLabels = legendLabels + [cur_Legend.KeyLabel]>
      </#if>
    </#list>
</#if>

<#list StoryOverlays.getSiblings() as cur_StoryOverlay>
  <#if cur_StoryOverlay?? && cur_StoryOverlay.OverlayTitle?? && cur_StoryOverlay.OverlayTitle.getData()?? && cur_StoryOverlay.OverlayTitle.getData() != "">
    <#assign overlayLabels = overlayLabels + [cur_StoryOverlay.OverlayTitle]>
  </#if>
</#list>

<#if getterUtil.getBoolean(Options.ShowLegend.getData()) &&  legendLabels?size != 0>
<section class="story-map-legend"> 
    <ul class="list-unstyled">
    <#list Legend.getSiblings() as cur_Legend>
        <li><span><i class="icon-circle" style="color: ${cur_Legend.KeyColor.getData()}"></i> </span>${cur_Legend.KeyLabel.getData()}</li>
    </#list>
    </ul>
</section>
</#if>

<#if overlayLabels?size != 0>
<div class="story-map-layer-switcher text-right">
    <span class="view-layers-button">
        <span class="icon-text">View Layers</span>
        <span class="icon-cmap icon-layers-dark"></span>
    </span>
    <div class="layers-menu">
    <#list StoryOverlays.getSiblings() as cur_StoryOverlay>
    <#assign storyOverlaysIndex = cur_StoryOverlay?index>
        <#if cur_StoryOverlay.OverlayTitle.getData() != "">
        <button id="button_overlay_${storyOverlaysIndex}" class="btn button-default button_overlay"
            data-index="${storyOverlaysIndex}">
            ${cur_StoryOverlay.OverlayTitle.getData()}
        </button>
        </#if>
    </#list>
    </div>
</div> 
</#if>

<div class="storymap-section">
    <div class="storymap-intro-container">
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
        </div>
    </div>
    <#if getterUtil.getBoolean(Options.ShowLocations.getData())>
    <div class="row story-interact">
        <div class="storymap-nav-container">
            <div class="col-xl-3">
            <ul class="list-inline list-unstyled storymap-nav-list">
                <li><button class="view-map"><span class="icon icon-map-marker"></span> View Map</button></li>
            </ul>
            </div>
            <div class="col-xl-13 col-sm-16 col-sm-offset-0 story-steps">
            <ul class="list-inline list-unstyled storymap-nav-list pull-left">
            <#list StorySteps.getSiblings() as cur_StoryStep>
            <#assign storyStepsIndex = cur_StoryStep?index>
                <#if cur_StoryStep.StepTitle.getData() != "">
                <li id="${randomNamespace}_step${storyStepsIndex}" class="story-step-title" href="#"
                    data-step="${cur_StoryStep?index}">
                    ${cur_StoryStep.StepTitle.getData()}
                </li>
                </#if>
            </#list>
            </ul>
            <ul class="list-inline list-unstyled pull-right">
                <li>
                    <a href="#" class="previous-story-step"><span class="icon-cmap icon-nav-left-white"></span> 
                    <span class="sr-only">Previous</span></a>
                </li>
                <li>
                    <a href="#" class="next-story-step"><span class="icon-cmap icon-nav-right-white"></span> 
                    <span class="sr-only">Next</span></a>
                </li>
            </ul>
            </div>
        </div>
        <div class="storymap-nav-container mobile-storymap-nav">
            <div class="col-xs-1">
                <a href="#" class="previous-story-step"><span class="icon-cmap icon-nav-left-white"></span> <span class="sr-only">Previous</span></a>
            </div>
            <div class="col-xs-14 text-center">
                <span class="xs-story-step-title story-step-title story-active"></span>
            </div>
            <div class="col-xs-1">
                <a href="#" class="next-story-step"><span class="icon-cmap icon-nav-right-white"></span> <span class="sr-only">Next</span></a>
            </div>
        </div>
    </div>
    </#if>
    <a href="#" class="storymap-info-toggle"><span class="icon-info-sign"></i> <span class="sr-only">Toggle Map Info</span></a>
</div>

<div id="map-container">
    <div id="${randomNamespace}_map" class="story-map">
    </div>
</div>

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


<script type="text/javascript">

var cmap = cmap || {};
cmap.storymaps = cmap.storymaps || {};

AUI().ready(

    function () {

        L.Map.prototype.panToOffset = function (latlng, zoom, options) {
            var x = this.latLngToContainerPoint(latlng).x
            var y = this.latLngToContainerPoint(latlng).y
            var point = this.containerPointToLatLng([x, y])
            return this.setView(point, zoom, { pan: options })
        }

        L.Control.Legend = L.Control.extend({
            onAdd: function(map) {
                if ($('.story-map-legend').length) {
                    return $('.story-map-legend').get(0);
                }
                return L.DomUtil.create('span');
            },
            onRemove: function(map) {
                // noop
            }
        });

        L.Control.LayerSwitcher = L.Control.extend({
            onAdd: function(map) {
                if ($('.story-map-layer-switcher').length) {
                    return $('.story-map-layer-switcher').get(0);
                }
                return L.DomUtil.create('span');
            },
            onRemove: function(map) {
                // noop
            }
        });

        L.control.legend = function(opts) {
            return new L.Control.Legend(opts);
        }

        L.control.layerSwitcher = function(opts) {
            return new L.Control.LayerSwitcher(opts);
        }

        cmap.storymaps.storyStep = -1;
        cmap.storymaps.markerLayers = [];
        cmap.storymaps.layers = {};
        cmap.storymaps.layerData = [];
        cmap.storymaps.storySteps = [];
        cmap.storymaps.storyOverlays = [];

        cmap.storymaps.buildStorySteps = function() {
            var markers = [];
        <#list StorySteps.getSiblings() as cur_StoryStep >
            <#assign storyStepsIndex = cur_StoryStep ? index >
            <#if cur_StoryStep.StepTitle.getData() != "" >
            <#list cur_StoryStep.coords.getSiblings() as cur_Coords >
            markers.push({
                coords: ['${cur_Coords.StepLatitude.getData()}', '${cur_Coords.StepLongitude.getData()}'],
                label: '${cur_Coords.StepMarkerLabel.getData()}',
                zoom: '${cur_Coords.ZoomLevel.getData()}'
            });
            </#list >

            cmap.storymaps.storySteps.push({
                stepTitle: '${cur_StoryStep.StepTitle.getData()}',
                stepMarkers: markers
            });
            markers = [];
            </#if>
        </#list >
        };

        cmap.storymaps.buildLayerData = function() {
        <#list StoryOverlays.getSiblings() as cur_StoryOverlay>
        <#assign storyOverlaysIndex = cur_StoryOverlay?index>
            <#if cur_StoryOverlay.OverlayTitle.getData() != "">
            cmap.storymaps.layerData.push({
                title: '${cur_StoryOverlay.OverlayTitle.getData()}',
                file: '${cur_StoryOverlay.OverlayFile.getData()}'
            });
            </#if>
        </#list>
        };

        cmap.storymaps.loadContent = function(isLocation, index) {

            $('.story-step-content').hide();
            if (isLocation && index > -1) {
                <#if getterUtil.getBoolean(Options.ShowLocationContent.getData())>
                $('#${randomNamespace}location_content' + index).show();
                </#if>
            } else if (index > -1) {
                <#if getterUtil.getBoolean(Options.ShowLayerContent.getData())>
                var contentId = 'layer_content'+index;
                $('#${randomNamespace}' + contentId).show();
                </#if>
            }
        };

        cmap.storymaps.loadOverlay = function (button, index) {

            button.toggleClass('active');
            var layerData = cmap.storymaps.layerData[index];
            var overlayId = 'overlay_'+index;

            if (!cmap.storymaps.layers[overlayId]) {
                button.html('loading...');
                
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
                        button.html(layerData.title);
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

        cmap.storymaps.prev = function () {
            cmap.storymaps.storyStep--;
            cmap.storymaps.storyStep = (cmap.storymaps.storyStep < 0) ? cmap.storymaps.storySteps.length - 1 : cmap.storymaps.storyStep;
            cmap.storymaps.showStoryStep(cmap.storymaps.storyStep);
        };

        cmap.storymaps.next = function () {
            cmap.storymaps.storyStep++;
            cmap.storymaps.storyStep = (cmap.storymaps.storyStep > cmap.storymaps.storySteps.length - 1) ? 0 : cmap.storymaps.storyStep;
            cmap.storymaps.showStoryStep(cmap.storymaps.storyStep);
        };

        cmap.storymaps.showStoryStep = function (step) {

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
            $('.story-interact').addClass('scroll-fixed');
            $('html, body').animate({scrollTop: $('#${randomNamespace}_map').offset().top - $('.story-interact').height()}, 600);
        };

        cmap.storymaps.setPanState = function (step) {
            var marker = cmap.storymaps.storySteps[step].stepMarkers[0];
            // cmap.storymaps.map.panToOffset(marker.coords, [0, 0], parseInt(marker.zoom,10), { animate: true });
            cmap.storymaps.map.setView(marker.coords, marker.zoom, { animate: true });
        };

        cmap.storymaps.setMarkerState = function (step) {

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

            <#if markerColor?? && markerColor.getData()?? && markerColor.getData() != "">
            $('.icon-map-med-dark').css('color', '${markerColor.getData()}');
            <#else>
            $('.icon-map-med-dark').css('color', 'red');
            </#if>
        };

        cmap.storymaps.removeLayer = function (layer) {
            if (layer) {
                cmap.storymaps.map.removeLayer(layer);
            }
        };

        cmap.storymaps.handleScroll = function() {
            if ($('#scroll-nav').hasClass('active')) {
                $('.story-interact').addClass('scroll-fixed');
            } else {
                $('.story-interact').removeClass('scroll-fixed');
            }
        };

        cmap.storymaps.handleResize = function() {
            <#-- magic number from _variables.scss -->
            <#-- $breakpoint-tablet: 750px; -->
            if ($(window).width() >= 750) {
                $('.storymap-info, .storymap-aside, .storymap-source, .layers-menu').show();
            } else {
                $('.storymap-aside, .storymap-source, .layers-menu').hide();
            }
        };

        cmap.storymaps.bindEvents = function () {

            $('.previous-story-step').on('click', function (e) {
                e.preventDefault();
                cmap.storymaps.prev();
            });

            $('.next-story-step').on('click', function (e) {
                e.preventDefault();
                cmap.storymaps.next();
            });

            $('.storymap-nav-container.mobile-storymap-nav').on('swipeleft', function (e) {
                cmap.storymaps.prev();
            });

            $('.storymap-nav-container.mobile-storymap-nav').on('swiperight', function (e) {
                cmap.storymaps.next();
            });

            $(window).on('scroll', _.throttle(cmap.storymaps.handleScroll, 200));

            $(window).on('resize', _.throttle(cmap.storymaps.handleResize, 200));

            $('.view-map').on('click', function () {

                $('.button_overlay').removeClass('active');
                var someLayers = cmap.storymaps.layers;

                for (var mapLayer in cmap.storymaps.layers) {
                    cmap.storymaps.removeLayer(cmap.storymaps.layers[mapLayer]);
                }

                cmap.storymaps.showStoryStep(cmap.storymaps.storyStep);
            });

            $('.story-step-title').on('click', function (e) {
                e.preventDefault();
                cmap.storymaps.storyStep = $(this).data('step');
                cmap.storymaps.showStoryStep(cmap.storymaps.storyStep);
            });

            $('.button_overlay').on('click', function (e) {
                e.preventDefault();
                var $this = $(this);
                <#--  var layerUrl = $this.data('layer-url');
                var fileName = $this.data('file');
                var buttonId = $this.attr('id');
                var overlayId = $this.data('layer-id');
                var contentId = $this.data('content-id');  -->
                //options
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
        };

        cmap.storymaps.initMap = function () {

            <#if styleUrl?? && styleUrl.getData()?? && styleUrl.getData() != "">
            var url = "${styleUrl.getData()}";
            <#else>
            var url = "mapbox://styles/onto2050/cj0jnlcwj007k2sulorlf0zbk";
            </#if>

            L.mapbox.accessToken = 'pk.eyJ1Ijoib250bzIwNTAiLCJhIjoiY2lzdjJycTZrMGE3dDJ5b2RsYTRvaHdiZSJ9.SIUNXOhAVC2rXywtDIrraQ';

            cmap.storymaps.map = L.mapbox.map('${randomNamespace}_map', 'mapbox.streets', {
                maxBounds: [[40.82130, -90.47900], [43.28040, -85.72192]],
                maxZoom: 12,
                minZoom: 8,
                attributionControl: false,
                infoControl: true,
                zoomControl: false
            }).setView([41.8781, -87.6298], 9);

            L.mapbox.styleLayer(url).addTo(cmap.storymaps.map);
            L.control.legend({ position: 'bottomleft'}).addTo(cmap.storymaps.map);
            L.control.layerSwitcher({ position: 'topright'}).addTo(cmap.storymaps.map);
        };

        cmap.storymaps.initMap();
        cmap.storymaps.buildStorySteps();
        cmap.storymaps.buildLayerData();
        cmap.storymaps.bindEvents();
    }
);
</script>
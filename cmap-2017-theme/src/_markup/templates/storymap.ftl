<#assign legendLabels = []>
<#list Legend.getSiblings() as cur_Legend>
  <#if cur_Legend?? && cur_Legend.KeyLabel?? && cur_Legend.KeyLabel.getData()?? && cur_Legend.KeyLabel.getData() != "">
    <#assign legendLabels = legendLabels + [cur_Legend.KeyLabel]>
  </#if>
</#list>

<#assign overlayLabels = []>
<#list StoryOverlays.getSiblings() as cur_StoryOverlay>
  <#if cur_StoryOverlay?? && cur_StoryOverlay.OverlayTitle?? && cur_StoryOverlay.OverlayTitle.getData()?? && cur_StoryOverlay.OverlayTitle.getData() != "">
    <#assign overlayLabels = overlayLabels + [cur_StoryOverlay.OverlayTitle]>
  </#if>
</#list>

<#if legendLabels?size != 0>
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
            data-title="${cur_StoryOverlay.OverlayTitle.getData()}"
            data-file="${cur_StoryOverlay.OverlayFile.getData()}"
            data-layer-id="overlay_${storyOverlaysIndex}">
            ${cur_StoryOverlay.OverlayTitle.getData()}
        </button>
        </#if>
    </#list>
    </div>
</div> 
</#if>

<div class="storymap-section">
    <div class="row storymap-intro-container">
        <div class="col-xl-3 col-lg-4 col-md-4 col-sm-16">
            <div class="storymap-aside">
                ${Aside.getData()}
            </div>
            <div class="storymap-source">
                ${Source.getData()}
            </div>
        </div>
        <div class="col-xl-9 col-lg-12 col-md-12 col-sm-16 title-block">
            <div class="storymap-title">
                ${StoryTitle.getData()}
            </div>
            <div class="storymap-info">
                ${StoryDescription.getData()}
            </div>
        </div>
    </div>
    <div class="row story-interact">
        <div class="storymap-nav-container">
            <div class="col-xl-3 col-lg-4 col-md-4">
            <ul class="list-inline list-unstyled storymap-nav-list">
                <li><button class="view-map"><span class="icon icon-map-marker"></span> View Map</button></li>
            </ul>
            </div>
            <div class="col-xl-9 col-lg-12 col-md-12 story-steps">
            <ul class="list-inline list-unstyled storymap-nav-list pull-left">
            <#list StorySteps.getSiblings() as cur_StoryStep>
            <#assign storyStepsIndex = cur_StoryStep?index>
                <#if cur_StoryStep.StepTitle.getData() != "">
                <li id="${randomNamespace}_step${storyStepsIndex}" class="story-step-title" href="#"
                    data-coordinates="${cur_StoryStep.coords.StepLatitude.getData()}, ${cur_StoryStep.coords.StepLongitude.getData()}"
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
    <a href="#" class="storymap-info-toggle"><span class="icon-info-sign"></i> <span class="sr-only">Toggle Map Info</span></a>
</div>

<div id="map-container">
    <div id="${randomNamespace}_map" class="story-map">
    </div>
</div>

<#list StorySteps.getSiblings() as cur_StoryStep>
<#assign storyStepsIndex = cur_StoryStep?index>
    <div id="${randomNamespace}_content${storyStepsIndex}" class="story-step-content">
    <#list cur_StoryStep.StoryStepContent.getSiblings() as cur_StoryStepContent>
    <#if getterUtil.getBoolean(cur_StoryStepContent.FullWidthContent.getData())>
        <div class="col-xl-16 story-step-content-full-width">
        ${cur_StoryStepContent.Content.getData()}
        </div>
    <#else>
        <div class="story-step-content-centered">
            <div class="row">
                <div class="col-md-16 col-md-offset-0 col-lg-13 col-lg-offset-3 col-xl-offset-3">
                    ${cur_StoryStepContent.Content.getData()}
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

        L.Map.prototype.panToOffset = function (latlng, offset, options) {
            var x = this.latLngToContainerPoint(latlng).x - offset[0]
            var y = this.latLngToContainerPoint(latlng).y - offset[1]
            var point = this.containerPointToLatLng([x, y])
            return this.setView(point, 9, { pan: options })
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
        cmap.storymaps.storySteps = [];
        cmap.storymaps.storyOverlays = [];

        <#list StorySteps.getSiblings() as cur_StoryStep >
            <#assign storyStepsIndex = cur_StoryStep ? index >
            <#if cur_StoryStep.StepTitle.getData() != "" >
            var markers = [];
            <#list cur_StoryStep.coords.getSiblings() as cur_Coords >
            markers.push({
                coords: ['${cur_Coords.StepLatitude.getData()}', '${cur_Coords.StepLongitude.getData()}'],
                label: '${cur_Coords.StepMarkerLabel.getData()}'
            });
            </#list >

            cmap.storymaps.storySteps.push({
                stepTitle: '${cur_StoryStep.StepTitle.getData()}',
                stepMarkers: markers
            });
            </#if>
        </#list >

        cmap.storymaps.loadContent = function(step) {

            $('.story-step-content').hide();
            $('#${randomNamespace}_content' + step).show();
        };

        cmap.storymaps.loadOverlay = function (options) {

            var $button = $('.button_overlay[data-layer-id="' + options.overlayId + '"]');

            $button.toggleClass('active');

            if (!cmap.storymaps.layers[options.overlayId]) {
                $button.html('loading...');
                $.ajax({
                    dataType: "json",
                    url: options.fileName,
                    success: function (data) {
                        cmap.storymaps.layers[options.overlayId] = L.geoJSON(data, { style: L.mapbox.simplestyle.style });
                        cmap.storymaps.layers[options.overlayId].addTo(cmap.storymaps.map);
                        $('.overlays').children().removeClass('disabled-loading');
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(errorThrown);
                    },
                    complete: function () {
                        $button.html($button.data('title'));
                    }
                });
            } else {
                $('.overlays').children().removeClass('disabled-loading');
                if (cmap.storymaps.map.hasLayer(cmap.storymaps.layers[options.overlayId])) {
                    cmap.storymaps.map.removeLayer(cmap.storymaps.layers[options.overlayId]);
                } else {
                    cmap.storymaps.layers[options.overlayId].addTo(cmap.storymaps.map);
                }
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
                cmap.storymaps.loadContent(step);
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
            cmap.storymaps.map.panToOffset(cmap.storymaps.storySteps[step].stepMarkers[0].coords, [0, 0], { animate: true });
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
            // magic number from _variables.scss
            // $breakpoint-tablet: 750px;
            if ($(window).width() >= 750) {
                $('.title-block, .storymap-aside, .storymap-source, .layers-menu').show();
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
                var layerUrl = $this.data('layer-url');
                var fileName = $this.data('file');
                var buttonId = $this.attr('id');
                var overlayId = $this.data('layer-id');
                //options
                cmap.storymaps.loadOverlay({
                    fileName: fileName,
                    buttonId: buttonId,
                    overlayId: overlayId,
                    layerUrl: layerUrl
                });
            });

            $('.storymap-info-toggle').on('click', function (e) {
                e.preventDefault();
                $('.title-block, .storymap-aside, .storymap-source').toggle();
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
                maxZoom: 11,
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
        cmap.storymaps.bindEvents();
    }
);
</script>
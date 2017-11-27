<div id="map-container">
    <div id="${randomNamespace}_map" class="story-map">
    </div>
    <div class="storymap-section">
        <a href="#" class="storymap-info-toggle visible-xs-block"><span class="icon-info-sign"></i> <span class="sr-only">Toggle Map Info</span></a>
        <div class="row storymap-intro-container">
            <div class="col-xl-9 col-xl-offset-3 col-lg-8 col-md-10 col-md-offset-0 col-sm-16 title-block">
                <div class="storymap-title">
                    ${StoryTitle.getData()}
                </div>
                <div class="storymap-info">
                    ${StoryDescription.getData()}
                </div>
            </div>
            <div class="col-xl-3 col-xl-offset-1 col-lg-4 col-md-5 col-md-offset-1 col-sm-16">
                <div class="storymap-aside hidden-xs">
                    ${Aside.getData()}
                </div>
                <div class="storymap-source hidden-xs">
                    ${Source.getData()}
                </div>
            </div>
        </div>
        <div class="row story-interact hidden-xs">
            <div class="row storymap-nav-container hidden-xs">
                <ul class="col-xl-3 list-inline">
                    <li><button class="view-map"><span class="icon icon-map-marker"></span> View Map</button></li>
                </ul>
                <ul class="col-xl-8 story-steps list-inline">
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
                <ul class="col-xl-3 col-xl-offset-1 story-arrows list-inline">
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
            <!-- div class="row storymap-nav-container mobile-storymap-nav">
                <div class="col-xs-1">
                    <a href="#" class="previous-story-step"><span class="icon-cmap icon-nav-left-white"></span> <span class="sr-only">Previous</span></a>
                </div>
                <div class="col-xs-14 text-center">
                    <span class="xs-story-step-title story-step-title story-active"></span>
                </div>
                <div class="col-xs-1">
                    <a href="#" class="next-story-step"><span class="icon-cmap icon-nav-right-white"></span> <span class="sr-only">Next</span></a>
                </div>
            </div -->
            <div class="storymap-overlays-container col-xl-14 col-xl-offset-1">
                <div class="">
                <p class="text-right hidden-xs">
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
                </p>
                <p class="text-right visible-xs-block">
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
                </p>
                </div>
            </div>
        </div>
    </div>
</div>
    <div class="row">
        <div class="col-xl-16 col-xl-offset-1">
            <#list StorySteps.getSiblings() as cur_StoryStep>
            <#assign storyStepsIndex = cur_StoryStep?index>
                <#if cur_StoryStep.StepContent.getData() != "">
                <div id="${randomNamespace}_content${storyStepsIndex}" class="story-step-content">
                <#list cur_StoryStep.StepContent.getSiblings() as cur_StoryStepContent>
                ${cur_StoryStepContent.getData()}
                </#list>
                </div>
                </#if>
            </#list>
        </div>
    </div>

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
            } else {
                // TODO: default state
            }
        };

        cmap.storymaps.setPanState = function (step) {
            var yOffset = $('.storymap-section').height()/2;
            cmap.storymaps.map.panToOffset(cmap.storymaps.storySteps[step].stepMarkers[0].coords, [0, yOffset], { animate: true });
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

            if (window.scrollY > $('#${randomNamespace}_map').height()) {
                $('.storymap-overlays-container').hide();
            } else {
                $('.storymap-overlays-container').show();
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

            $('.story-step-title, .next-story-step, .previous-story-step').on('click swipeleft swiperight', function () {
                var containerOffset = $('.storymap-intro-container').offset().top + $('.storymap-intro-container').height();
                $("html, body").animate({ scrollTop: containerOffset }, 600);
            });

            $('.view-map').on('click', function () {
                
                var containerOffset = $('.storymap-intro-container').offset().top + $('.storymap-intro-container').height();
                $("html, body").animate({ scrollTop: containerOffset }, 600);

                $('.button_overlay').removeClass('active');
                var someLayers = cmap.storymaps.layers;

                for (var mapLayer in someLayers) {
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
                $('.title-block').toggle();
                $('.storymap-aside, .storymap-source').toggleClass('hidden-xs');
            });

            $('.view-layers-button').on("click", function (e) {
                $(this).children('.icon-text')
                    .text(function (i, text) {
                        return text === "View Layers" ? "Hide Layers" : "View Layers";
                    });
                $('.layers-menu').toggleClass('menu-show');
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
            }).setView([41.8781, -87.6298], 9);

            var styleLayer = L.mapbox.styleLayer(url).addTo(cmap.storymaps.map);
        };

        cmap.storymaps.initMap();
        cmap.storymaps.bindEvents();
    }
);
</script>
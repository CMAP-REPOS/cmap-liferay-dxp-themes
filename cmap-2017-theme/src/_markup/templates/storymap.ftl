<div id="map-container">
    <div id="${randomNamespace}_map" class="story-map">
    </div>
    <div class="storymap-section">
        <a href="#" class="storymap-info-toggle visible-xs-block"><span class="icon-info-sign"></i> <span class="sr-only">Toggle Map Info</span></a>
        <div class="row storymap-intro-container">
            <div class="col-xl-6 col-xl-offset-4 col-xs-16 col-xs-offset-0 title-block">
                <div class="storymap-title">
                    ${StoryTitle.getData()}
                </div>
                <p class="storymap-info col-xl-16 col-xl-offset-0 col-xs-12 col-xs-offset-1">
                ${StoryDescription.getData()}
                <p>
            </div>
            <div class="col-xl-4 col-xl-offset-1 col-xs-12 col-xs-offet-1">
                <div class="storymap-aside hidden-xs">
                    ${Aside.getData()}
                </div>
                <div class="storymap-source hidden-xs">
                    ${Source.getData()}
                </div>
            </div>
        </div>
        <div class="story-interact">
        <div class="storymap-nav-container hidden-xs col-xl-16">
                       <ul class="col-xl-16">
            <li class="col-xl-3 col-xl-offset-1">
                <button class="view-map"><span class="icon icon-map-marker"></span> View Map</button>
            </li>
            <ul class="story-steps col-xl-7">
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
                <ul class="col-xl-3 story-arrows">
                    <li href="#" class="previous-story-step"><span class="icon-cmap icon-nav-left-white"></span> <span class="sr-only">Previous</span></li>
                    <li href="#" class="next-story-step"><span class="icon-cmap icon-nav-right-white"></span> <span class="sr-only">Next</span></li>
                </ul>
            </ul>
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
        <div class="storymap-overlays-container">
            <div class="col-xl-14 col-xl-offset-1">
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

AUI().ready(

	function() {


        L.Map.prototype.panToOffset = function (latlng, offset, options) {
            var x = this.latLngToContainerPoint(latlng).x - offset[0]
            var y = this.latLngToContainerPoint(latlng).y - offset[1]
            var point = this.containerPointToLatLng([x, y])
            return this.setView(point, this._zoom, { pan: options })
        }

        var storymaps = storymaps || {};
        storymaps.storyStep = -1;
        storymaps.markerLayer = null;
        storymaps.layers = {};
        storymaps.storySteps = [];
        storymaps.storyOverlays = [];
        storymaps.storyVariance = ($(window).width() > 420) ? 100 : 70;


        <#list StorySteps.getSiblings() as cur_StoryStep>
            <#assign storyStepsIndex = cur_StoryStep?index>
            <#if cur_StoryStep.StepTitle.getData() != "">
            var coords = [];
            var markers = [];
            //coords
            <#list cur_StoryStep.coords.getSiblings() as cur_Coords>
            coords.push(['${cur_Coords.StepLatitude.getData()}','${cur_Coords.StepLongitude.getData()}']);
            markers.push(['${cur_StoryStep.coords.StepMarkerLabel.getData()}']);
            console.log(markers);
            </#list>

        storymaps.storySteps.push({
            stepTitle: '${cur_StoryStep.StepTitle.getData()}',
            stepCoords: coords,
            stepMarkerLabel: markers
        });
        console.log(storymaps.storySteps.stepCoords);
            </#if>
        </#list>

        storymaps.loadContent = function(step) {
            console.log('storymaps.loadContent()' + step);
            $('.story-step-content').hide();
            $('#${randomNamespace}_content' +step).show();
        };



        storymaps.loadOverlay = function(options) {
            console.log('storymaps.loadOverlay()');
            console.log(options);
            var $button = $('.button_overlay[data-layer-id="' + options.overlayId + '"]');

            $button.toggleClass('active');

            if (!storymaps.layers[options.overlayId]) {
                $button.html('loading...');
                $.ajax({
                    dataType: "json",
                    url: options.fileName,
                    success: function(data) {
                        storymaps.layers[options.overlayId] = L.geoJSON(data, { style: L.mapbox.simplestyle.style });
                        storymaps.layers[options.overlayId].addTo(storymaps.map);
                        $('.overlays').children().removeClass('disabled-loading');
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(errorThrown);
                    },
                    complete: function() {
                        $button.html($button.data('title'));
                    }
                });
            } else {
                $('.overlays').children().removeClass('disabled-loading');
                if (storymaps.map.hasLayer(storymaps.layers[options.overlayId])) {
                    storymaps.map.removeLayer(storymaps.layers[options.overlayId]);
                } else {
                    storymaps.layers[options.overlayId].addTo(storymaps.map);
                }
            }
        };

        storymaps.prev = function () {
            console.log('storymaps.prev()');
            storymaps.storyStep--;
            storymaps.storyStep = (storymaps.storyStep < 0) ? storymaps.storySteps.length - 1 : storymaps.storyStep;
            storymaps.showStoryStep(storymaps.storyStep);
        };

        storymaps.next = function () {
            console.log('storymaps.next()');
            storymaps.storyStep++;
            storymaps.storyStep = (storymaps.storyStep > storymaps.storySteps.length - 1) ? 0 : storymaps.storyStep;
            storymaps.showStoryStep(storymaps.storyStep);
        };

        storymaps.showStoryStep = function(step) {
            console.log('storymaps.showStoryStep(): ' + step);
            $('.story-step-title').removeClass('story-active');
            $('#${randomNamespace}_step'+step).addClass('story-active');
            $('.xs-story-step-title').html(storymaps.storySteps[step].stepTitle);

            storymaps.setMarkerState(step);
            storymaps.setPanState(step);
            storymaps.loadContent(step);
        };

        storymaps.setPanState = function (step) {
            console.log('storymaps.setPanState(): ' + step);
            var yOffset = 120;
            if ($(window).width() < 420) {
                yOffset = 100;
            }
            console.log(storymaps.storySteps[step].stepCoords[0]);
            storymaps.map.panToOffset(storymaps.storySteps[step].stepCoords[0], [0, yOffset], { animate: true });
        };

        storymaps.setMarkerState = function (step) {
            console.log('storymaps.setMarkerState(): ' + step);
            var cmapIcon = L.divIcon({ className: 'icon-cmap icon-map-med-dark' });

            if (storymaps.markerLayer !== null) {
                storymaps.map.removeLayer(storymaps.markerLayer);
                console.log(storymaps.markerLayer);
            }
            storymaps.markerLayer = [];
            for(i=0; i < storymaps.storySteps[step].stepCoords.length; i++){
            //need to have these in a collection of an array most likely, so they get added and removed. marker layer needs all of them.

            mapPin = new L.marker(storymaps.storySteps[step].stepCoords[i], { icon: cmapIcon, interactive: false });
            storymaps.markerLayer.push(mapPin);
            storymaps.markerLayer[i].addTo(storymaps.map);

            }
            if (jQuery.trim(storymaps.storySteps[step].stepMarkerLabel).length) {
                storymaps.markerLayer.bindTooltip(storymaps.storySteps[step].stepMarkerLabel[i]).openTooltip();
            }

            //change colors based on if set.
            pinColor = '${markerColor.getData()}';
            if( pinColor != ''){
                $('.icon-map-med-dark').css('color', pinColor);
            }
            else {
                $('.icon-map-med-dark').css('color', 'red');
            }
        };

        storymaps.removeLayer = function(layer) {
            console.log('storymaps.removeLayer()');
            if (layer) {
                storymaps.map.removeLayer(layer);
            }
        };

       	$(function() {
       	var scrollHandler = function() {
        return {
            // properties
            lastScrollTop: $(this).scrollTop(),
            lastAction: null,

            // main scroll-handling function
            handleScroll: function() {
                var navBarPos = $('.storymap-intro-container').offset().top;
                var mapPos = $('.story-map').offset().top;
                var mapHeight = $('#map-container').height();
                var mapScroll = mapPos+mapHeight;

                // clear prev action
                clearTimeout(scrollHandler.lastAction);

                // get new scroll position
                var scrollPos = $(this).scrollTop();

                // end...set new lastScrollTop val
                scrollHandler.lastScrollTop = scrollPos;
                //divide by 1.45 since that seems to be about where the bar sits on the page...
                if(scrollPos/1.60 > navBarPos){
                    $('.story-interact').addClass('scroll-fixed');
                }
                else{
                     $('.story-interact').removeClass('scroll-fixed');
                }
                if (scrollPos > mapScroll - scrollPos/.7){

                    //$('.storymap-overlays-container').addClass('scroll-fixed');
                    if(scrollPos > mapScroll - 140){
                    $('.storymap-overlays-container').hide();
                    }
                    else{
                        $('.storymap-overlays-container').show();
                    }
                }
                else{
                    // $('.storymap-overlays-container').show();
                    $('.storymap-overlays-container').removeClass('scroll-fixed');
                }
            }
        }
    }();
    $(window).on('scroll', scrollHandler.handleScroll);
	});

        storymaps.bindEvents = function() {
                   //console.log('storymaps.bindEvents()');

                   $('.previous-story-step').on('click', function(e) {
                       e.preventDefault();
                       storymaps.prev();
                   });

                   $('.next-story-step').on('click',function(e) {
                       e.preventDefault();
                       storymaps.next();
                   });

                   $('.storymap-nav-container.mobile-storymap-nav').on('swipeleft', function(e){
                       storymaps.prev();
                   });

                   $('.storymap-nav-container.mobile-storymap-nav').on('swiperight',function(e) {
                       storymaps.next();
                   });
                   $('.story-step-title, .next-story-step, .previous-story-step').on("click swipeleft swiperight", function(){


                        var containerOffset = $('.storymap-intro-container').offset().top + $('.storymap-section').height() - storymaps.storyVariance;
                        var y = $(window).scrollTop();  //your current y position on the page

                        if (y < containerOffset){
                        $("html, body").animate({ scrollTop: containerOffset - 50 }, 600);
                    } else if (y > containerOffset){
                         $("html, body").animate({ scrollTop: containerOffset - 50 }, 600);
                    }
                   });

                   $('.view-map').on("click", function(){
                        var variance = 40;
                        if($(window).width() < 420){
                            variance = 80;
                        }
                        var navOffset = $('.storymap-nav-container').offset().top;
                        var containerOffset = $('.storymap-intro-container').offset().top + $('.storymap-section').height() - variance;
                        var y = $(window).scrollTop();  //your current y position on the page

                        if (y == 0){
                            $("html, body").animate({ scrollTop: y + navOffset }, 600);
                        }
                        else{
                            $("html, body").animate({ scrollTop: containerOffset }, 600);
                        }

                        //$('.story-step-title').removeClass('story-active');
                        $('.button_overlay').removeClass('active');
                        //storymaps.removeLayer(storymaps.markerLayer);
                        var someLayers = storymaps.layers;

                        for (var mapLayer in someLayers){
                            storymaps.removeLayer(storymaps.layers[mapLayer]);
                        }
                        storymaps.map.setView([41.8781, -87.6298], 9);
                        });

                   $('.story-step-title').on('click', function (e) {
                       e.preventDefault();
                       storymaps.storyStep = $(this).data('step');
                       storymaps.showStoryStep(storymaps.storyStep);
                   });

                   $('.button_overlay').on('click', function(e) {
                       e.preventDefault();
                       var $this = $(this);
                       var layerUrl = $this.data('layer-url');
                       var fileName = $this.data('file');
                       var buttonId = $this.attr('id');
                       var overlayId = $this.data('layer-id');
                       //options
                       storymaps.loadOverlay({
                           fileName: fileName,
                           buttonId: buttonId,
                           overlayId: overlayId,
                           layerUrl: layerUrl
                       });
                   });

                   $('.storymap-info-toggle').on('click', function(e) {
                       e.preventDefault();
                       $('.title-block').toggle();
                       $('.storymap-aside, .storymap-source').toggleClass('hidden-xs');
                   });

                   $('.view-layers-button').on("click", function(e){
                       $(this).children('.icon-text')
                       .text(function(i, text){
                            return text === "View Layers" ? "Hide Layers" : "View Layers";
                        });
                        $('.layers-menu').toggleClass('menu-show');
                   });
               };



        storymaps.initMap = function() {
            console.log('storymaps.initMap()');
            var url = "${styleUrl.getData()}";
            //var url = "mapbox://styles/onto2050/cj0jnlcwj007k2sulorlf0zbk";
            //var url = 'mapbox://styles/nmpeterson/cj8w0opw1fomf2ss2mu8iz3me';
            //L.mapbox.accessToken = 'pk.eyJ1Ijoibm1wZXRlcnNvbiIsImEiOiJGdDBLWXJvIn0.ZXxlwjkZH2vEyr3U0aKC4A';
            L.mapbox.accessToken = 'pk.eyJ1Ijoib250bzIwNTAiLCJhIjoiY2lzdjJycTZrMGE3dDJ5b2RsYTRvaHdiZSJ9.SIUNXOhAVC2rXywtDIrraQ';

            storymaps.map = L.mapbox.map('${randomNamespace}_map', 'mapbox.streets', {
                maxBounds: [[40.82130, -90.47900], [43.28040, -85.72192]],
                maxZoom: 11,
                minZoom: 8,
                attributionControl: false,
                infoControl: true,
            }).setView([41.8781, -87.6298], 9);

            var styleLayer = L.mapbox.styleLayer(url).addTo(storymaps.map);
        };

        storymaps.initMap();
        storymaps.bindEvents();
        //storymaps.showStoryStep(storymaps.storyStep);
        cmap.initSocialShare($('.storymap-nav'));
    }
);
</script>

//make a new function for our panning around to adjust the view by a certain offset.
L.Map.prototype.panToOffset = function (latlng, offset, options) {
    var x = this.latLngToContainerPoint(latlng).x - offset[0]
    var y = this.latLngToContainerPoint(latlng).y - offset[1]
    var point = this.containerPointToLatLng([x, y])
    return this.setView(point, this._zoom, { pan: options })
}

  var storyVariance = 70;
    if($(window).width() > 420){

        storyVariance = 100;
    }


//make an object that's like a class. if it exists, we refer to it as cmap. otherwise, make a new object called cmap.
    var cmap = cmap || {};
    cmap.storyStep = 0;
    cmap.markerLayer = null;
    cmap.layer = null;
    cmap.locked = false;
    cmap.layers = {};

//get the data for each story step in an array.
    cmap.storySteps = [];
    #foreach ($item in $story-steps.getSiblings())
            #if ($item.step-title.getData() != "")
            cmap.storySteps.push({
            stepTitle: '$item.step-title.getData()', //whatever the title is
            stepCoords: ['$item.latCoordinates.getData()','$item.lonCoordinates.getData()'],
            #if ($item.step-marker-label.getData() && $item.step-marker-label.getData() != "")
            stepMarkerLabel: '$item.step-marker-label.getData()'
            #end
            });
            #end
        #end
//create configuration object.
  cmap.storyOverlays = [];
    #foreach ($item in $story-steps.getSiblings())

        #set ($storyStepsIndex = $velocityCount)
        #if ($item.overlays.getSiblings() != "")
            #foreach ($button in $item.overlays.getSiblings())
            #if ($button.overlay-title.getData() && $button.overlay-file.getData() != "")
                #set ($buttonIndex = $velocityCount)

                var storyOverlay = {
                    fileName: '$button.overlay-file.getData()',
                    fileId: 'file_$storyStepsIndex$buttonIndex', // file_00, file_01, etc
                    stepTitle: '$button.overlay-title.getData()',
                    buttonId: 'button_$storyStepsIndex$buttonIndex', // button_00, button_01, etc
                    overlayId: 'overlay_$storyStepsIndex$buttonIndex' // overlay_00, overlay_01, etc
                }

                cmap.storyOverlays.push(storyOverlay);
            //bind event.
                $('#'+'button_$storyStepsIndex$buttonIndex').on('click', function(event) {
                         $(this).addClass('disabled-loading');

                  event.preventDefault();
                    cmap.loadOverlay({
                      fileName: '$button.overlay-file.getData()',
                      overlayId: 'overlay_$storyStepsIndex$buttonIndex' // overlay_00, overlay_01, etc
                  });
                });

                #end
            #end
        #end
    #end

// storyOverlay is a single object from cmap.storyOverlays
cmap.loadOverlay = function(storyOverlay) {
  // if this object does not have a "layer" property, fetch the file
  if (!cmap.layers[storyOverlay.overlayId]) {
    jQuery.ajax({
      dataType: "json",
      url: storyOverlay.fileName,
      success: function(data) {
        // create layer and attach it to storyOverlay object
        // cmap.layers.overlay_11 = L.geoJSON(data);
        cmap.layers[storyOverlay.overlayId] = L.geoJSON(data);
        // add layer to map (it can't be there already because it didn't exist)
        cmap.layers[storyOverlay.overlayId].addTo(cmap.map);
        $('.overlays').children().removeClass('disabled-loading');
      }
    });
  } else {
      $('.overlays').children().removeClass('disabled-loading');
    if (cmap.map.hasLayer(cmap.layers[storyOverlay.overlayId])) {
      // if layer is already on map, remove it

      cmap.map.removeLayer(cmap.layers[storyOverlay.overlayId]);
    } else {
      // add layer to map
      cmap.layers[storyOverlay.overlayId].addTo(cmap.map);
    }
  }
}

//initializing the map, setting our view, and leaflet does its job.
    cmap.initMap = function() {
        var url = "mapbox://styles/onto2050/cj0jnlcwj007k2sulorlf0zbk";
L.mapbox.accessToken = 'pk.eyJ1Ijoib250bzIwNTAiLCJhIjoiY2lzdjJycTZrMGE3dDJ5b2RsYTRvaHdiZSJ9.SIUNXOhAVC2rXywtDIrraQ';

      cmap.map = L.mapbox.map('mapid', 'mapbox.streets', {
       maxBounds: [[40.82130, -90.47900], [43.28040, -85.72192]],
       maxZoom: 11,
        minZoom: 8,
        attributionControl: false,
        infoControl: true,
      }).setView([41.8781, -87.6298], 9);

       var styleLayer = L.mapbox.styleLayer(url)
    .addTo(cmap.map);

    };


    cmap.prev = function(){


        var containerOffset = $('.storymap-top').offset().top + $('.storymap-section').height() - storyVariance;

  var y = $(window).scrollTop();  //your current y position on the page

  if (y < containerOffset){
      $("html, body").animate({ scrollTop: containerOffset - 50}, 600);
  }

        cmap.storyStep = cmap.storyStep-1;
        cmap.storyStep = (cmap.storyStep < 0) ? cmap.storySteps.length-1 : cmap.storyStep;
        cmap.showStoryStep(cmap.storyStep);
        //needs to trigger lower content... search for active ID and switch the content

      if($('.story-step-title:first').hasClass('story-active')){
            $('.story-step-title:first').removeClass('story-active').addClass('story-inactive')
            $('.story-step-title:last').addClass('story-active').removeClass('story-inactive');
        }
        else{
        $('.story-step-title.story-active').prev().addClass('story-active').removeClass('story-inactive').next().removeClass('story-active').addClass('story-inactive');
        }
        //get the ID, then add inactive class to all of the children. Find the matching ID, add active class.
       var activeId = $('.story-step-title.story-active').attr('id');
    $('.storymap-lower-content').children().removeClass('story-active').addClass('story-inactive');
       $('.storymap-lower-content').find('#'+activeId).addClass('story-active').removeClass('story-inactive');



    }

    cmap.next = function(){

        var containerOffset = $('.storymap-top').offset().top + $('.storymap-section').height() - storyVariance;

  var y = $(window).scrollTop();  //your current y position on the page

  if (y < containerOffset){
      $("html, body").animate({ scrollTop: containerOffset - 50 }, 600);
  }

        cmap.storyStep = cmap.storyStep+1;
        cmap.storyStep = (cmap.storyStep > cmap.storySteps.length-1) ? 0 : cmap.storyStep;
        cmap.showStoryStep(cmap.storyStep);

        if($('.story-step-title:last').hasClass('story-active')){
            $('.story-step-title:last').removeClass('story-active').addClass('story-inactive')
            $('.story-step-title:first').addClass('story-active').removeClass('story-inactive');
        }
        else{
            $('.story-step-title.story-active').next().addClass('story-active').removeClass('story-inactive').prev().removeClass('story-active').addClass('story-inactive');
        }
        var activeId = $('.story-step-title.story-active').attr('id');
       $('.storymap-lower-content').children().removeClass('story-active').addClass('story-inactive');
       $('.storymap-lower-content').find('#'+activeId).addClass('story-active').removeClass('story-inactive');

    }


    cmap.bindEvents = function() {
        //prev button
      $('.storymap-section .icon-nav-left-dark').on("click", function() {
        cmap.prev();
      });

        //next button
      $('.storymap-section .icon-nav-right-dark').on("click",function() {
        cmap.next();
      });

      //////////////Mobile//////////////
      //swipe functions may need to be separate from the arrows, and instead apply to the container.
      //Its not ideal to completely repat this code, but I'm not sure how else to do this... unless it were in its own pair of functions.
      //Prev
      $('.story-steps').on("swipeleft", function(){
          //only swipe if mobile
      if($(window).width() < 420){
       cmap.prev();
      }
      });

  //next button
      $('.story-steps').on("swiperight",function() {
          if($(window).width() < 420){
        cmap.next();
          }
      });


//end mobile

    };

    cmap.showStoryStep = function(step) {

        cmap.setMarkerState(step);
        cmap.setPanState(step);
    };


//we pan to the coordinate in this story step...
    cmap.setPanState = function(step) {
  var yOffset = 120;
  if($(window).width() < 420){
      yOffset = 100;
  }
      cmap.map.panToOffset(cmap.storySteps[step].stepCoords, [0, yOffset], { animate: true});
    //cmap.map.setView(cmap.storySteps[step].stepCoords, 10, { animate: true});

    }

//there are marker icons someplace
    cmap.setMarkerState = function(step) {
        var cmapIcon = L.divIcon({className: 'icon icon-map-med-dark'});
      if (cmap.markerLayer !== null) {
        cmap.map.removeLayer(cmap.markerLayer);
      }
      //removed new
     cmap.markerLayer = new L.marker(cmap.storySteps[step].stepCoords, {icon: cmapIcon}).addTo(cmap.map);
     if (jQuery.trim(cmap.storySteps[step].stepMarkerLabel).length) {



         cmap.markerLayer.bindTooltip(cmap.storySteps[step].stepMarkerLabel).openTooltip();
     }
      //cmap.markerLayer = new cmapIcon(cmap.storySteps[step].stepCoords).addTo(cmap.map);
    }


//overlay related.
    cmap.toggleLayer = function(layer) {
      if (layer && cmap.map.hasLayer(layer)) {
        cmap.map.removeLayer(layer);
      } else {
        layer.addTo(cmap.map);
      }
    }

//also overlay related.
    cmap.removeLayer = function(layer) {
      if (layer) {
        cmap.map.removeLayer(layer);
      }
    }




//Loading non specific layers
         cmap.loadLayer = function(step) {
      cmap.removeLayer(cmap.layer);
      cmap.layer = new L.geoJson();
      cmap.layer.addTo(cmap.map);

//loop through the array, get all files and load 'em

for (var i=0; i < cmap.storyOverlays.length; i++){
//check if we have any actual data there
    if (cmap.storyOverlays[i]['fileName'] != ""){
      jQuery.ajax({
        dataType: "json",
        url: cmap.storyOverlays[i]['fileName'],
        success: function(data) {
//if we got the file, great!
          $(data.features).each(function(key, data) {
              //we don't care about the shape of the data, just put it out there
              cmap.layer.addData(data);
              cmap.layer.geoid = geoid;
          });
        }
      }).error(function(data) {
          //if not, tell us what went wrong.
        console.log('error');
        console.log(data);
      });
}

         }

    };


//set everything into motion. (?)
    $(function() {
      cmap.initMap();
      cmap.bindEvents();
      cmap.showStoryStep(cmap.storyStep);
    });


$('.story-step-title').click(function(){


    var containerOffset = $('.storymap-top').offset().top + $('.storymap-section').height() - storyVariance;
  var y = $(window).scrollTop();  //your current y position on the page

  if (y < containerOffset){
      $("html, body").animate({ scrollTop: containerOffset - 50 }, 600);
  }

var thisStepId = $(this).attr('id');
var thisStepIndex = $(this).data("step");
//Js starts at index 0, LR likes to start at 1
cmap.storyStep = thisStepIndex-1;
        cmap.showStoryStep(cmap.storyStep);

$('.storymap-lower-content, .story-steps').children('.story-map-step, .story-step-title').removeClass('story-active').addClass('story-inactive');
$('.storymap-lower-content, .story-steps').find('#'+thisStepId).addClass('story-active').removeClass('story-inactive');

});

$('.story-map-step:first-child').addClass('story-active').removeClass('story-inactive');
$('.story-step-title:first').addClass('story-active').removeClass('story-inactive');




   $(function() {var scrollHandler = function() {
        return {
            // properties
            lastScrollTop: $(this).scrollTop(),
            lastAction: null,

            // main scroll-handling function
            handleScroll: function() {
                var navBarPos = $('.storymap-top').offset().top;
                var mapPos = $('.story-map').offset().top;
                var mapHeight = $('#mapid').height();
                var mapScroll = mapPos+mapHeight;



                // clear prev action
                clearTimeout(scrollHandler.lastAction);

                // get new scroll position
                var scrollPos = $(this).scrollTop();

                // end...set new lastScrollTop val
                scrollHandler.lastScrollTop = scrollPos;
                //divide by 2 since that seems to be about where the bar sits on the page... don't know if this needs to be adjusted to not be so magic numberish yet.
                if(scrollPos/2 > navBarPos){
                    $('.story-nav').addClass('scroll-fixed');
                }
                else{
                     $('.story-nav').removeClass('scroll-fixed');
                }
                if (scrollPos > mapScroll - 140){
                    $('.overlay-button-container').hide();
                }
                else{
                    $('.overlay-button-container').show();
                }
            }
        }
    }();
    $(window).on('scroll', scrollHandler.handleScroll);
});
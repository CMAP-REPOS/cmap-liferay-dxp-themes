(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define('storymaps', [], factory);
    } else if (typeof module === 'object' && module.exports) {
        module.exports = factory();
    } else {
        root.storymaps = factory();
  }
}(this, function () {

	var map = null;
	var layers = null;

    var setPanState = function(step) {
	  var yOffset = 120;
	  if($(window).width() < 420){
	      yOffset = 100;
	  }
	  
	  map.panToOffset(cmap.storySteps[step].stepCoords, [0, yOffset], { animate: true});
	};       
	
    setMarkerState = function(step) {
    	var cmapIcon = L.divIcon({className: 'icon icon-map-med-dark'});
    	if (cmap.markerLayer !== null) {
    		cmap.map.removeLayer(cmap.markerLayer);
    	}
    	cmap.markerLayer = new L.marker(cmap.storySteps[step].stepCoords, {icon: cmapIcon}).addTo(cmap.map);
    };
	
    return {
//    	layers: layers,
//    	map: map,
//        storySteps: [],
//        storyOverlays: [],
//        
//        loadOverlay: function(storyOverlay) {
//        	console.log('storymaps.loadOverlay()');
//        	console.log(storyOverlay);
//        	if (!layers[storyOverlay.overlayId]) {
//        		jQuery.ajax({
//        			dataType: "json",
//        			url: storyOverlay.fileName,
//        			success: function(data) {
//        				layers[storyOverlay.overlayId] = L.geoJSON(data);
//        				layers[storyOverlay.overlayId].addTo(map);
//        				$('.overlays').children().removeClass('disabled-loading');
//        			}
//        		});
//    		} else {
//    			$('.overlays').children().removeClass('disabled-loading');
//    			if (map.hasLayer(layers[storyOverlay.overlayId])) {
//    				map.removeLayer(layers[storyOverlay.overlayId]);
//				} else {
//					layers[storyOverlay.overlayId].addTo(map);
//				}
//    		}
//        },
//        
//        initMap: function(options) {
//        	console.log('storymaps.initMap()');
//        	console.log(options);
//        	var url = "mapbox://styles/onto2050/cj0jnlcwj007k2sulorlf0zbk";
//        	L.mapbox.accessToken = 'pk.eyJ1Ijoib250bzIwNTAiLCJhIjoiY2lzdjJycTZrMGE3dDJ5b2RsYTRvaHdiZSJ9.SIUNXOhAVC2rXywtDIrraQ';
//        	
//        	map = L.mapbox.map(options.mapId, 'mapbox.streets', {
//        		// maxBounds: [[40.82130, -90.47900], [43.28040, -85.72192]],
//        		maxZoom: 11,
//        		minZoom: 8,
//        		attributionControl: false,
//        		infoControl: true,
//        	});
//
//        	var styleLayer = L.mapbox.styleLayer(url).addTo(map);
//        	return map;
//        },
//
//        bindEvents: function() {
//        	//prev button
//        	$('.storymap-section .icon-nav-left-dark').on("click", function() {
//        		cmap.prev();
//        	});
//
//			//next button
//			$('.storymap-section .icon-nav-right-dark').on("click",function() {
//				cmap.next();
//			});
//
//			//////////////Mobile//////////////
//			//swipe functions may need to be separate from the arrows, and instead apply to the container.
//			//Its not ideal to completely repat this code, but I'm not sure how else to do this... unless it were in its own pair of functions.
//			//Prev
//			$('.story-steps').on("swipeleft", function(){
//				//only swipe if mobile
//				if ($(window).width() < 420) {
//					cmap.prev();
//				}
//			});
//
//			$('.story-steps').on("swiperight", function(){
//				//only swipe if mobile
//				if ($(window).width() < 420) {
//				    cmap.next();
//				}
//			});
//        },
//
//        showStoryStep: function(step) {
//            setMarkerState(step);
//            setPanState(step);
//        }

    }

}));

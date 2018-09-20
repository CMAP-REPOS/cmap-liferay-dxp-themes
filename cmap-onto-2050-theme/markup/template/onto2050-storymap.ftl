<#assign layers = []>
<#assign locations = []>

<script>
    define._amd = define.amd;
    define.amd = false;
</script>

<#assign serviceContext = staticUtil["com.liferay.portal.kernel.service.ServiceContextThreadLocal"].getServiceContext()>
<#assign themeDisplay = serviceContext.getThemeDisplay() /><#assign serviceContext = staticUtil["com.liferay.portal.kernel.service.ServiceContextThreadLocal"].getServiceContext()>
<#assign themeDisplay = serviceContext.getThemeDisplay() />

<script type="text/javascript" src="${themeDisplay.getPathThemeJavaScript()}/vendor/leaflet.min.js"></script> 
<script type="text/javascript" src="${themeDisplay.getPathThemeJavaScript()}/vendor/mapbox.min.js"></script> 
<script type="text/javascript" src="${themeDisplay.getPathThemeJavaScript()}/storymaps.js"></script> 
<script>
    define.amd = define._amd;
</script>
<link rel="stylesheet" href="${themeDisplay.getPathThemeCss()}/vendor/leaflet.css" /> 
<link rel="stylesheet" href="${themeDisplay.getPathThemeCss()}/vendor/mapbox.min.css" /> 

<section class="storymaplayout">

	<div class="story-map-zoom-toggler">
		<a href="#">
			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 30 30" id="zoom-toggler-minus" style="display: none">
				<g fill="#3C5976" fill-rule="evenodd">
					<path fill-rule="nonzero" d="M15.069,28.14 C7.85085007,28.14 2,22.2884854 2,15.069 C2,7.8511823 7.8511823,2 15.069,2 C22.2871532,2 28.14,7.85151768 28.14,15.069 C28.14,22.28815 22.2874855,28.14 15.069,28.14 Z M15.069,26.33 C21.2878961,26.33 26.33,21.2884686 26.33,15.069 C26.33,8.85124512 21.2876098,3.81 15.069,3.81 C8.8508177,3.81 3.81,8.8508177 3.81,15.069 C3.81,21.2888961 8.85053149,26.33 15.069,26.33 Z"/>
					<rect width="12" height="2" x="9" y="14"/>
				</g>
			</svg>
			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 30 30" id="zoom-toggler-plus" style="display: block">
				<g fill="#3C5976">
					<path d="M15.069,28.14 C7.85085007,28.14 2,22.2884854 2,15.069 C2,7.8511823 7.8511823,2 15.069,2 C22.2871532,2 28.14,7.85151768 28.14,15.069 C28.14,22.28815 22.2874855,28.14 15.069,28.14 Z M15.069,26.33 C21.2878961,26.33 26.33,21.2884686 26.33,15.069 C26.33,8.85124512 21.2876098,3.81 15.069,3.81 C8.8508177,3.81 3.81,8.8508177 3.81,15.069 C3.81,21.2888961 8.85053149,26.33 15.069,26.33 Z"/>
					<path d="M14,14 L14,9 L16,9 L16,14 L21,14 L21,16 L16,16 L16,21 L14,21 L14,16 L9,16 L9,14 L14,14 Z"/>
				</g>
			</svg>
			<span>Zoom</span>
		</a>
	</div>

	<div class="storymap-intro-content">
		<div class="row">
			<div class="col-sm-16 col-md-8 col-md-push-4 title-block">
				<div class="storymap-title">
					${StoryTitle.getData()}
				</div>
				<div class="storymap-info">
					${StoryDescription.getData()}
				</div>
			</div>
			<div class="col-sm-16 col-md-4 col-md-pull-8">
				<div class="storymap-aside">
					${AsideAndSource.getData()}
				</div>
			</div>
			<div class="col-sm-16 col-md-4">
				<#if LinkToDataHub?? 
					&& LinkToDataHub.getData()?? 
					&& LinkToDataHub.getData() != "">
					<div class="storymap-data-link">
						<a href="${LinkToDataHub.getData()}">
							<svg xmlns="http://www.w3.org/2000/svg" width="22" height="30" viewBox="0 0 22 30">
								<g fill="#3C5976" transform="translate(-1 6)">
									<path d="M2.88,15.381 L13.184,15.381 L13.184,13.119 L2.88,13.119 L2.88,15.381 Z M14.944,11.359 L14.944,17.141 L1.12,17.141 L1.12,11.359 L14.944,11.359 Z"/>
									<path d="M8.9124,10.82 C8.9124,11.3060106 8.51841058,11.7 8.0324,11.7 C7.54638942,11.7 7.1524,11.3060106 7.1524,10.82 L7.1524,2 C7.1524,1.51398942 7.54638942,1.12 8.0324,1.12 C8.51841058,1.12 8.9124,1.51398942 8.9124,2 L8.9124,10.82 Z"/>
									<path d="M10.6068201,7.96600256 C10.9739776,7.64756628 11.5297612,7.68706263 11.8481974,8.05422012 C12.1666337,8.42137761 12.1271374,8.97716117 11.7599799,9.29559744 L8.03358295,12.5275074 L4.305029,9.29577855 C3.93777149,8.97745763 3.89810054,8.42168651 4.21642145,8.054429 C4.53474237,7.68717149 5.09051349,7.64750054 5.457771,7.96582145 L8.03321705,10.1980926 L10.6068201,7.96600256 Z"/>
								</g>
							</svg>
							<span>Download the Data</span>
						</a>
					</div>
				</#if>
			</div>
		</div>
	</div>

	<div class="storymap-detail-panel">
		<div class="row">
			<div class="col-xs-16 col-md-8 map-container-grid-wrapper">
				<div class="map-container">
					<div id="${randomNamespace}_map" class="story-map"></div>
				</div>
			</div>
			<div class="col-xs-16 col-md-8 map-info-grid-wrapper">
				<div class="storymap-info-top">
					<div class="row">
						<div class="col-xs-15 col-xs-offset-1">
							<div class="row">
								<#if getterUtil.getBoolean(Options.ShowLayers.getData())>
									<#if getterUtil.getBoolean(Options.ShowLocations.getData())>
										<div class="col-xs-16 col-md-8">
									<#else>
										<div class="col-xs-16">
									</#if>
											<div class="story-map-layers">
												<div class="header">
													<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24.65 27.67" class="icon">
														<path fill="#3D5975" d="M21.16,11.34l3.49-2.5L12.32,0,0,8.84l3.49,2.5L0,13.84l3.49,2.5L0,18.84l12.32,8.83,12.33-8.83-3.49-2.5,3.49-2.5ZM12.32,2.46l8.89,6.38-8.89,6.37L3.43,8.84ZM5.2,12.57l7.12,5.1,7.12-5.1,1.77,1.27-8.89,6.37L3.43,13.84Zm16,6.27-8.89,6.37L3.43,18.84,5.2,17.57l7.12,5.1,7.12-5.1Z"/>
													</svg>
													<span class="description"><strong>Layers</strong> Toggle on and off to explore</span>
												</div>
												<div class="story-map-layer-switcher">
													<div class="layers-menu">
														<ul>
															<#list Layer.getSiblings() as cur_Layer>
															<#assign layerIndex = cur_Layer?index>
															<#if cur_Layer?? && cur_Layer.LayerLabel?? && cur_Layer.LayerLabel.getData()?? && cur_Layer.LayerLabel.getData() != "">
																<#if getterUtil.getBoolean(cur_Layer.IncludeLayerInLegend.getData())>
																	<li>
																		<#if getterUtil.getBoolean(cur_Layer.MakeLayerInteractive.getData())>
																			<a href="#" id="button_overlay_${layerIndex}" data-index="${layerIndex}" class="button_overlay">
																		</#if>
																		<#if cur_Layer.LayerColor.getData()?? && cur_Layer.LayerColor.getData() != "">
																			<#assign layerColor = cur_Layer.LayerColor.getData()>
																		<#else>
																		<#--  magic value $grey-blue from _variables.scss  -->
																			<#assign layerColor = "#3C5976">
																		</#if>
																				<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 30 30" id="button_overlay_dot_active_${layerIndex}" style="display: block">
																					<g fill="none" fill-rule="evenodd" transform="translate(1 1)">
																						<path fill="${layerColor}" fill-rule="nonzero" d="M14.064,26.9096 C6.85695383,26.9096 0.995,21.0476462 0.995,13.8406 C0.995,6.63355383 6.85695383,0.7716 14.064,0.7716 C21.2710462,0.7716 27.133,6.63355383 27.133,13.8406 C27.133,21.0476462 21.2710462,26.9096 14.064,26.9096 Z M14.064,24.8996 C20.1609538,24.8996 25.123,19.9375538 25.123,13.8406 C25.123,7.74364617 20.1609538,2.7816 14.064,2.7816 C7.96704617,2.7816 3.005,7.74364617 3.005,13.8406 C3.005,19.9375538 7.96704617,24.8996 14.064,24.8996 Z"/>
																						<path stroke="${layerColor}" d="M14.064,21.3804 C18.228,21.3804 21.604,18.0044 21.604,13.8404 C21.604,9.6764 18.228,6.3004 14.064,6.3004 C9.9,6.3004 6.524,9.6764 6.524,13.8404 C6.524,18.0044 9.9,21.3804 14.064,21.3804"/>
																					</g>
																				</svg>
																				<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 30 30" id="button_overlay_dot_inactive_${layerIndex}" style="display: none">
																					<g fill="${layerColor}" fill-rule="evenodd" transform="translate(1 1)">
																						<path fill-rule="nonzero" d="M14.064,27.133 C6.85695383,27.133 0.995,21.2710462 0.995,14.064 C0.995,6.85695383 6.85695383,0.995 14.064,0.995 C21.2710462,0.995 27.133,6.85695383 27.133,14.064 C27.133,21.2710462 21.2710462,27.133 14.064,27.133 Z M14.064,25.123 C20.1609538,25.123 25.123,20.1609538 25.123,14.064 C25.123,7.96704617 20.1609538,3.005 14.064,3.005 C7.96704617,3.005 3.005,7.96704617 3.005,14.064 C3.005,20.1609538 7.96704617,25.123 14.064,25.123 Z"/>
																						<path d="M14.064,21.6038 C18.228,21.6038 21.604,18.2278 21.604,14.0638 C21.604,9.8998 18.228,6.5238 14.064,6.5238 C9.9,6.5238 6.524,9.8998 6.524,14.0638 C6.524,18.2278 9.9,21.6038 14.064,21.6038"/>
																					</g>
																				</svg>
																				<span class="overlay-label">${cur_Layer.LayerLabel.getData()}</span>
																				<span class="sr-only">toggle map layer</span>
																			</a>
																		<#if getterUtil.getBoolean(cur_Layer.MakeLayerInteractive.getData())>
																			</a>
																		</#if>
																	</li>
																</#if>
															</#if>
															</#list>
														</ul>
													</div>
												</div>
											</div>
										</div>
								</#if>
								<#if getterUtil.getBoolean(Options.ShowLocations.getData())>
									<#if getterUtil.getBoolean(Options.ShowLayers.getData())>
										<div class="col-xs-16 col-md-8">
									<#else>
										<div class="col-xs-16">
									</#if>
											<div class="story-map-locations">
												<div class="header">
													<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 19.8 27.3" width="20" height="20" class="icon">
														<path fill="#3D5975" d="M9.9,0A9.91,9.91,0,0,0,0,9.9C0,15,8.19,25.21,9.12,26.35l.78.95.77-.95C11.61,25.21,19.8,15,19.8,9.9A9.91,9.91,0,0,0,9.9,0Zm0,24.12C7.14,20.58,2,13.29,2,9.9a7.9,7.9,0,0,1,15.8,0C17.8,13.29,12.66,20.58,9.9,24.12Z"/>
														<path fill="#3D5975" d="M9.9,5.31a4,4,0,1,0,4,4A4,4,0,0,0,9.9,5.31Zm0,5.93a2,2,0,1,1,2-2A2,2,0,0,1,9.9,11.24Z"/>
													</svg>
													<span class="description"><strong>Locations</strong> Click a location to learn more</span>
												</div>
												<div class="storymap-nav-container">
													<ul class="list-inline list-unstyled storymap-nav-list pull-left">
														<#list Location.getSiblings() as cur_StoryStep>
														<#assign storyStepsIndex = cur_StoryStep?index>
															<#if cur_StoryStep.LocationLabel.getData() != "">
															<li>
																<a id="${randomNamespace}_step${storyStepsIndex}" class="story-step" href="#" data-step="${cur_StoryStep?index}" aria-controls="${randomNamespace}location_content${cur_StoryStep?index}">
																	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 30 30" id="button_location_dot_inactive_${storyStepsIndex}" class="button_location_dot_inactive" style="display: inline">
																		<g fill="none" fill-rule="evenodd" transform="translate(1 1)">
																			<path fill="#638198" fill-rule="nonzero" d="M14.064,26.9096 C6.85695383,26.9096 0.995,21.0476462 0.995,13.8406 C0.995,6.63355383 6.85695383,0.7716 14.064,0.7716 C21.2710462,0.7716 27.133,6.63355383 27.133,13.8406 C27.133,21.0476462 21.2710462,26.9096 14.064,26.9096 Z M14.064,24.8996 C20.1609538,24.8996 25.123,19.9375538 25.123,13.8406 C25.123,7.74364617 20.1609538,2.7816 14.064,2.7816 C7.96704617,2.7816 3.005,7.74364617 3.005,13.8406 C3.005,19.9375538 7.96704617,24.8996 14.064,24.8996 Z"/>
																			<path stroke="#638198" d="M14.064,21.3804 C18.228,21.3804 21.604,18.0044 21.604,13.8404 C21.604,9.6764 18.228,6.3004 14.064,6.3004 C9.9,6.3004 6.524,9.6764 6.524,13.8404 C6.524,18.0044 9.9,21.3804 14.064,21.3804"/>
																		</g>
																	</svg>
																	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 30 30" id="button_location_dot_active_${storyStepsIndex}" class="button_location_dot_active" style="display: none">
																		<g fill="#638198" fill-rule="evenodd" transform="translate(1 1)">
																			<path fill="#638198" fill-rule="nonzero" d="M14.064,26.9096 C6.85695383,26.9096 0.995,21.0476462 0.995,13.8406 C0.995,6.63355383 6.85695383,0.7716 14.064,0.7716 C21.2710462,0.7716 27.133,6.63355383 27.133,13.8406 C27.133,21.0476462 21.2710462,26.9096 14.064,26.9096 Z M14.064,24.8996 C20.1609538,24.8996 25.123,19.9375538 25.123,13.8406 C25.123,7.74364617 20.1609538,2.7816 14.064,2.7816 C7.96704617,2.7816 3.005,7.74364617 3.005,13.8406 C3.005,19.9375538 7.96704617,24.8996 14.064,24.8996 Z"/>
																			<path stroke="#638198" d="M14.064,21.3804 C18.228,21.3804 21.604,18.0044 21.604,13.8404 C21.604,9.6764 18.228,6.3004 14.064,6.3004 C9.9,6.3004 6.524,9.6764 6.524,13.8404 C6.524,18.0044 9.9,21.3804 14.064,21.3804"/>
																		</g>
																	</svg>
																	<span class="story-step-title">${cur_StoryStep.LocationLabel.getData()}</span>
																</a>
															</li>
															</#if>
														</#list>
													</ul>
												</div>
											</div>
										</div>
								</#if>
							</div>
						</div>
					</div>
					
				</div>
				<div class="storymap-info-bottom">
					<section class="storymap-main-content">
						<#if getterUtil.getBoolean(Options.ShowLocationContent.getData())>
						<#list Location.getSiblings() as cur_StoryStep>
						<#assign storyStepsIndex = cur_StoryStep?index>
						<div id="${randomNamespace}location_content${storyStepsIndex}" class="story-step-content" aria-live="polite">
							<#list cur_StoryStep.LocationContent.getSiblings() as cur_LocationContent>
								<#if getterUtil.getBoolean(cur_LocationContent.LocationContentFullWidth.getData())>
								<div class="col-xl-16 story-step-content-full-width">
									${cur_LocationContent.LocationContentContent.getData()}
								</div>
								<#else>
								<div class="story-step-content-centered">
									<div class="row">
										<div class="col-xs-14 col-xs-offset-1">
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
				</div>
			</div>
		</div>
	</div>

</section>

<script type="text/javascript">
var cmap = cmap || {};
cmap.storymaps = cmap.storymaps || {};

AUI().ready(

	function () {

		console.log('AUI().ready()');

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
				if ($('.layers-menu').length) {
					return $('.layers-menu').get(0);
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
		cmap.storymaps.hasDefaultContent = false;

		cmap.storymaps.toggleZoom = function (l) {
			if (cmap.storymaps.map.getZoom() === cmap.storymaps.defaultZoom)  {
				cmap.storymaps.zoomIn(l);
			} else {
				cmap.storymaps.zoomOut();
			}
			cmap.storymaps.toggleSVG('zoom-toggler-plus');
			cmap.storymaps.toggleSVG('zoom-toggler-minus');
		};

		<#-- https://stackoverflow.com/questions/24578837/remove-or-hide-svg-element/24578882  -->
		<#-- because it depends on the element's style attribute, this seems to only work with SVGs with inline styles -->
		cmap.storymaps.toggleSVG = function(id) {
			var svg = document.getElementById(id);
			var style = svg.style.display;
			if (style === "none")
				svg.style.display = "inline";
			else
				svg.style.display = "none";
		};

		cmap.storymaps.toggleLayersMenu = function () {
			if (!$('.leaflet-bottom.leaflet-right').data('hidden')) {
				cmap.storymaps.hideLayerMenu();
			} else {
				cmap.storymaps.showLayerMenu();
			}
		};

		cmap.storymaps.zoomOut = function() {
			cmap.storymaps.map.setZoom(cmap.storymaps.defaultZoom);
			cmap.storymaps.showLayerMenu();
			$('.story-map-zoom-toggler a span').html('Zoom');
		};

		cmap.storymaps.zoomIn  = function(l) {
			if (l > -1) {
				cmap.storymaps.map.setZoom(cmap.storymaps.locations[l].zoom);
			} else {
				cmap.storymaps.map.setZoom(cmap.storymaps.defaultZoom + 1);
			}
			cmap.storymaps.hideLayerMenu();
			$('.story-map-zoom-toggler a span').html('Zoom out');
		};

		cmap.storymaps.hideLayerMenu = function() {
			var offset = ($('.leaflet-bottom.leaflet-right').outerWidth(true) * -1) + 42;  
				$('.leaflet-bottom.leaflet-right').animate({
				right: offset,
			}, 500, function() {
				$('.leaflet-bottom.leaflet-right').data('hidden', true);
				cmap.storymaps.toggleSVG('menu-toggler-left');
				cmap.storymaps.toggleSVG('menu-toggler-right');
			});
		};

		cmap.storymaps.showLayerMenu = function() {
			$('.leaflet-bottom.leaflet-right').animate({
				'right': 0, 
			}, 500, function() {
				$('.leaflet-bottom.leaflet-right').data('hidden', false);
				cmap.storymaps.toggleSVG('menu-toggler-left');
				cmap.storymaps.toggleSVG('menu-toggler-right');
			});
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
				var mapPin = new L.marker(marker.coords, { icon: cmapIcon, interactive: false });
				cmap.storymaps.markerLayers.push(mapPin);
				mapPin.addTo(cmap.storymaps.map);
				L.DomEvent.disableClickPropagation(mapPin);
				if ($.trim(marker.label).length) {
					//mapPin.bindTooltip(marker.label).openTooltip();
					mapPin.bindPopup(marker.label, { className:'tooltip2050', closeButton:true, closeOnClick:true }).openPopup();
				}
			}
			<#if Options.MapPinColor ?? && Options.MapPinColor.getData() ?? && Options.MapPinColor.getData() != "" >
				$('.icon-map-med-dark').css('color', '${Options.MapPinColor.getData()}');
			<#else>
				$('.icon-map-med-dark').css('color', 'red');
			</#if>
		};

		cmap.storymaps.showLocation = function (l) {
			console.log('cmap.storymaps.showLocation');
			$('.story-step').removeClass('story-active');
			$('#${randomNamespace}_step' + l).addClass('story-active');
			$('.storymap-info-bottom').animate({ scrollTop: 0 }, "fast");
			$('.xs-story-step').html(cmap.storymaps.locations[l].stepTitle);
			$('.button_location_dot_active').css("display","none");
			$('.button_location_dot_inactive').css("display","inline");
			$('#${randomNamespace}_step' + l).find('.button_location_dot_active').css("display","inline");
			$('#${randomNamespace}_step' + l).find('.button_location_dot_inactive').css("display","none");
			if (l > -1) {
				cmap.storymaps.setMarkerState(l);
				cmap.storymaps.setPanState(l);
				cmap.storymaps.loadContent(true, l);
			} else {
				// noop
			}
		};

		cmap.storymaps.loadContent = function (isLocation, index) {
			console.log('cmap.storymaps.loadContent');
			$('.story-step-content').hide();
			if (isLocation && index > -1) {
			<#if getterUtil.getBoolean(Options.ShowLocationContent.getData()) >
				var loadingContentHTML = document.getElementById('${randomNamespace}location_content' + index).innerHTML;
				document.getElementById('${randomNamespace}location_content' + index).innerHTML = loadingContentHTML;
				document.getElementById('${randomNamespace}location_content' + index).style.display = 'block';
			</#if>
			} else if (index > -1) {
			<#if getterUtil.getBoolean(Options.ShowLayerContent.getData()) >
				var contentId = 'layer_content' + index;
				$('#${randomNamespace}' + contentId).show();
			</#if>
			}
		};

		cmap.storymaps.loadOverlay = function (index) {
			console.log('cmap.storymaps.loadOverlay');

			var button = $('#button_overlay_'+index);
			var layerData = cmap.storymaps.layerData[index];
			var overlayId = 'overlay_' + index;
			button.toggleClass('active');
			cmap.storymaps.toggleSVG('button_overlay_dot_active_'+index);
			cmap.storymaps.toggleSVG('button_overlay_dot_inactive_'+index);
			$('.button_location_dot_active').css("display","none");
			$('.button_location_dot_inactive').css("display","inline");

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
			console.log('cmap.storymaps.bindEvents');

			$('.story-step').on('click', function (e) {
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

			$(window).on('resize', _.throttle(cmap.storymaps.handleResize, 200));
		};

		cmap.storymaps.positionControls = function() {
			console.log('cmap.storymaps.positionControls');

			<#-- map controls are abolutely positioned, so align them with existing grid elements -->
			var offset = $('.storymap-aside').offset().left;
			var width = $('.storymap-aside').width();

			if (!$('.storymap-aside:visible').length) {
				offset = $('.storymap-intro-content > .row').offset().left;
				width = 'auto';
			}

			$('.leaflet-top.leaflet-left').css({ 'left': offset, 'width': width });
			$('.leaflet-bottom.leaflet-right').css({ 'marginRight': offset });

			<#-- make sure slider toggle button is in "open" state   -->
			if (document.getElementById('menu-toggler-left')) {
				document.getElementById('menu-toggler-left').style.display = "none";
			}
			if (document.getElementById('menu-toggler-right')) {
				document.getElementById('menu-toggler-right').style.display = "block";
			}
		};

		cmap.storymaps.handleResize = function() {
			cmap.storymaps.positionControls();
		};

		cmap.storymaps.buildLocations = function () {
			console.log('cmap.storymaps.buildLocations');
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
					cmap.storymaps.hasDefaultContent = true;
					cmap.storymaps.location = i;            
					cmap.storymaps.showLocation(i);
					break;
				}
			}
			cmap.storymaps.hasDefaultContent = false;
		};

		cmap.storymaps.buildLayerData = function () {
			console.log('cmap.storymaps.buildLayerData');
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
					cmap.storymaps.hasDefaultContent = true;
					cmap.storymaps.loadOverlay(i);
				}
			}
			cmap.storymaps.hasDefaultContent = false;
		};

		cmap.storymaps.initMap = function () {
			console.log('cmap.storymaps.initMap');

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
			}).setView([41.8781, -88.2298], cmap.storymaps.defaultZoom);

			console.log(cmap.storymaps.map);

			cmap.storymaps.map.createPane('labels');
			cmap.storymaps.map.getPane('labels').style.zIndex = 650;

			<#if Options.MapboxOverlay??>
				<#list Options.MapboxOverlay.getSiblings() as cur_MapboxOverlay>
					<#if cur_MapboxOverlay.getData() ?? && cur_MapboxOverlay.getData() != "">
						<#assign mapboxOverlayURL = cur_MapboxOverlay.getData()>
						var labelsLayer = L.tileLayer('${mapboxOverlayURL}', {
							pane: 'labels'
						}).addTo(cmap.storymaps.map);
					</#if>
				</#list>
			<#else>
				var labelsLayer = L.tileLayer('https://api.mapbox.com/styles/v1/onto2050/cjezz11vx2sfs2rt6z7jx8t09/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib250bzIwNTAiLCJhIjoiY2lzdjJycTZrMGE3dDJ5b2RsYTRvaHdiZSJ9.SIUNXOhAVC2rXywtDIrraQ', {
					pane: 'labels'
				}).addTo(cmap.storymaps.map);
			</#if>

			cmap.storymaps.map.scrollWheelZoom.disable();
			cmap.storymaps.map.doubleClickZoom.disable();
			L.mapbox.styleLayer(url).addTo(cmap.storymaps.map);
			L.control.zoomToggler({ position: 'topleft' }).addTo(cmap.storymaps.map);
			L.control.layerSwitcher({ position: 'bottomright' }).addTo(cmap.storymaps.map)
			cmap.storymaps.positionControls();
		};

		cmap.storymaps.initMap();
		cmap.storymaps.buildLayerData();
		cmap.storymaps.buildLocations();
		cmap.storymaps.bindEvents();
		$('.story-map-layer-switcher').append( $('.layers-menu') );
	}
);
</script>

<style>
body.default-theme .journal-content-article .leaflet-control-container .story-map-zoom-toggler a,
body.default-theme .journal-content-article .leaflet-container a.leaflet-popup-close-button {
	border: none;
}
body.default-theme .journal-content-article  .storymaplayout .storymap-main-content h2 {
	margin: 0 0 20px 0;
	font-weight: bold;
	color: #000;
}
body.default-theme .journal-content-article  .storymaplayout .storymap-main-content p {
	color: #000;
}
</style>
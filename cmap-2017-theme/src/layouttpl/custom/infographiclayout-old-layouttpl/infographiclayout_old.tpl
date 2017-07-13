<div class="infographicbase" id="main-content" role="main">
	<script src="//cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>

<!-- 	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css" />
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>

	<script src="https://unpkg.com/leaflet@1.0.3/dist/leaflet.js"></script>
	<script src='https://api.mapbox.com/mapbox.js/v3.0.1/mapbox.js'></script>
	<link href='https://api.mapbox.com/mapbox.js/v3.0.1/mapbox.css'
		rel='stylesheet' />
	<script
		src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
	<script>
		$(document)
				.ready(
						function() {

							function removeAllFade() {
								var activeClass = "c3-defocused";
								d3.selectAll('g').classed(activeClass, false);
							}

							//$(this).closest('parent').find('child') since we're looking in the section local to the button that was clicked.
							$(".icon-info-white").click(
									function() {
										$(this).closest(".info-icon-container")
												.find('.icon-info-white')
												.toggleClass('on');
										$(this).closest('.chart-top-container')
												.find('.left-info')
												.toggleClass('hide');
										$(this).closest('.chart-top-container')
												.find('p.info-data').toggle();

									});

							$(".infographic-button").click(function() {
								$(this).addClass('clicked');
							});
							$(".infographic-button")
									.on(
											'click mouseenter',
											function() {
												var thisID = $(this).attr('id');
												var closestParent = $(this)
														.closest(
																'.infographic-section');
												var chartClass = closestParent
														.find('#chart').attr(
																'class');
												//this only works for up to 5 categories... not sure of the intended behavior otherwise.
												//could be remedied maybe by window.load function and normal jq. will try soon.
												var firstChild = closestParent
														.find(
																'g.c3-chart-lines')
														.children(
																':nth-child(1)')[0];
												var secondChild = closestParent
														.find(
																'g.c3-chart-lines')
														.children(
																':nth-child(2)')[0];
												var thirdChild = closestParent
														.find(
																'g.c3-chart-lines')
														.children(
																':nth-child(3)')[0];
												var fourthChild = closestParent
														.find(
																'g.c3-chart-lines')
														.children(
																':nth-child(4)')[0];
												var fifthChild = closestParent
														.find(
																'g.c3-chart-lines')
														.children(
																':nth-child(5)')[0];
												//we need to be more specific in our selection, to make sure we select the chart closest to the buttons,
												//and apply the fade to probably nth-children depending on chart type.

												if ($(window).width() < 420) {
													closestParent
															.find(
																	'.side-narrative.desktop-narrative')
															.hide();

													if (closestParent.find(
															'.icon-key-light')
															.hasClass(
																	'inactive')) {
														closestParent
																.find(
																		'.side-narrative.m-side-narrative')
																.show()
																.find(
																		'#'
																				+ thisID)
																.addClass(
																		'display');
													}
												} else {
													closestParent
															.find(
																	'.side-narrative.m-side-narrative')
															.hide();
													if (!$(this)
															.closest(
																	'infographic-button')
															.find(
																	'.icon-paragraphh-white')
															.hasClass('off')) {
														closestParent
																.find(
																		'.side-narrative.desktop-narrative')
																.show()
																.find(
																		'#'
																				+ thisID)
																.addClass(
																		'display');
													}
												}
												if ($('.button-container')
														.children().hasClass(
																'on') != $(this)) {
													$('.button-container')
															.children()
															.removeClass('on');
													$(this).addClass('on');
													updateInfo();
												} else {
													$(this).addClass('on');
												}
												if ($(this).hasClass('on')) {

													if ($(this).is(
															":first-child")) {
														removeAllFade();

														//[0] to make sure we get the pure dom element for js .classList. 
														//jq wont select svg elements to add/remove classes. this is our workaround to preserve the classes existing there
														thirdChild.classList
																.add('c3-defocused');
														fourthChild.classList
																.add('c3-defocused');
														fifthChild.classList
																.add('c3-defocused');
														//put the addFade function here. 
														//will likely want an array of the children at some point, and pass those values to the function as before.

													} else if ($(this).is(
															":nth-child(2)")) {
														removeAllFade();
														firstChild.classList
																.add('c3-defocused');
														secondChild.classList
																.add('c3-defocused');
														fifthChild.classList
																.add('c3-defocused');
													} else if ($(this).is(
															":nth-child(3)")) {
														removeAllFade();
														firstChild.classList
																.add('c3-defocused');
														secondChild.classList
																.add('c3-defocused');
														thirdChild.classList
																.add('c3-defocused');
														fourthChild.classList
																.add('c3-defocused');
													} else {
														removeAllFade();
													}

												}
											});

							$(".infographic-button")
									.on(
											'mouseleave',
											function() {
												var closestButton = $(this)
														.closest(
																'.infographic-button');
												if (!$(this)
														.hasClass('clicked')) {
													$(this).removeClass('on');
													removeAllFade();
													$(
															'.side-narrative.desktop-narrative')
															.hide();
													//remember to remove the 'off' class from the paragraph button.
													closestButton
															.find(
																	'.icon-paragraphh-white')
															.removeClass('off');
												}

											});

							//need to know where we're clicking in terms of multiples... will need (this).closest(parent).find(child)
							$('.icon-paragraphh-white')
									.click(
											function() {
												var container = $(this)
														.closest('.btn-toggle');
												if (container.hasClass('on')) {
													if ($(window).width() > 420) {

														$(
																'.side-narrative.desktop-narrative')
																.toggle();
														$(this).toggleClass(
																'off');

													} else {
														$(
																'.side-narrative.m-side-narrative')
																.toggle();

													}

												}
												return false;
											});
							//will need to have some way of finding which place we're in, so we dont close all of them.
							$('.icon-close-white').click(function() {
								if ($('.side-narrative').is(":visible")) {
									$('.side-narrative').hide();
								}
								var container = $(this).closest('.btn-toggle');
								container.removeClass('on');
								container.removeClass('clicked');
								removeAllFade();
								return false;
							});

							$('.icon-paragraph-light, .icon-key-light')
									.click(
											function() {

												var legendParent = $(this)
														.closest(
																'.chart-legend');
												$(this)
														.closest(
																'.m-legend-btns')
														.find(
																'.icon-paragraph-light, .icon-key-light')
														.toggleClass('inactive');

												legendParent.find(
														'.legend-info')
														.toggle();
												if ($(this)
														.closest(
																'.m-legend-btns')
														.find(
																'.icon-paragraph-light')
														.hasClass('inactive')) {
													legendParent.find(
															'.side-narrative')
															.hide();
												} else {
													legendParent.find(
															'.side-narrative')
															.show();
												}
												if ($('.button-container')
														.children().hasClass(
																'on')) {
													updateInfo();
												}
											});
							function updateInfo() {
								var thisID = $('.button-container').find('.on')
										.attr('id');

								$('.side-narrative').find('#' + thisID)
										.addClass('display');
								$('.mini-info:not(#' + thisID + ')')
										.removeClass('display');

							}

							//storymap mechanics here

							$('.left-map-button')
									.click(
											function() {
												var variance = 50;
												if ($(window).width() < 420) {

													variance = 80;
												}

												var navOffset = $(
														'.story-steps-container')
														.offset().top;
												var containerOffset = $(
														'.storymap-top')
														.offset().top
														+ $('.storymap-section')
																.height()
														- variance;

												var y = $(window).scrollTop(); //your current y position on the page
												if (y == 0) {
													$("html, body")
															.animate(
																	{
																		scrollTop : y
																				+ navOffset
																	}, 600);
												} else {
													$("html, body")
															.animate(
																	{
																		scrollTop : containerOffset
																	}, 600);

												}

												$('.story-steps').children()
														.removeClass(
																'story-active');
												cmap.map
														.removeLayer(cmap.markerLayer);

												var someLayers = cmap.layers;

												for ( var mapLayer in someLayers) {
													cmap.map
															.removeLayer(cmap.layers[mapLayer]);
												}

											});

							$('.view-layers').click(
									function() {

										//$('.story-overlay-dd').toggle();
										$('.overlay-button-container')
												.addClass('story-dd-active');

									});

							$('.story-overlays-m .icon-close-white')
									.click(
											function() {

												$('.overlay-button-container')
														.removeClass(
																'story-dd-active');

											});

							$('.button.story-overlay-title').click(function() {
								$(this).toggleClass('overlay-on');
							});

						});
	</script> -->
	<div class="infographic-nav">
		<div class="vertical-centered grid-align">
			<div class="middle">
				<div class="infospacer"></div>
				<div class="pageTitle">$layout.getName()</div>
			</div>
			<div id="shareModule" class="right-button">
				<div class="share-this-block">
					<label for="share-this-toggle" id="share-this-label" class="share">
						<span class="icon icon-share-light"></span>Share
					</label>
					<div class="share-wrapper drilldown"></div>
				</div>
			</div>
			<!-- <div class="right-button share-this-block"><label for="share-this-toggle" class="share" >
<span  class="icon">Share</span></label></div>-->
		</div>
	</div>
	<div class="portlet-layout">
		<div class="portlet-column portlet-column-only" id="column-1">
			$processor.processColumn("column-1", "portlet-column-content
			portlet-column-content-only")</div>
	</div>
	<div class="portlet-layout">
		<div class="portlet-column portlet-column-only" id="column-2">
			$processor.processColumn("column-2", "portlet-column-content
			portlet-column-content-only")</div>
	</div>
</div>
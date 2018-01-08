(function (root, factory) {
	if (typeof define === 'function' && define.amd) {
		define('infographics', [], factory);
	} else if (typeof module === 'object' && module.exports) {
		module.exports = factory();
	} else {
		root.infographics = factory();
	}
}(this, function () {

	function isMobile() {
		// $breakpoint-tablet: 750px;
		return $(window).width() < 750;
	}

	function getDonutDataValue(d, id) {
		var dataset;
		for (var i = 0; i < d.length; i++) {
			dataset = d[i];
			for (var key in dataset) {
				if (key === id) {
					return dataset[key];
				}
			}
		}
	}

	function formatValue(format, value) {
		if (format === 'dollars') {
			return '$' + d3.format(",")(value);
		} else if (format === 'percent') {
			return d3.format(",")(value) + '%';
		} else {
			return d3.format(",")(value);
		}
	}

	function getTooltip(d, defaultTitleFormat, defaultValueFormat, color, altDataColor, options) {
		var formatColor = function (e) {
			if (options.altDataType && e.name.toLowerCase() === options.altDataType.toLowerCase()) {
				return altDataColor;
			} else {
				return color(e);
			}
		};
		var lines = [];
		lines.push('<div><table class="c3-tooltip"><thead><tr>');
		lines.push('<th colspan="2">' + defaultTitleFormat(d[0].x) + '</th>');
		lines.push('</tr></thead><tbody>');
		$.each(d, function (i, e) {
			lines.push('<tr><td class="name"><span><i class="icon-circle" style="color: ' + formatColor(e) + '"></i> </span>' + e.name + '</td><td class="value">' + formatValue(options.axis_y_tick_format, e.value) + '</td></tr>');
		});
		lines.push('</tbody></table></div>');
		return lines.join('');
	}

	function generateDonutArcTitle(options) {
		var id = options.id;
		var formattedValue = formatValue(options.format, options.value);
		var node = d3.select('#' + options.chartId + ' .c3-chart-arcs-title').node();
		if (id.length > 32) {
			var words = id.split(/\s+/);
			node.innerHTML = "<tspan>" +
				formattedValue +
				'</tspan><tspan class="upper" x="-1" y="25">' +
				words.slice(0, Math.floor(words.length / 2)).join(' ') +
				'</tspan><tspan class="upper" x="-1" y="50">' +
				words.slice(Math.floor(words.length / 2)).join(' ') +
				'</tspan>';
		} else {
			node.innerHTML = "<tspan>" +
				formattedValue +
				'</tspan><tspan class="upper" x="-1" y="25">' +
				id +
				'</tspan>';
		}
		node.parentNode.append(node);
	}

	function getDataClasses() {
		//get the array of svg objects and all their info with d3
		var chartLines = d3.select('.c3-chart-lines').selectAll('g.c3-chart-line');
		var dataClasses = [];
		//get the class names
		for (i = 0; i < chartLines[0].length; i++) {
			$.each(chartLines[0][i].classList, function (key, value) {
				//we only need the second value - unique to that data set
				if (key == 2) {
					dataClasses.push(value);
				}
			});
		}
		return dataClasses;
	}

	function applyFade(dataClasses, index) {
		var toFade;
		// d3 always returns an array with a length of 1.
		// looking one level deeper tells us whether we actually got a result.
		if (!index) {
			d3.selectAll('.c3-defocused').classed('c3-defocused', false);
			return;
		}
		if (d3.selectAll('.c3-defocused')[0].length != 0) {
			d3.selectAll('.c3-defocused').classed('c3-defocused', false);
		}
		else if (index.length > 1) {
			var num;
			for (i = 0; i < index.length; i++) {
				num = index[i];
				toFade = ".c3-chart-line." + dataClasses[num];
				d3.select(toFade).classed('c3-defocused', true);
			}
		}
		else {
			// single index functionality in case its needed in future
			toFade = '.c3-chart-line.' + dataClasses[index];
			d3.select(toFade).classed('c3-defocused', true);
		}
	}

	function showSideNarrative(index) {
		if (index) {
			var html = $('#side-narrative' + index).html();
			if (!$('.side-narrative').length) {
				$('.infographic-chart').append('<div class="side-narrative"></div>');
			}
			$('.side-narrative').html(html);
		}
		hideSideNarrative();
		$('.side-narrative').show();
	}

	function hideSideNarrative() {
		if ($('.side-narrative').length) {
			$('.side-narrative').hide();
		}
	}

	function resizeAxisLabels(options) {
		if (!options.disableXAxisLabelResizing || !options.disableYAxisLabelResizing) {
			var yChildren = d3.select('#' + options.chartId + ' g.c3-axis-y').selectAll('.tick text');
			//d3 arrays always have a single index, then arrays under that.
			var yArr = yChildren[0];
			var yCount = yArr.length;

			var xChildren = d3.select('#' + options.chartId + ' g.c3-axis-x').selectAll('.tick text');
			var xArr = xChildren[0];
			var xCount = xArr.length;
			if (xCount < 10 && !options.disableXAxisLabelResizing) {
				xChildren.attr("font-size", "14px");
			}

			if (yCount < 10 && !options.disableYAxisLabelResizing) {
				yChildren.attr("font-size", "14px");
			}
		}
	}

	function generateLegend(options) {
		var d = options.d;
		var legendData = d3.keys(d[0]).splice(1);
		if (options.chartType === 'donut_chart') {
			legendData = d3.keys(d[0]);
		}
		$('.infographic-legend.' + options.chartId + '-legend .legend-data').html('');
		d3.select('.infographic-legend.' + options.chartId + '-legend .legend-data').insert('ul')
			.attr('class', 'list-unstyled list-inline ' + options.chartId)
			.selectAll('div')
			.data(legendData)
			.enter().append('li')
			.attr('class', function (id) {
				return id;
			})
			.html(function (id) {
				if (options.chartType !== 'donut_chart') {
					if (options.altDataType && (options.altDataType.toLowerCase() === id.toLowerCase())) {
						return '<span><i class="icon-circle" style="color: ' + options.altDataColor + '"></i> </span>' + id;
					} else {
						return '<span><i class="icon-circle" style="color: ' + options.chart.color(id) + '"></i> </span>' + id;
					}
				} else {
					return '<div class="item-value" data-value="' + getDonutDataValue(d, id) + '"><span><i class="icon-circle" style="color: ' + options.chart.color(id) + '"></i> </span>' + id + '</div>';
				}
			})
			.on('mouseover', function (id) {
				if (options.chartType === 'donut_chart') {
					var dataValue = $(this).children('div').attr('data-value');
					generateDonutArcTitle({
						chartId: options.chartId,
						format: options.axis_x_tick_format,
						id: id,
						value: dataValue
					});
				}
				// TODO media query
				if (!isMobile()) {
					options.chart.api.focus(id);
					var childButtons = $('.button-container').children();
					if (childButtons.hasClass('on')) {
						childButtons.removeClass('on');
						$('.side-narrative').children().removeClass('display');
					}
				}
			})
			.on('mouseout', function (id) {
				options.chart.api.revert();
			})
			.on('click', function (id) {
				// TODO media query
				if (isMobile()) {
					$(this).closest('.infographic-section').find('.button-container').children('.on').removeClass('on');
					$(this).toggleClass('legend-clicked').removeClass('m-legend-fade').siblings().removeClass('legend-clicked').addClass('m-legend-fade');
					options.chart.api.focus(id);

					if (!$(this).hasClass('legend-clicked')) {
						options.chart.api.revert();
						$(this).removeClass('m-legend-fade').siblings().removeClass('m-legend-fade');
					}

					return false;
				}
			});
	}

	return {
		generateAreaStacked: function (options) {
			var d = options.d;
			var siFormat = d3.format(",");
			var headings = d3.keys(d[0]);
			var chart = c3.generate({
				axis: {
					x: {
						type: 'category',
						padding: {
							left: options.axis_x_padding_left,
						},
						label: {
							text: options.axis_x_label_text,
							position: 'outer-center'
						},
						tick: {
							// can prolly be a function for multiples of 12..
							values: [0, 12, 24, 36, 48, 60, 72, 84, 96, 108, 120, 132, 144, 156, 168, 180, 192, 204, 216, 228, 240, 252, 264, 276],
							multiline: false
						}
					},
					y: {
						label: {
							text: options.axis_y_label_text,
							position: 'inner-middle'
						},
						tick: {
							format: // custom formatting to make sure we dont
								// have a lot of 0's
								function (d) {
									if (d > 1000) {
										return siFormat(d).replace(",000", "");
									}
									else {
										return d;
									}
								}
						}
					},
				},
				bindto: d3.select($('#' + options.chartId).get(0)),
				color: {
					pattern: ["#00396e", "#51c0ec", "#2a5633", "#a3ce72", "#e6b936"]
				},
				data: {
					url: options.data_url,
					hide: [headings[0]],
					order: [d3.keys(d[0])],
					type: 'area',
					x: headings[0],
					groups: [d3.keys(d[0])],
					keys: {
						x: headings[0]
					},
				},
				legend: {
					show: false
				},
				grid: {
					y: {
						show: true,
					}
				},
				point: {
					show: false,
				},
				tooltip: {
					grouped: true,
				},
				onrendered: function () {
					getDataClasses();
					generateLegend({
						d: d,
						chart: this,
						chartId: options.chartId,
						chartType: 'area_stacked',
						axis_x_tick_format: options.axis_x_tick_format,
						axis_y_tick_format: options.axis_y_tick_format
					});
					resizeAxisLabels({
						chartId: options.chartId,
						disableXAxisLabelResizing: options.disableXAxisLabelResizing,
						disableYAxisLabelResizing: options.disableYAxisLabelResizing

					});
				}
			});
			$(window).on('scroll', _.throttle(function () {
				chart.flush();
			}, 200));
		},
		generateBarGrouped: function (options) {
			var d = options.d;
			var headings = d3.keys(d[0]);

			var axis_y_tick_format = d3.format(",");
			if (options.axis_y_tick_format === 'dollars') {
				axis_y_tick_format = function (d) { return '$' + d; };
			} else if (options.axis_y_tick_format === 'percent') {
				axis_y_tick_format = function (d) { return d + '%'; };
			}

			var chart = c3.generate({
				bindto: d3.select($('#' + options.chartId).get(0)),
				data: {
					url: options.data_url,
					hide: [headings[0]],
					order: [d3.keys(d[0])],
					type: 'bar',
					x: headings[0],
					columns: [d3.keys(d[0])],
					keys: {
						x: headings[0]
					},
				},
				color: {
					pattern: ["#A2D06D", "#00396e", "#e6b936", "#008FD4", "#9E7A38", "#DA2128"]
				},
				axis: {
					x: {
						type: 'category',
						label: {
							text: options.axis_x_label_text,
							position: 'outer-center',
							multiline: false
						},
					},
					y: {
						label: {
							text: options.axis_y_label_text,
							position: 'inner-middle',
						},
						tick: {
							format: axis_y_tick_format
						},
					}
				},
				grid: {
					y: {
						show: true,
					}
				},
				legend: {
					show: false
				},
				onrendered: function () {
					generateLegend({
						d: d,
						chart: this,
						chartId: options.chartId,
						chartType: 'bar_chart_grouped',
						axis_x_tick_format: options.axis_x_tick_format,
						axis_y_tick_format: options.axis_y_tick_format
					});
					resizeAxisLabels({
						chartId: options.chartId,
						disableXAxisLabelResizing: options.disableXAxisLabelResizing,
						disableYAxisLabelResizing: options.disableYAxisLabelResizing

					});
				}
			});
			$(window).on('scroll', _.throttle(function () {
				chart.flush();
			}, 200));
		},
		generateBarStacked: function (options) {
			var d = options.d;
			var headings = d3.keys(d[0]);
			var rangeMin;
			var rangeMax;
			var axis_y_tick_format = d3.format(",");
			if (options.axis_y_tick_format === 'dollars') {
				axis_y_tick_format = function (d) { return '$' + d; };
			} else if (options.axis_y_tick_format === 'percent') {
				rangeMin = 10;
				rangeMax = 90;
				axis_y_tick_format = function (d) { return d + '%'; };
			}

			var axis_y_padding = null;
			if ($.isNumeric(options.axis_y_padding)) {
				axis_y_padding = { top: options.axis_y_padding, bottom: options.axis_y_padding };
			}

			var chart = c3.generate({
				bindto: d3.select($('#' + options.chartId).get(0)),
				data: {
					url: options.data_url,
					hide: [headings[0]],
					order: [d3.keys(d[0])],
					type: 'bar',
					x: headings[0],
					groups: [d3.keys(d[0])],
					keys: {
						x: headings[0]
					},
				},
				color: {
					pattern: ["#A2D06D", "#00396e", "#e6b936", "#008FD4", "#9E7A38", "#DA2128"]
				},
				axis: {
					rotated: true,
					x: {
						type: 'category',
						label: {
							text: options.axis_x_label_text,
							position: 'outer-top',
							multiline: false
						}
					},
					y: {
						inner: false,
						max: rangeMax,
						min: rangeMin,
						label: {
							text: options.axis_y_label_text,
							position: 'outer-middle'
						},
						padding: axis_y_padding,
						tick: {
							format: axis_y_tick_format
						},
					}
				},
				grid: {
					y: {
						show: true,
					},
					x: {
						show: true
					}
				},
				tooltip: {
					contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
						var toolTipFormat = axis_y_tick_format(d[0].value);
						return "<div id='Tooltip'><div class='tooltip-circle' style='background-color:"
							+ color(d[0]) + ";'></div><p class='tooltip-text'><b>" + d[0].name + "</b><br />" + toolTipFormat + "<br/>"
							+ defaultTitleFormat(d[0].x) + "</p></div>";
					},
					position: function (data, width, height, element) {
						//tracking mouse position within unique div - get offset on page.
						var offset = $('#' + options.chartId).offset();
						var xPos = event.pageX - offset.left;
						var yPos = event.pageY - offset.top;
						return { top: yPos - 85, left: xPos };
					},
					grouped: false
				},
				legend: {
					show: false
				},
				onrendered: function () {
					generateLegend({
						d: d,
						chart: this,
						chartId: options.chartId,
						chartType: 'bar_chart_stacked',
						axis_x_tick_format: options.axis_x_tick_format,
						axis_y_tick_format: options.axis_y_tick_format
					});
					resizeAxisLabels({
						chartId: options.chartId,
						disableXAxisLabelResizing: options.disableXAxisLabelResizing,
						disableYAxisLabelResizing: options.disableYAxisLabelResizing

					});
				}
			});
			$(window).on('scroll', _.throttle(function () {
				chart.flush();
			}, 200));
		},
		generateDonut: function (options) {
			var d = options.d;
			var donutWidth = isMobile() ? 45 : 60;

			var chart = c3.generate({
				bindto: d3.select($('#' + options.chartId).get(0)),
				data: {
					url: options.data_url,
					order: [d3.keys(d[0])],
					type: 'donut',
					columns: [d3.keys(d[0])],
					onmouseover: function (d) {
						generateDonutArcTitle({
							chartId: options.chartId,
							format: options.axis_x_tick_format,
							id: d.id,
							value: d.value
						});
					}
				},
				donut: {
					title: " ",
					expand: false,
					width: donutWidth,
					label: {
						show: false
					}
				},
				color: {
					pattern: ["#A2D06D", "#00396e", "#e6b936", "#008FD4", "#9E7A38", "#DA2128", "#E2E7EA", '#000000', "#346139"]
				},

				tooltip: {
					show: false
				},
				legend: {
					show: false
				},
				onrendered: function () {
					generateLegend({
						d: d,
						chart: this,
						chartId: options.chartId,
						chartType: 'donut_chart',
						axis_x_tick_format: options.axis_x_tick_format,
						axis_y_tick_format: options.axis_y_tick_format
					});
				}
			});
			$(window).on('scroll', _.throttle(function () {
				chart.flush();
			}, 200));
		},
		generateMultiLine: function (options) {
			var d = options.d;
			var headings = d3.keys(d[0]);

			var axis_y_tick_format = d3.format(",");
			if (options.axis_y_tick_format === 'dollars') {
				axis_y_tick_format = function (d) { return '$' + d; };
			} else if (options.axis_y_tick_format === 'percent') {
				axis_y_tick_format = function (d) { return d + '%'; };
			}

			var dataTypes = {};

			if (options.altDataType && options.chartType === 'multi_line_bar') {
				dataTypes[options.altDataType] = 'bar';
			} else if (options.altDataType && options.chartType === 'multi_line_area') {
				dataTypes[options.altDataType] = 'area';
			}

			var altDataColor = (options.altDataColor) ? options.altDataColor : 'rgba(60, 89, 118, 0.2)';

			var chart = c3.generate({
				axis: {
					x: {
						type: 'timeseries',
						padding: {
							multiline: false
						},
						label: {
							text: options.axis_x_label_text,
							position: 'outer-center'
						},
						tick: {
							format: '%Y',
							multiline: false
						}
					},
					y: {
						label: {
							text: options.axis_y_label_text,
							position: 'outer-top'
						},
						tick: {
							format: axis_y_tick_format
						},
					}
				},
				bindto: d3.select($('#' + options.chartId).get(0)),
				color: {
					pattern: ["#00396e", "#51c0ec", "#a3ce72", "#e6b936", "#DA2128"]
				},
				data: {
					url: options.data_url,
					type: 'line',
					types: dataTypes,
					x: headings[0],
					xFormat: '%Y'
				},
				grid: {
					y: {
						show: true
					}
				},
				legend: {
					show: false
				},
				point: {
					show: false
				},
				tooltip: {
					contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
						return getTooltip(d, defaultTitleFormat, defaultValueFormat, color, altDataColor, options);
					}
				},
				onrendered: function () {

					if (options.chartType === 'multi_line_area') {
						d3.selectAll('#' + options.chartId + ' .c3-area-' + options.altDataType).attr('style', 'fill: ' + altDataColor);
						d3.selectAll('#' + options.chartId + ' .c3-line-' + options.altDataType).attr('style', 'stroke: ' + altDataColor);
					} else if (options.chartType === 'multi_line_bar') {
						d3.selectAll('#' + options.chartId + ' .c3-bar').attr('style', 'stroke: ' + altDataColor + '; fill: ' + altDataColor);
					}

					generateLegend({
						d: d,
						altDataType: options.altDataType,
						altDataColor: altDataColor,
						chart: this,
						chartId: options.chartId,
						chartType: 'bar_chart_stacked',
						axis_x_tick_format: options.axis_x_tick_format,
						axis_y_tick_format: options.axis_y_tick_format
					});

					resizeAxisLabels({
						chartId: options.chartId,
						disableXAxisLabelResizing: options.disableXAxisLabelResizing,
						disableYAxisLabelResizing: options.disableYAxisLabelResizing
					});
				}
			});
			$(window).on('scroll', _.throttle(function () {
				chart.flush();
			}, 200));
		},
		bindEvents: function () {

			/* 
			 $(".icon-info-white").on('click', function () {
				var $this = $(this);
				$this.toggleClass('on');
				$this.parents('.infographic-info').find('.infographic-aside, .infographic-source').toggle();
				$this.parents('.infographic-info').find('.infographic-title, .infographic-description').toggle();
			});

			$('.icon-close-white').on('click', function () {
				$('.side-narrative').remove();
			});

			$('.mobile-legend-icons .icon-paragraphh-white, .mobile-legend-icons .icon-key-white').on('click', function () {
				var activeButton;
				if ($('.infographic-button').hasClass('on')) {
					activeButton = $('.infographic-buttons .on').attr("id").slice(-1);

					// note: not currently intended for multiple charts on a single page.
					// fires once for each element on the page, if theres more than one
					var $this = $(this);
					if ($this.hasClass('icon-paragraphh-white')) {
						// stuff for paragraph icon here.
						if (!$this.hasClass('activated')) {
							$this.addClass('activated');
							$('.side-narratives').addClass('open').children().hide();
							$('.icon-key-white').removeClass('activated');
							$('.infographic-legend ul').hide();
							$('.side-narratives #side-narrative' + activeButton).show();
						}
					}
					else {
						// we clicked the key. do stuff with the key.
						if (!$this.hasClass('activated')) {
							$this.addClass('activated');
							$('.side-narratives').removeClass('open').children().hide();
							$('.icon-paragraphh-white').removeClass('activated');
							$('.infographic-legend ul').show();
						}
					}
				}
			});
			*/

			$('.infographic-button').hover(
				function () {
					var $this = $(this);
					console.log($this);
					if ($this.hasClass('on')) {
						return;
					}
					$('.infographic-button').removeClass('on');
					showSideNarrative($this.attr('id').replace('infographic-button', ''));

					if ($this.is(":first-of-type")) {
						console.log('first-of-type');
						applyFade(getDataClasses(), [2, 3, 4]);
					}
					else if ($this.is(":nth-of-type(2)")) {
						console.log('nth-of-type(2)');
						applyFade(getDataClasses(), [0, 1, 4]);
					}
					else {
						console.log('otherwise');
						applyFade(getDataClasses(), [0, 1, 2, 3]);
					}
				},
				function () {
					var $this = $(this);
					if (!$this.hasClass('on')) {
						hideSideNarrative();
					}
					applyFade();
				}
			);

			$('.icon-paragraph-white').on('click', function (e) {
				$('.side-narrative').toggle();
				return false;
			});

			$('.icon-close-white').on('click', function (e) {
				$('.infographic-button').removeClass('on');
				$('.side-narrative').remove();
				// TODO media query
				if (isMobile()) {
					d3.selectAll('.c3-defocused').classed('c3-defocused', false);
				}
				if ($('.mobile-legend-icons .icon-paragraphh-white').hasClass('activated')) {
					$('.side-narratives').removeClass('open').children().hide();
					$('.icon-paragraphh-white').removeClass('activated');
					$('.icon-key-white').addClass('activated');
					$('.infographic-legend ul').show();
				}
				return false;
			});
			
			$('.infographic-button').on('click', function (e) {

				var $this = $(this);
				var index = $this.attr('id').replace('infographic-button', '');
				
				$('.infographic-button').removeClass('on');
				$this.addClass('on');
				
				$('.icon-paragraph-white, .icon-close-white').hide();
				$('.icon-paragraph-white, .icon-close-white', $this).show();

				showSideNarrative(index);
				
				if ($this.is(":first-of-type")) {
					console.log('first-of-type');
					applyFade(getDataClasses(), [2, 3, 4]);
				}
				else if ($this.is(":nth-of-type(2)")) {
					console.log('nth-of-type(2)');
					applyFade(getDataClasses(), [0, 1, 4]);
				}
				else {
					console.log('otherwise');
					applyFade(getDataClasses(), [0, 1, 2, 3]);
				}

				/* 
				var id = $this.attr('id').replace('infographic-button', 'side-narrative');
				var dataClasses = getDataClasses();
				// var activeButton;
				if (!$this.hasClass('on') && $(this).closest('.infographic-buttons').children().hasClass('on')) {
					$(this).closest('.infographic-buttons').children().removeClass('on');
				}
				applyFade();
				$this.addClass('on');

				// TODO media query
				if ($(window).width() <= 768 && $('.mobile-legend-icons .icon-paragraphh-white').hasClass('activated')) {
					activeButton = $('.infographic-buttons .on').attr("id").slice(-1);
					$('.side-narratives').children().hide();
					$('.side-narratives #side-narrative' + activeButton).show();
				}
				if ($(this).is(":first-of-type")) {
					applyFade(dataClasses, [2, 3, 4]);
				}
				else if ($(this).is(":nth-of-type(2)")) {
					applyFade(dataClasses, [0, 1, 4]);
				}
				else {
					applyFade(dataClasses, [0, 1, 2, 3]);
				}
				*/
			});
		}
	};
}));

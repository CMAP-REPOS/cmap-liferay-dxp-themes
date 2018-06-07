(function (root, factory) {
	if (typeof define === 'function' && define.amd) {
		define('infographics', [], factory);
	} else if (typeof module === 'object' && module.exports) {
		module.exports = factory();
	} else {
		root.infographics = factory();
	}
}(this, function () {

	function formatValue(format, value) {
		if (format === 'number') {
			return d3.format(",")(value);
		} else if (format === 'dollars') {
			return '$' + d3.format(",")(value);
		} else if (format === 'percent') {
			return d3.format(",")(value) + '%';
		} else {
			return value;
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

	}

	var siFormat = d3.format(",");

	return {

		generateAreaStacked: function (options) {
			console.log('infographics.generateAreaStacked()');
			console.log(options);
			var d = options.d;
			var headings = d3.keys(d[0]);
			var altDataColor = (options.altDataColor) ? options.altDataColor : 'rgba(60, 89, 118, 0.2)';

			var chart = c3.generate({
				axis: {
					x: {
						type: 'category',
						padding: {
							left: options.axis_x_padding_left,
						},
						label: {
							text: options.axis_x_label_text,
							// position: 'outer-center'
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
							// position: 'inner-middle'
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
					show: options.display_tooltip,
					contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
						return getTooltip(d, defaultTitleFormat, defaultValueFormat, color, altDataColor, options);
					}
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
		},
		generateBarGrouped: function (options) {
			console.log('infographics.generateBarGrouped()');
			console.log(options);
			var d = options.d;
			var headings = d3.keys(d[0]);
			var altDataColor = (options.altDataColor) ? options.altDataColor : 'rgba(60, 89, 118, 0.2)';
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
				axis: {
					x: {
						label: {
							position: 'outer-right',
							text: options.axis_x_label_text
						},
						tick: {
							rotate: 90,
							multiline: false
						},
						type: 'category'
					},
					y: {
						label: {
							position: 'outer-left',
							text: options.axis_y_label_text
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
				tooltip: {
					show: options.display_tooltip,
					contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
						return getTooltip(d, defaultTitleFormat, defaultValueFormat, color, altDataColor, options);
					}
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
		},
		generateBarStacked: function (options) {
			console.log('infographics.generateBarStacked()');
			console.log(options);
			var d = options.d;
			var headings = d3.keys(d[0]);
			var rangeMin;
			var rangeMax;
			var tickLimit = 10;
			var axis_y_tick_format = d3.format(",");
			var axis_y_padding = null;
			var altDataColor = (options.altDataColor) ? options.altDataColor : 'rgba(60, 89, 118, 0.2)';

			if (options.axis_y_tick_format === 'dollars') {
				axis_y_tick_format = function (d) { return '$' + d; };
			} else if (options.axis_y_tick_format === 'percent') {
				rangeMin = 10;
				rangeMax = 90;
				axis_y_tick_format = function (d) { return d + '%'; };
			}

			if ($.isNumeric(options.axis_y_padding)) {
				axis_y_padding = { top: options.axis_y_padding, bottom: options.axis_y_padding };
			}

			if (d.length < tickLimit) {
				tickLimit = d.length;
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
				axis: {
					rotated: options.display_horizontally,
					x: {
						type: 'category',
						label: {
							text: options.axis_x_label_text,
							position: 'outer-top',
							multiline: false
						},
						tick: {
							count: tickLimit
						}
					},
					y: {
						inner: false,
						max: rangeMax,
						min: rangeMin,
						label: {
							text: options.axis_y_label_text,
							position: 'outer-left'
						},
						padding: axis_y_padding,
						tick: {
							format: axis_y_tick_format
						},
					}
				},
				bar: {
					width: {
						ratio: options.bar_width_ratio
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
				legend: {
					show: false
				},
				tooltip: {
					show: options.display_tooltip,
					contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
						return getTooltip(d, defaultTitleFormat, defaultValueFormat, color, altDataColor, options);
					}
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
		},
		generateMultiLine: function (options) {
			console.log('infographics.generateMultiLineBar()');
			console.log(options);
			var d = options.d;
			var headings = d3.keys(d[0]);
			var data_types = {};
			var altDataColor = (options.altDataColor) ? options.altDataColor : 'rgba(60, 89, 118, 0.2)';

			if (options.altDataType && options.chartType === 'multi_line_bar') {
				data_types[options.altDataType] = 'bar';
			} else if (options.altDataType && options.chartType === 'multi_line_area') {
				data_types[options.altDataType] = 'area';
			}

			var chart = c3.generate({
				axis: {
					x: {
						label: {
							position: options.axis_x_label_position,
							text: options.axis_x_label_text
						},
						padding: { 
							left: options.axis_x_padding, 
							right: options.axis_x_padding 
						},
						tick: {
							format: function (x) {
								return formatValue(options.axis_x_tick_format, x);
							}
						}
					},
					y: {
						label: {
							position: options.axis_y_label_position,
							text: options.axis_y_label_text
						},
						padding: { 
							bottom: options.axis_y_padding, 
							top: options.axis_y_padding 
						},
						tick: {
							format: function (y) {
								return formatValue(options.axis_y_tick_format, y);
							}
						}
					}
				},
				bindto: d3.select($('#' + options.chartId).get(0)),
				data: {
					url: options.data_url,
					type: 'line',
					types: data_types,
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
					show: options.display_tooltip,
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
		},
		bindEvents: function () {
		}
	};
}));

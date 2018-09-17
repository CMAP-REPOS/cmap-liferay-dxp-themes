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

		generateBarGrouped: function (options) {
			console.log('infographics.generateBarGrouped()');
			console.log(options);
			var d = options.d;
			var headings = d3.keys(d[0]);
			var axis_x_rotation = (options.rotate_x_axis_label) ? 45 : 0;
			var color_pattern = undefined; 
			var altDataColor = (options.altDataColor) ? options.altDataColor : 'rgba(60, 89, 118, 0.2)';
			var axis_y_tick_format = d3.format(",");

			if (options.color_pattern && options.color_pattern.length) {
				color_pattern = options.color_pattern;
			}
			
			var chart = c3.generate({
				axis: {
					x: {
						label: {
							position: options.axis_x_label_position,
							text: options.axis_x_label_text
						},
						padding: { 
							left: parseFloat(options.axis_x_padding), 
							right: parseFloat(options.axis_x_padding) 
						},
						tick: {
							multiline: false,
							rotate: axis_x_rotation
						},
						type: 'category'
					},
					y: {
						label: {
							position: options.axis_y_label_position,
							text: options.axis_y_label_text
						},
						padding: { 
							bottom: parseFloat(options.axis_y_padding), 
							top: parseFloat(options.axis_y_padding) 
						},
						tick: {
							format: function (y) {
								return formatValue(options.axis_y_tick_format, y);
							}
						}
					}
				},
				bindto: d3.select($('#' + options.chartId).get(0)),
				color: {
					pattern: color_pattern
				},
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
			var axis_x_rotation = (options.rotate_x_axis_label) ? 45 : 0;
			var color_pattern = undefined; 
			var altDataColor = (options.altDataColor) ? options.altDataColor : 'rgba(60, 89, 118, 0.2)';

			if (options.axis_y_tick_format === 'percent') {
				rangeMin = 10;
				rangeMax = 90;
			}

			if (options.color_pattern && options.color_pattern.length) {
				color_pattern = options.color_pattern;
			}

			if (d.length < tickLimit) {
				tickLimit = d.length;
			}
			
			var axis_x_format_function = undefined;
			var axis_y_format_function = function (v) {
				return formatValue(options.axis_y_tick_format, v);
			};

			if (options.display_horizontally) {
				axis_x_format_function = function (v) {
					return formatValue(options.axis_y_tick_format, v);
				}
				axis_y_format_function = undefined;
			}

			var chart = c3.generate({
				axis: {
					rotated: options.display_horizontally,
					x: {
						label: {
							position: options.axis_x_label_position,
							text: options.axis_x_label_text
						},
						padding: { 
							left: parseFloat(options.axis_x_padding), 
							right: parseFloat(options.axis_x_padding) 
						},
						tick: {
							count: tickLimit,
							rotate: axis_x_rotation
						},
						type: 'category'
					},
					y: {
						inner: false,
						max: rangeMax,
						min: rangeMin,
						label: {
							position: options.axis_y_label_position,
							text: options.axis_y_label_text
						},
						padding: { 
							bottom: parseFloat(options.axis_y_padding), 
							top: parseFloat(options.axis_y_padding) 
						},
						tick: {
							format: function (y) {
								return formatValue(options.axis_y_tick_format, y);
							}
						},
					}
				},
				bar: {
					width: {
						ratio: options.bar_width_ratio
					}
				},
				bindto: d3.select($('#' + options.chartId).get(0)),
				color: {
					pattern: color_pattern
				},
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
			var axis_x_rotation = (options.rotate_x_axis_label) ? 45 : 0;
			var color_pattern = undefined; 
			var altDataColor = (options.altDataColor) ? options.altDataColor : 'rgba(60, 89, 118, 0.2)';

			if (options.color_pattern && options.color_pattern.length) {
				color_pattern = options.color_pattern;
			}

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
							left: parseFloat(options.axis_x_padding), 
							right: parseFloat(options.axis_x_padding) 
						},
						tick: {
							rotate: axis_x_rotation
						}
					},
					y: {
						label: {
							position: options.axis_y_label_position,
							text: options.axis_y_label_text
						},
						padding: { 
							bottom: parseFloat(options.axis_y_padding), 
							top: parseFloat(options.axis_y_padding) 
						},
						tick: {
							format: function (y) {
								return formatValue(options.axis_y_tick_format, y);
							}
						}
					}
				},
				bar: {
					width: {
						ratio: options.bar_width_ratio
					}
				},
				bindto: d3.select($('#' + options.chartId).get(0)),
				color: {
					pattern: color_pattern
				},
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

(function (root, factory) {
	if (typeof define === 'function' && define.amd) {
		define('infographics', [], factory);
	} else if (typeof module === 'object' && module.exports) {
		module.exports = factory();
	} else {
		root.infographics = factory();
	}
}(this, function () {

	function getDonutDataValue(d, id) {
        var dataset;
        for (var i = 0; i < d.length; i++) {
            dataset = d[i];

            for (key in dataset) {

                if (key === id) {
                    return dataset[key];
                }
            }
        }
	};
	
	function removeAllFade() {
//		var activeClass = "c3-defocused";
//		d3.selectAll('g').classed(activeClass, false);
	};

	function updateInfo() {
//		var thisID = $('.button-container').find('.on').attr('id');
//		$('.side-narrative').find('#' + thisID).addClass('display');
//		$('.mini-info:not(#' + thisID + ')').removeClass('display');
	};
	
	function formatValue(format, value) {
		if (format === 'dollars') {
			return '$' + d3.format(",")(value)
		} else if (format === 'percent') {
			return d3.format(",")(value) + '%';
		} else {
			return d3.format(",")(value);
		}
	};
	
	function getTooltip(d, defaultTitleFormat, defaultValueFormat, color, altDataColor, options) {
		var formatColor = function (e) {
			if (options.altDataType && e.name.toLowerCase() === options.altDataType.toLowerCase()) {
				return altDataColor;
			} else {
				return color(e);
			}
		}
		var lines = [];
		lines.push('<div><table class="c3-tooltip"><thead><tr>');
		lines.push('<th colspan="2">' + defaultTitleFormat(d[0].x) + '</th>');
		lines.push('</tr></thead><tbody>')
		$.each(d, function (i, e) {
			lines.push('<tr><td class="name"><span><i class="icon-circle" style="color: ' + formatColor(e) + '"></i> </span>' + e.name + '</td><td class="value">' + formatValue(options.axis_y_tick_format, e.value) + '</td></tr>');
		});
		lines.push('</tbody></table></div>')
		return lines.join('');
	};
	
	
	function generateDonutArcTitle(options) {
		var id = options.id;
        var formattedValue = formatValue(options.format, options.value);
		var node = d3.select('#' + options.chartId + ' .c3-chart-arcs-title').node();
        if (id.length > 32) {
        	var words = id.split(/\s+/);
			node.innerHTML = "<tspan>" + 
			formattedValue + 
			'</tspan><tspan class="upper" x="-1" y="25">' + 
			words.slice(0,Math.floor(words.length/2)).join(' ') + 
			'</tspan><tspan class="upper" x="-1" y="50">' + 
			words.slice(Math.floor(words.length/2)).join(' ') + 
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

	function generateLegend(options) {
		console.log('infographics.generateLegend()');
		console.log(options);
		var d = options.d;
		var legendData = d3.keys(d[0]).splice(1);
		if (options.chartType === 'donut_chart') {
			legendData = d3.keys(d[0]);
		}
		$('.infographic-legend.' + options.chartId + '-legend').html('');
		d3.select('.infographic-legend.' + options.chartId + '-legend').insert('ul')
			.attr('class', 'text-center list-unstyled list-inline')
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
				if ($(window).width() > 420) {
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
				if ($(window).width() < 420) {
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
	};

	var donutWidth = 45;
	var siFormat = d3.format(",");

	if ($(window).width() > 420) {
		donutWidth = 60;
	}

	return {
		generateAreaStacked: function (options) {
			console.log('infographics.generateAreaStacked()');
			console.log(options);
			var d = options.d;
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
					grouped: false
				},
				onrendered: function () {
					generateLegend({
						d: d,
						chart: this,
						chartId: options.chartId,
						chartType: 'area_stacked',
						axis_x_tick_format: options.axis_x_tick_format,
						axis_y_tick_format: options.axis_y_tick_format
					})
				}
			});
		},
		generateBarGrouped: function (options) {
			console.log('infographics.generateBarGrouped()');
			console.log(options);
			var d = options.d;
			var headings = d3.keys(d[0]);

			var axis_y_tick_format = d3.format(",");
			if (options.axis_y_tick_format === 'dollars') {
				axis_y_tick_format = function (d) { return '$' + d; }
			} else if (options.axis_y_tick_format === 'percent') {
				axis_y_tick_format = function (d) { return d + '%'; }
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
					pattern: ["#DA2128", "#A2D06D", "#00396e", "#e6b936", "#008FD4", "#9E7A38"]
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
					})
				}
			});
		},
		generateBarStacked: function (options) {
			console.log('infographics.generateBarStacked()');
			console.log(options);
			var d = options.d;
			var headings = d3.keys(d[0]);

			var axis_y_tick_format = d3.format(",");
			if (options.axis_y_tick_format === 'dollars') {
				axis_y_tick_format = function (d) { return '$' + d; }
			} else if (options.axis_y_tick_format === 'percent') {
				axis_y_tick_format = function (d) { return d + '%'; }
			}

			var axis_y_padding = null;
			if ($.isNumeric(options.axis_y_padding)) {
				axis_y_padding = { top: options.axis_y_padding, bottom: options.axis_y_padding }
			}

			c3.generate({
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
					pattern: ["#DA2128", "#A2D06D", "#00396e", "#e6b936", "#008FD4", "#9E7A38"]
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
					})
				}
			});
		},
		generateDonut: function (options) {
			console.log('infographics.generateDonut()');
			console.log(options);
			var d = options.d;

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
				onrendered: function() {
					generateLegend({
						d: d,
						chart: this,
						chartId: options.chartId,
						chartType: 'donut_chart',
						axis_x_tick_format: options.axis_x_tick_format,
						axis_y_tick_format: options.axis_y_tick_format
					})
				}
			});
		},
		generateMultiLine: function (options) {
			console.log('infographics.generateMultiLineBar()');
			console.log(options);
			var d = options.d;
			var headings = d3.keys(d[0]);

			var axis_y_tick_format = d3.format(",");
			if (options.axis_y_tick_format === 'dollars') {
				axis_y_tick_format = function (d) { return '$' + d; }
			} else if (options.axis_y_tick_format === 'percent') {
				axis_y_tick_format = function (d) { return d + '%'; }
			}

			var dataTypes = {};

			if (options.altDataType && options.chartType === 'multi_line_bar') {
				dataTypes[options.altDataType] = 'bar';
			} else if (options.altDataType && options.chartType === 'multi_line_area') {
				dataTypes[options.altDataType] = 'area';
			}

			var altDataColor = (options.altDataColor) ? options.altDataColor : 'rgba(60, 89, 118, 0.2)';

			c3.generate({
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
					})
				}
			});
		},
		resizeAxisLabels: function (options) {
			/*
			if (!options.disableXAxisLabelResizing || !options.disableYAxisLabelResizing) {
				var yChildren = $('#' + options.chartId).find('g.c3-axis-y').children('.tick').children("text").not('[style*="display: none"]');
				var yCount = yChildren.length;

				var xChildren = $('#' + options.chartId).find('g.c3-axis.c3-axis-x').children('.tick').children("text").not('[style*="display: none"]');
				var xCount = xChildren.length;

				if (xCount < 10 && !options.disableXAxisLabelResizing) {
					xChildren.attr("font-size", "14px");
				}

				if (yCount < 10 && !options.disableYAxisLabelResizing) {
					yChildren.attr("font-size", "14px");
				}
			}
			*/
		},
		bindDonutLegendEvents: function (options) {
			console.log('infographics.bindDonutLegendEvents()');
			console.log(options);

			/* if ($(window).width() > 420) {
				$('.legend-info.donut_chart .legend p').mouseover(function () {
					d3.selectAll('#' + options.chartId + ' g.c3-chart-arcs g.c3-chart-arc.c3-target:not(.c3-focused)').classed('legend-hover', true);
				});
				$('.legend-info.donut_chart .legend p').mouseout(function () {
					d3.selectAll('#' + options.chartId + ' g.c3-chart-arcs g.c3-chart-arc.c3-target').classed('legend-hover', false);
				});
			}
			else {
				$('.legend-info.donut_chart .legend p').click(function () {
					d3.selectAll('#' + options.chartId + ' g.c3-chart-arcs g.c3-chart-arc.c3-target:not(.c3-focused)').classed('legend-hover', true);
					d3.selectAll('#' + options.chartId + ' g.c3-chart-arcs g.c3-chart-arc.c3-target.c3-focused').classed('legend-hover', false);
					if (!$(this).hasClass('legend-clicked')) {
						d3.selectAll('#' + options.chartId + ' g.c3-chart-arcs g.c3-chart-arc.c3-target').classed('legend-hover', false);
					}
					return false;
				});
			} */
		},
		bindEvents: function () {
			console.log('infographics.bindEvents()');
			$(".icon-info-white").on('click', function () {
				var $this = $(this);
				$this.toggleClass('on');
				$this.parents('.infographic-info').find('.infographic-aside, .infographic-source').toggle();
				$this.parents('.infographic-info').find('.infographic-title, .infographic-description').toggle();
			});

			$('.icon-close-white').on('click', function() {
				$('.side-narrative').remove();
			});
			
			$('.icon-paragraphh-white').on('click', function() {
				var $this = $(this);
			});

			$('.infographic-button').on('click mouseenter', function() {
				var $this = $(this);
				var id = $this.attr('id').replace('infographic-button','side-narrative');
				$('.side-narrative').remove();
				$('.infographic-chart').append('<div class="side-narrative">' + $('#'+id).html() + '</p>');
			});
			
			$('.infographic-button').on('mouseleave', function() {
				var $this = $(this);
				$('.side-narrative').remove();
			});
		}
	};
}));


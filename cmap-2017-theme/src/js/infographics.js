(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define('infographics', [], factory);
    } else if (typeof module === 'object' && module.exports) {
        module.exports = factory();
    } else {
        root.infographics = factory();
  }
}(this, function () {

	function getDataValue() {
		console.log('getDataValue');
	}

    var labelPosition = 'inner-middle';
    var axisPosition = false;
    var donutWidth = 45;
    var siFormat = d3.format(",");

	if ($(window).width() > 420) {
	    labelPosition = 'outer-top';
	    axisPosition = true;
	    // xPadding = 15;
	    donutWidth = 60;
	}

    return {
    	generateAreaStacked: function (options) {
    	    console.log('infographics.generateAreaStacked()');
    	    console.log(options);
    	    var d = options.d;
    	    var headings = d3.keys(d[0]);
    	    var chart = c3.generate({
    	        size: {
    	            height: 440
    	        },
    	        bindto: d3.select($('#'+options.chartId).get(0)),
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
    	        color: {
    	            pattern: ["rbga(255, 255, 255, 0)", "#00396e", "#51c0ec", "#2a5633", "#a3ce72", "#e6b936"]
    	        },
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
    	                    //can prolly be a function for multiples of 12..
    	                    values: [0, 12, 24, 36, 48, 60, 72, 84, 96, 108, 120, 132, 144, 156, 168, 180, 192, 204, 216, 228, 240, 252, 264, 276],
    	                    multiline: false
    	                }
    	            },
    	            y: {
    	                inner: true,
    	                label: {
    	                    text: options.axis_y_label_text,
    	                    position: labelPosition
    	                },
    	                tick: {
    	                    format: //custom formatting to make sure we dont have a lot of 0's
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
    	        point: {
    	            show: false,
    	        },
    	        grid: {
    	            y: {
    	                show: true,
    	            }
    	        },
    	        tooltip: {
//    	            position: function (data, width, height, element) {
//    	                var offset = $('#'+options.chartId).offset();
//    	                var xPos = event.pageX - offset.left;
//    	                var yPos = event.pageY - offset.top;
//    	                return { top: yPos - 85, left: xPos };
//    	            },
    	            contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
    	                return "<div id='Tooltip'><div class='tooltip-circle' style='background-color:"
    	                    + color(d[0]) + ";'></div><p class='tooltip-text'><b>" + d[0].name + "</b><br />" + d3.format(",")(d[0].value) + "<br/>"
    	                    + defaultTitleFormat(d[0].x) + "</p></div>";
    	            },
    	            grouped: false
    	        },
    	        legend: {
    	            show: false
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
    	        bindto: d3.select($('#'+options.chartId).get(0)),
    	        padding: {
    	            top: 10,
    	            right: 0,
    	            bottom: 0,
    	            left: 0,
    	        },
    	        data: {
    	            //the file variable goes here.
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
    	                inner: true,
    	                label: {
    	                    text: options.axis_y_label_text,
    	                    position: labelPosition,
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
    	        tooltip: {
//    	            position: function (data, width, height, element) {
//    	                //tracking mouse position within unique div - get offset on page.
//    	                var offset = $('#'+options.chartID).offset();
//    	                var xPos = event.pageX - offset.left;
//    	                var yPos = event.pageY - offset.top;
//    	                return { top: yPos - 85, left: xPos };
//    	            },
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
    	        bindto: d3.select($('#'+options.chartId).get(0)),
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
    	                    position: options.axis_y_label_position,
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
//    	            position: function (data, width, height, element) {
//    	                var offset = $('#'+options.chartId).offset();
//    	                var xPos = event.pageX - offset.left;
//    	                var yPos = event.pageY - offset.top;
//    	                return { top: yPos - 85, left: xPos };
//    	            },
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
    	        }
    	    });
    	},
    	generateDonut: function (options) {
    	    console.log('infographics.generateDonut');
    	    console.log(options);
    	    var d = options.d;
    	    
    	    var axis_x_tick_format = d3.format(",");
    	    if (options.axis_x_tick_format === 'dollars') {
    	        axis_x_tick_format = function (d) { return '$' + d; }
    	    } else if (options.axis_x_tick_format === 'percent') {
    	        axis_x_tick_format = function (d) { return d + '%'; }
    	    }
    	    
    	    var chart = c3.generate({
    	        bindto: d3.select($('#'+options.chartId).get(0)),
    	        data: {
    	            url: options.data_url,
    	            order: [d3.keys(d[0])],
    	            type: 'donut',
    	            columns: [d3.keys(d[0])],
    	            onmouseover: function (d) {
    	                var valueFormatted = axis_x_tick_format(d.value);
    	                console.log(valueFormatted);
    	                var node = d3.select('#'+options.chartId + ' .c3-chart-arcs-title').node();
    	                console.log(node);
    	                node.innerHTML = "<tspan>" +
    	                    valueFormatted +
    	                    "</tspan><tspan class='upper' x='-1' y='25'>" +
    	                    d.id +
    	                    "</tspan>";
    	                // append node to its parent so that is rendered on top of arcs
    	                node.parentNode.append(node);
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
    	        }
    	    });
    	},
    	generateMultiLine: function (options) {
    	    console.log('infographics.generateMultiLine');
    	    console.log(options);
    	    var d = options.d;
    	    var headings = d3.keys(d[0]);
    	    
    	    var axis_y_tick_format = d3.format(",");
    	    if (options.axis_y_tick_format === 'dollars') {
    	        axis_y_tick_format = function (d) { return '$' + d; }
    	    } else if (options.axis_y_tick_format === 'percent') {
    	        axis_y_tick_format = function (d) { return d + '%'; }
    	    }

    	    c3.generate({
    	        bindto: d3.select($('#'+options.chartId).get(0)),
    	        data: {
    	            url: options.data_url,
    	            type: 'line',
    	            x: headings[0],
    	            xFormat: '%Y', // 'xFormat' can be used as custom format of 'x' w/ d3 formatting strings.
    	        },
    	        color: {
    	            pattern: ["rbga(255, 255, 255, 0)", "#00396e", "#51c0ec", "#a3ce72", "#e6b936", "#DA2128", "rgba(60, 89, 118, 0.2)"]
    	        },
    	        legend: {
    	            show: false
    	        },
    	        axis: {
    	            x: {
    	                type: 'timeseries',
    	                padding: {
    	                    left: options.axis_x_padding_left,
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
    	                inner: true,
    	                label: {
    	                    text: options.axis_y_label_text,
    	                    position: options.axis_y_label_position

    	                },
    	                tick: {
    	                    format: d3.format(",")
    	                },
    	            }
    	        },
    	        point: {
    	            show: false
    	        },
    	        grid: {
    	            y: {
    	                show: true
    	            }
    	        },
    	        tooltip: {
//    	            position: function (data, width, height, element) {
//    	                var offset = $('#'+options.chartId).offset();
//    	                var xPos = event.pageX - offset.left;
//    	                var yPos = event.pageY - offset.top;
//    	                return { top: yPos - 85, left: xPos };
//    	            },
    	            contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
    	                var toolTipFormat = axis_y_tick_format(d[0].value);
    	                if (color(d[0]) != "rgba(60, 89, 118, 0.2)") {
    	                    return "<div id='Tooltip'><div class='tooltip-circle' style='background-color:"
    	                        + color(d[0]) + ";'></div> <p class='tooltip-text'><b>"
    	                        + d[0].name + "</b><br />" + toolTipFormat + "<br/>"
    	                        + defaultTitleFormat(d[0].x) + "</p></div>";
    	                }
    	                else {
    	                    return "<div id='Tooltip'><div class='tooltip-circle' style='background-color:#7992a6;'></div> <p class='tooltip-text'><b>"
    	                        + d[0].name + "</b><br />" + toolTipFormat + "<br/>"
    	                        + defaultTitleFormat(d[0].x) + "</p></div>";
    	                }
    	            },
    	            grouped: false
    	        }
    	    });
    	},   
    	generateMultiLineArea: function (options) {
    	    console.log('infographics.generateMultiLineArea');
    	    console.log(options);
    	    var d = options.d;
    	    var headings = d3.keys(d[0]);
    	    
    	    var axis_y_tick_format = d3.format(",");
    	    if (options.axis_y_tick_format === 'dollars') {
    	        axis_y_tick_format = function (d) { return '$' + d; }
    	    } else if (options.axis_y_tick_format === 'percent') {
    	        axis_y_tick_format = function (d) { return d + '%'; }
    	    }

    	    c3.generate({
    	        bindto: d3.select($('#'+options.chartId).get(0)),
    	        data: {
    	            url: options.data_url,
    	            type: 'line',
    	            types: options.data_types,
    	            x: headings[0],
    	            xFormat: '%Y', // 'xFormat' can be used as custom format of 'x' w/ d3 formatting strings.
    	        },
    	        color: {
    	            pattern: ["rbga(255, 255, 255, 0)", "#00396e", "#51c0ec", "#a3ce72", "#e6b936", "#DA2128", "rgba(60, 89, 118, 0.2)"]
    	        },
    	        legend: {
    	            show: false
    	        },
    	        axis: {
    	            x: {
    	                type: 'timeseries',
    	                padding: {
    	                    left: options.axis_x_padding_left,
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
    	                inner: true,
    	                label: {
    	                    text: options.axis_y_label_text,
    	                    position: options.axis_y_label_position

    	                },
    	                tick: {
    	                    format: d3.format(",")
    	                },
    	            }
    	        },
    	        point: {
    	            show: false
    	        },
    	        grid: {
    	            y: {
    	                show: true
    	            }
    	        },
    	        tooltip: {
//    	            position: function (data, width, height, element) {
//    	                var offset = $('#'+options.chartId).offset();
//    	                var xPos = event.pageX - offset.left;
//    	                var yPos = event.pageY - offset.top;
//    	                return { top: yPos - 85, left: xPos };
//    	            },
    	            contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
    	                var toolTipFormat = axis_y_tick_format(d[0].value);
    	                if (color(d[0]) != "rgba(60, 89, 118, 0.2)") {
    	                    return "<div id='Tooltip'><div class='tooltip-circle' style='background-color:"
    	                        + color(d[0]) + ";'></div> <p class='tooltip-text'><b>"
    	                        + d[0].name + "</b><br />" + toolTipFormat + "<br/>"
    	                        + defaultTitleFormat(d[0].x) + "</p></div>";
    	                }
    	                else {
    	                    return "<div id='Tooltip'><div class='tooltip-circle' style='background-color:#7992a6;'></div> <p class='tooltip-text'><b>"
    	                        + d[0].name + "</b><br />" + toolTipFormat + "<br/>"
    	                        + defaultTitleFormat(d[0].x) + "</p></div>";
    	                }
    	            },
    	            grouped: false
    	        }
    	    });
    	},   
    	generateMultiLineBar: function (options) {
    	    console.log('infographics.generateMultiLineBar');
    	    console.log(options);
    	    var d = options.d;
    	    var headings = d3.keys(d[0]);
    	    
    	    var axis_y_tick_format = d3.format(",");
    	    if (options.axis_y_tick_format === 'dollars') {
    	        axis_y_tick_format = function (d) { return '$' + d; }
    	    } else if (options.axis_y_tick_format === 'percent') {
    	        axis_y_tick_format = function (d) { return d + '%'; }
    	    }

    	    c3.generate({
    	        bindto: d3.select($('#'+options.chartId).get(0)),
    	        data: {
    	            url: options.data_url,
    	            type: 'line',
    	            types: options.data_types,
    	            x: headings[0],
    	            xFormat: '%Y', // 'xFormat' can be used as custom format of 'x' w/ d3 formatting strings.
    	        },
    	        color: {
    	            pattern: ["rbga(255, 255, 255, 0)", "#00396e", "#51c0ec", "#a3ce72", "#e6b936", "#DA2128", "rgba(60, 89, 118, 0.2)"]
    	        },
    	        legend: {
    	            show: false
    	        },
    	        axis: {
    	            x: {
    	                type: 'timeseries',
    	                padding: {
    	                    left: options.axis_x_padding_left,
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
    	                inner: true,
    	                label: {
    	                    text: options.axis_y_label_text,
    	                    position: options.axis_y_label_position

    	                },
    	                tick: {
    	                    format: d3.format(",")
    	                },
    	            }
    	        },
    	        point: {
    	            show: false
    	        },
    	        grid: {
    	            y: {
    	                show: true
    	            }
    	        },
    	        tooltip: {
//    	            position: function (data, width, height, element) {
//    	                var offset = $('#'+options.chartId).offset();
//    	                var xPos = event.pageX - offset.left;
//    	                var yPos = event.pageY - offset.top;
//    	                return { top: yPos - 85, left: xPos };
//    	            },
    	            contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
    	                var toolTipFormat = axis_y_tick_format(d[0].value);
    	                if (color(d[0]) != "rgba(60, 89, 118, 0.2)") {
    	                    return "<div id='Tooltip'><div class='tooltip-circle' style='background-color:"
    	                        + color(d[0]) + ";'></div> <p class='tooltip-text'><b>"
    	                        + d[0].name + "</b><br />" + toolTipFormat + "<br/>"
    	                        + defaultTitleFormat(d[0].x) + "</p></div>";
    	                }
    	                else {
    	                    return "<div id='Tooltip'><div class='tooltip-circle' style='background-color:#7992a6;'></div> <p class='tooltip-text'><b>"
    	                        + d[0].name + "</b><br />" + toolTipFormat + "<br/>"
    	                        + defaultTitleFormat(d[0].x) + "</p></div>";
    	                }
    	            },
    	            grouped: false
    	        }
    	    });
    	}, 
    	resizeAxisLabels: function(options) {
    	    console.log('infographics.resizeAxisLabels');
    	    console.log(options);
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
    	},
    	generateLegend: function(options) {
    	    console.log('infographics.generateLegend');
    	    console.log(options);
//    	    d3.select('.legend-info.' + options.chartType + '.' + options.chartId).insert('div', '.chart').attr('class', 'legend').selectAll('div')
//            .data(d3.keys(d[0]))
//            .enter().append('p')
//            .attr('class', function (id) {
//                return id;
//            })
//            .html(function (id) {
//                return '<span></span>' + id;
//            })
//            .each(function (id) {
//                d3.select(this).select('span').append("svg").attr("width", 8).attr("height", 8).append("circle").attr("cx", 4).attr("cy", 4).attr("r", 4).style('fill', chart.color(id));
//            })
//            .on('mouseover', function (id) {
//                if (options.chartType === "donut_chart")
//	                var dataValue = $(this).children('div').attr('data-value');
//	                //We get our title from id and then our number from 'data-value'
//	
//	            	if (options.axis_y_tick_format === 'dollars') {
//	                    var valueFormatted = '$' + getDataValue(d, id);
//	            	} else if (options.axis_y_tick_format === 'percent')
//	            		var valueFormatted = getDataValue(d, id) + '%';
//	                } else {
//	                    var valueFormatted = getDataValue(d, id);
//	                }
//	                d3.select('#' + options.chartId + ' .c3-chart-arcs-title').node().innerHTML = "<tspan>" + valueFormatted + "</tspan><tspan class='upper' x='-1' y='25'>" + id + "</tspan>";
//
//	                if ($(window).width() > 420) {
//	                    chart.focus(id);
//	                    var childButtons = $('.button-container').children();
//	                    if (childButtons.hasClass('on')) {
//	                        childButtons.removeClass('on');
//	                        $('.side-narrative').children().removeClass('display');
//	                    }
//	                }
//	                    	
//                }
//            })
//            .on('mouseout', function (id) {
//                chart.revert();
//            })
//            .on('click', function (id) {
//                if ($(window).width() < 420) {
//                    $(this).closest('.infographic-section').find('.button-container').children('.on').removeClass('on');
//                    $(this).toggleClass('legend-clicked').removeClass('m-legend-fade').siblings().removeClass('legend-clicked').addClass('m-legend-fade');
//                    chart.focus(id);
//
//                    if (!$(this).hasClass('legend-clicked')) {
//                        chart.revert();
//                        $(this).removeClass('m-legend-fade').siblings().removeClass('m-legend-fade');
//                    }
//
//                    return false;
//                }
//            });    		
    	},
    	bindDonutLegendEvents: function(options) {
    	    console.log('infographics.bindDonutLegendEvents');
    	    console.log(options);
		    if ($(window).width() > 420) {
		        //the legend-hover class is given to everything in mobile....
		        $('.legend-info.donut_chart .legend p').mouseover(function () {
		            d3.selectAll('#' + options.chartId + ' g.c3-chart-arcs g.c3-chart-arc.c3-target:not(.c3-focused)').classed('legend-hover', true);
		        });
		        $('.legend-info.donut_chart .legend p').mouseout(function () {
		            d3.selectAll('#' + options.chartId + ' g.c3-chart-arcs g.c3-chart-arc.c3-target').classed('legend-hover', false);
		        });
		    }
		    else {
		        $('.legend-info.donut_chart .legend p').click(function () {
		            //so this isn't being processed after the event and classes are all added... its as though its processing before the classes change. It works the first time with just this statement, but not repeatedly.
		            d3.selectAll('#' + options.chartId + ' g.c3-chart-arcs g.c3-chart-arc.c3-target:not(.c3-focused)').classed('legend-hover', true);
		            //well we just remove it from the focused one 'cause D3 doesn't get it.
		            d3.selectAll('#' + options.chartId + ' g.c3-chart-arcs g.c3-chart-arc.c3-target.c3-focused').classed('legend-hover', false);
		            //now check the legend for a clicked class... if we don't have it then we should remove all instances of legend-hover
		            if (!$(this).hasClass('legend-clicked')) {
		                d3.selectAll('#' + options.chartId + ' g.c3-chart-arcs g.c3-chart-arc.c3-target').classed('legend-hover', false);
		            }
		            return false;
		        });
		    }
    	}
    };
}));


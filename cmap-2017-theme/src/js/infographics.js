var infographics = infographics || {};

infographics.generate_area_stacked = function (options) {
    console.log('infographics.generate_area_stacked()');
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
            position: function (data, width, height, element) {
                var offset = $('#'+options.chartId).offset();
                var xPos = event.pageX - offset.left;
                var yPos = event.pageY - offset.top;
                return { top: yPos - 85, left: xPos };
            },
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
};


infographics.generate_bar_chart_grouped = function (options) {
    console.log('infographics.generate_bar_chart_grouped()');
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
            position: function (data, width, height, element) {
                //tracking mouse position within unique div - get offset on page.
                var offset = $('#'+options.chartID).offset();
                var xPos = event.pageX - offset.left;
                var yPos = event.pageY - offset.top;
                return { top: yPos - 85, left: xPos };
            },
            contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
                var toolTipFormat = axis_y_tick_format;
                #elseif ($y_axis_number_format.getData() == "percent")
                var toolTipFormat = d3.format(",")(d[0].value) + '%';
                #else
                var toolTipFormat = d3.format(",")(d[0].value);
                #end

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
};

infographics.generate_bar_chart_stacked = function (options) {
    console.log('infographics.generate_bar_chart_stacked()');
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
            position: function (data, width, height, element) {
                var offset = $('#'+options.chartId).offset();
                var xPos = event.pageX - offset.left;
                var yPos = event.pageY - offset.top;
                return { top: yPos - 85, left: xPos };
            },
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
};

infographics.generate_multi_line_area = function (options) {
    console.log('infographics.generate_bar_chart_stacked()');
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
        data: {
            url: options.data_url,
            type: 'line',
            types: {
                options.data_type: 'area'
            },
            x: headings[0],
            xFormat: '%Y', // 'xFormat' can be used as custom format of 'x',
        },
        color: {
            pattern: ["rgba(139, 170, 203, 0)", "rgba(60, 89, 118, 0.2)", "#00396e", "#51c0ec", "#a3ce72", "#e6b936", "#DA2128"]
        },
        legend: {
            show: false
        },
        axis: {
            x: {
                type: 'timeseries',
                padding: {
                    left: options.x_axis_padding,
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
                    position: labelPosition

                },
                tick: {
                    format: axis_y_tick_format
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
            position: function (data, width, height, element) {
                //tracking mouse position within unique div - get offset on page.
                var offset = $('#'+options.chartId).offset();
                var xPos = event.pageX - offset.left;
                var yPos = event.pageY - offset.top;
                return { top: yPos - 85, left: xPos };
            },
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
};

infographics.generate_multi_line_bar = function (options) {
    console.log('infographics.generate_multi_line_bar');
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
            position: function (data, width, height, element) {
                var offset = $('#'+options.chartId).offset();
                var xPos = event.pageX - offset.left;
                var yPos = event.pageY - offset.top;
                return { top: yPos - 85, left: xPos };
            },
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
};

infographics.generate_donut_chart = function (options) {
    console.log('infographics.generate_donut_chart');
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
                var node = d3.select('#chart.$chartID.getData() .c3-chart-arcs-title').node();
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
            // width: donutWidth,
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
};
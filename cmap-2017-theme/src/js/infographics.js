var infographics = infographics || {};

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
    	axis_y_padding = { top: options.axis_y_padding, bottom: options.axis_y_padding}
    }
    
    c3.generate({
        bindto: options.bindto,
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
                var offset = options.chart.offset();
                var xPos = event.pageX - offset.left;
                var yPos = event.pageY - offset.top;
                return { top: yPos - 85, left: xPos };
            },
            contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
                var toolTipFormat = d3.format(",")(d[0].value);

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
}

infographics.generate_multi_line_bar = function (options) {
    console.log('infographics.generate_multi_line_bar');
    var d = options.d;
    var headings = d3.keys(d[0]);
    c3.generate({
        bindto: options.bindto,
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
                var offset = options.chart.offset();
                var xPos = event.pageX - offset.left;
                var yPos = event.pageY - offset.top;
                return { top: yPos - 85, left: xPos };
            },
            contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
                if (color(d[0]) != "rgba(60, 89, 118, 0.2)") {
                    return "<div id='Tooltip'><div class='tooltip-circle' style='background-color:"
                        + color(d[0]) + ";'></div> <p class='tooltip-text'><b>"
                        + d[0].name + "</b><br />" + d3.format(",")(d[0].value) + "<br/>"
                        + defaultTitleFormat(d[0].x) + "</p></div>";
                }
                else {
                    return "<div id='Tooltip'><div class='tooltip-circle' style='background-color:#7992a6;'></div> <p class='tooltip-text'><b>"
                        + d[0].name + "</b><br />" + d3.format(",")(d[0].value) + "<br/>"
                        + defaultTitleFormat(d[0].x) + "</p></div>";
                }
            },
            grouped: false
        }
    });
}

infographics.generate_donut_chart = function (options) {
    console.log('infographics.generate_donut_chart');

    var d = options.d;
    var chart = c3.generate({
        bindto: options.bindto,
        data: {
            //the file variable goes here.
            url: options.data_url,
            order: [d3.keys(d[0])],
            type: 'donut',
            columns: [d3.keys(d[0])],
            // onmouseover: function (d) {
            //     d3.select('#chart.$chartID.getData() .c3-chart-arcs-title').node().innerHTML = "<tspan>" + d.value + "</tspan><tspan class='upper' x='-1' y='25'>" + d.id + "</tspan>";
            // }
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
            position: function (data, width, height, element) {
                var offset = options.chart.offset();
                var xPos = event.pageX - offset.left;
                var yPos = event.pageY - offset.top;
                return { top: yPos - 85, left: xPos };
            },
            contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
                return "<div id='Tooltip'><div class='tooltip-circle' style='background-color:"
                    + color(d[0]) + ";'></div><p class='tooltip-text'><b>" + d[0].name + "</b><br />" + d3.format(".1%f")(d[0].ratio) + "<br/></p></div>";
            },
            grouped: false
        },
        legend: {
            show: false
        }
    });
};
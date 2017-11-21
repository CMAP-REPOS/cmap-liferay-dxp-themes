
<h1>Decoding Property Taxes and Classification</h1>
<p>As recommended by the GO TO 2040 comprehensive regional plan and reinforced by the Regional Tax Policy Task Force, CMAP is studying how the property tax assessment classification in the region may impede business development and economic activity.</p>
<p>To understand why classification matters, first let&#39;s look at how property tax rates are determined, what the taxes pay for, and which government units get the revenue.</p>
<p><strong>About this two-part issue brief</strong><br />

<div class="bg-container">




Property taxes are among the policies that CMAP is evaluating after a regional task force on state and local tax policy submitted an advisory report to the CMAP Board. The <a href="./decoding-property-taxes">first </a>in this two-part issue brief explains how property taxes are determined throughout the region, providing details of how property taxes pay for services delivered by particular units of government.&nbsp; The <a href="./cook-property-tax-classification">second</a> highlights how phasing out this system could make established communities more attractive for redevelopment and infill of vacant or underutilized land.</p>
</div>

<p>&nbsp;</p>

<p>&nbsp;</p>
<link href="/documents/10180/58937/jquery.jqplot.min.css/5a789c7e-bf47-4885-8346-fa93def24c41" rel="stylesheet" type="text/css" /><!-- excanvas.min.js --><!--[if lt IE 9]><script language="javascript" type="text/javascript" src="/documents/10180/58937/excanvas.min.js/19e27fe9-f57f-45d5-a3cf-12391fd05063"></script><![endif]--><!-- jquery.qtip-1.0.0-rc3.min.js --><script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.1.1/jquery.qtip.min.js"></script><!-- jquery-backgroundfader.js --><script type="text/javascript" src="/documents/10180/58937/jquery-backgroundfader.js/b1b59372-4467-49e3-b5d1-c70a943914e8"></script><!-- jquery.jqplot.min.js --><script type="text/javascript" src="/documents/10180/58937/jquery.jqplot.min.js/6ab0b4e6-56e9-415d-a49a-ad2cfee9e7bf"></script><!-- jqplot.donutRenderer.js --><script type="text/javascript" src="/documents/10180/58937/jqplot.donutRenderer.js/59f0d351-7a84-4156-8eee-6bbf520a93d9"></script><script type="text/javascript">
$(document).ready(function () { /* Graph data values tweaked to ensure graph visibility; not numerically accurate. Dollar amounts indicated are accurate. */
    var a = [
        ["<strong>School Districts</strong><br />$11,542,501,149", 58557],
        ["<strong>Municipalities</strong><br />$2,709,250,772", 13744],
        ["<strong>Counties</strong><br />$1,187,211,843", 6023],
        ["<strong>Tax Increment<br />Financing (TIF) Districts</strong><br />$963,349,323", 4887],
        ["<strong>Park Districts</strong><br />$839,365,303", 4258],
        ["<strong>Community<br />College Districts</strong><br />$659,695,498", 3347],
        ["<strong>Sanitary and Water<br />Reclamation Districts</strong><br />$474,138,033", 2405],
        ["<strong>Fire Protection and<br />Rescue Squad Districts</strong><br />$431,351,108", 2188],
        ["<strong>Townships</strong><br />$341,754,058", 1734],
        ["<strong>Forest Preserve<br />Districts</strong><br />$285,404,608", 1448],
        ["<strong>Library Districts</strong><br />$255,616,907", 1297],
        ["<strong>Other</strong><br />$22,053,399", 650]
    ];
    var b = $.jqplot("chart", [a], {
        seriesColors: ["#ccccff", "#ccccff", "#ccccff", "#ccccff", "#ccccff", "#ccccff", "#ccccff", "#ccccff", "#ccccff", "#ccccff", "#ccccff", "#ccccff"],
        seriesDefaults: {
            renderer: $.jqplot.DonutRenderer,
            rendererOptions: {
                diameter: 425,
                thickness: 97,
                sliceMargin: 1,
                padding: 0,
                startAngle: 270,
                shadowOffset: 0,
                showDataLabels: false
            }
        },
        gridPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0
        },
        grid: {
            background: "rgba(0,0,0,0.0)",
            drawBorder: false,
            borderWidth: 1,
            shadow: false,
            shadowOffset: 0,
            shadowDepth: 0,
            renderer: $.jqplot.CanvasGridRenderer,
            rendererOptions: {}
        }
    });
	var currentMousePos = { x: -1, y: -1 };
	var currentTooltip = null;
    $(document).mousemove(function(event) {
        currentMousePos.x = event.pageX;
        currentMousePos.y = event.pageY;
		if (currentTooltip != null) {
			currentTooltip.css({"top": (currentMousePos.y-(currentTooltip.height()+40))+'px', "left": currentMousePos.x+'px'});
		}
    });

    $("#chart").bind("jqplotDataUnhighlight", function (f, c, e, g) {
        try {
			currentTooltip = null;
            $("#preso_three a#chart_anchor").tooltip("destroy")
        } catch (d) {}
    });
    $("#chart").bind("jqplotDataHighlight", function (f, c, e, h) {
        try {
			currentTooltip = null;
            $("#preso_three a#chart_anchor").tooltip("destroy")
        } catch (d) {}
		var g = $("#preso_three a#chart_anchor").tooltip({
		  track: true,
		  position: {
			collision: 'none',
			my: "left bottom-40",
			at: "left top",
			using: function( position, feedback ) {
			  $(this).css({"top": (currentMousePos.y-($(this).height()+40))+'px', "left": currentMousePos.x+'px'});
			  currentTooltip = $(this);
			  $( "<div>" )
				.addClass( "arrow" )
				.addClass( feedback.vertical )
				.addClass( feedback.horizontal )
				.appendTo( this );
			}
		 },
		 content: function() {
			return h[0];
		 }
		});
		$("#preso_three a#chart_anchor").tooltip('open');		
		/*
        var g = $("#preso_three").qtip({
            content: {
                text: h[0]
            },
            show: {
                ready: true
            },
            hide: {
                fixed: true
            },
            position: {
                target: "mouse",
                corner: {
                    target: "topRight",
                    tooltip: "bottomLeft"
                },
                adjust: {
                    x: 5,
                    y: -5
                }
            },
            style: {
                padding: 8,
                textAlign: "left",
                background: "#fff",
                color: "black",
                border: {
                    width: 0,
                    radius: 0,
                    color: "#fff"
                },
                tip: "bottomLeft",
                name: "light"
            },
            api: {
                onContentUpdate: function () {
                    this.show();
                    this.updatePosition()
                }
            }
        })
		*/
    })
});
(function (a) {
    a.fn.preso = function (c) {
        var d = a.extend({
            mouseover: null,
            mouseout: null,
            select: null,
            unselect: null
        }, c);
        var b = this;
        this.find("ul.preso-nav").each(function (f, g) {
            var h = a(this);
            h.siblings('div:gt(0)').css({
                visibility: 'hidden'
            }).hide();
            var e = h.siblings("ul.preso-comment").children("li");
            e.hide();
            h.children("li.item").each(function (i, j) {
                var k = a(j);
                if (i == 0) {
                    k.addClass("selected");
                    if (k.attr("comment")) {
                        e.eq(k.attr("comment")).show()
                    }
                }
                if (d.mouseover) {
                    k.mouseover(function () {
                        d.mouseover(this)
                    })
                }
                if (d.mouseout) {
                    k.mouseout(function () {
                        d.mouseout(this)
                    })
                }
                k.click(function () {
                    var m = a(this);
                    var l = m.siblings(".selected");
                    l.removeClass("selected");
                    if (d.unselect) {
                        d.unselect(l)
                    }
                    m.addClass("selected");
                    if (d.select) {
                        d.select(m)
                    }
                    h.siblings("ul.preso-comment").children("li:visible").hide();
                    if (m.attr("comment")) {
                        h.siblings("ul.preso-comment").children("li").eq(m.attr("comment")).show()
                    }
                    var n = h.siblings("div:eq(" + i + ")");
                    /*n.siblings("div:visible").fadeOut(function () {
                        $(this).css({
                            visibility: 'hidden'
                        });
                    });
                    n.css({
                        visibility: 'visible'
                    }).fadeIn();*/
					n.siblings("div:visible").css({
                        visibility: 'hidden'
                    }).hide();
                    n.css({
                        visibility: 'visible'
                    }).show();
                    return false
                })
            })
        })
    }
})(jQuery);
(function (b) {
    if (!document.defaultView || !document.defaultView.getComputedStyle) {
        var d = jQuery.css;
        jQuery.css = function (g, e, h) {
            if (e === "background-position") {
                e = "backgroundPosition"
            }
            if (e !== "backgroundPosition" || !g.currentStyle || g.currentStyle[e]) {
                return d.apply(this, arguments)
            }
            var f = g.style;
            if (!h && f && f[e]) {
                return f[e]
            }
            return d(g, "backgroundPositionX", h) + " " + d(g, "backgroundPositionY", h)
        }
    }
    var c = b.fn.animate;
    b.fn.animate = function (e) {
        if ("background-position" in e) {
            e.backgroundPosition = e["background-position"];
            delete e["background-position"]
        }
        if ("backgroundPosition" in e) {
            e.backgroundPosition = "(" + e.backgroundPosition + ")"
        }
        return c.apply(this, arguments)
    };

    function a(f) {
        f = f.replace(/left|top/g, "0px");
        f = f.replace(/right|bottom/g, "100%");
        f = f.replace(/([0-9\.]+)(\s|\)|$)/g, "$1px$2");
        var e = f.match(/(-?[0-9\.]+)(px|\%|em|pt)\s(-?[0-9\.]+)(px|\%|em|pt)/);
        return [parseFloat(e[1], 10), e[2], parseFloat(e[3], 10), e[4]]
    }
    b.fx.step.backgroundPosition = function (f) {
        if (!f.bgPosReady) {
            var h = b.css(f.elem, "backgroundPosition");
            if (!h) {
                h = "0px 0px"
            }
            h = a(h);
            f.start = [h[0], h[2]];
            var e = a(f.end);
            f.end = [e[0], e[2]];
            f.unit = [e[1], e[3]];
            f.bgPosReady = true
        }
        var g = [];
        g[0] = ((f.end[0] - f.start[0]) * f.pos) + f.start[0] + f.unit[0];
        g[1] = ((f.end[1] - f.start[1]) * f.pos) + f.start[1] + f.unit[1];
        f.elem.style.backgroundPosition = g[0] + " " + g[1]
    }
})(jQuery);
$(function () {
    $(".preso").preso({
        unselect: function (a) {
            if ($(a).parent().parent().hasClass("preso")) {
                $(a).stop().animate({
                    backgroundPosition: "-102px 15px"
                }, {
                    duration: 250
                })
            }
        },
        mouseover: function (a) {
            if ($(a).parent().parent().hasClass("preso") && !$(a).hasClass("selected")) {
                $(a).stop().animate({
                    backgroundPosition: "58px 15px"
                }, {
                    duration: 250
                })
            }
        },
        mouseout: function (a) {
            if ($(a).parent().parent().hasClass("preso") && !$(a).hasClass("selected")) {
                $(a).stop().animate({
                    backgroundPosition: "-102px 15px"
                }, {
                    duration: 250
                })
            }
        },
        select: function (c) {
            if ($(c).parent().hasClass("counties")) {
                var b = $(c);
                var d = b.prevAll("li.item").length;
                var a = b.parent().parent().prevAll("div").length;
                $("#preso_one>div").eq(a).siblings().each(function (e, f) {
                    $(f).find("ul.counties li.item").each(function (g, h) {
                        if (g == d) {
                            $(h).addClass("selected")
                        } else {
                            $(h).removeClass("selected")
                        }
                    });
                    $(f).children("div").css({
                        visibility: 'hidden'
                    }).hide();
                    $(f).children("div").eq(d).css({
                        visibility: 'visible'
                    }).show()
                });
                $("ul.counties li").removeAttr("recurse")
            }
        }
    });
    $("#preso_two #preso_grid_container ul li[title]").tooltip({
      track: true,
	  position: {
	    collision: 'none',
        my: "left bottom-40",
        at: "left top",
        using: function( position, feedback ) {
          $( this ).css( position );
          $( "<div>" )
            .addClass( "arrow" )
            .addClass( feedback.vertical )
            .addClass( feedback.horizontal )
            .appendTo( this );
        }
	 },
	 content: function() {
        var element = $( this );
        return element.attr( "title" );
     }
    });

    $("#more_info").hide();
    $("#more_info_head").click(function () {
        var a = $(this);
        a.toggleClass("closed");
        a.next("#more_info").slideToggle(600);
        $("html, body").animate({
            scrollTop: $(document).height()
        }, 600)
    })
});
</script>
<style type="text/css">.ui-tooltip, .arrow:after {
     background: none repeat scroll 0% 0% #FFFFFF;
}

body .ui-tooltip {
     box-shadow: 0px 0px 7px black;
     color: #000000;
     font-family: "freight-micro-pro",serif;
     padding: 10px 20px;
     position: absolute;
     width: auto;
     z-index: 9999;
	 border-width: 0 !important;
}

.arrow {
     bottom: -16px;
     height: 16px;
     left: 0px;
     overflow: hidden;
     position: absolute;
     width: 70px;
}

.arrow.top {
     bottom: auto;
     top: -16px;
}

.arrow.left {

}

.arrow:after {
     content: "";
     height: 25px;
     left: -13px;
     position: absolute;
     top: -20px;
     /*box-shadow: -6px 5px 9px -9px black;*/
    -webkit-transform: rotate(45deg);
    -moz-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    -o-transform: rotate(45deg);
    transform: rotate(45deg);
     width: 25px;
}

.arrow.top:after {
     bottom: -20px;
     top: auto;
}
</style>
<style type="text/css">/*.main-content > .row-fluid {
	background:url(/documents/10180/58937/preso_bg.png/fba00686-d6c2-4859-ac72-9a9aa60165ee?t=1380743229732) repeat-x scroll 0 0 #FFF;
}*/
div.bg-container {background: #ffffff; /* Old browsers */
/* IE9 SVG, needs conditional override of 'filter' to 'none' */
background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIxMDAlIiB5Mj0iMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2ZmZmZmZiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiM3ZGI5ZTgiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
background: -moz-linear-gradient(left,  #ffffff 0%, #BBDBED 100%); /* FF3.6+ */
background: -webkit-gradient(linear, left top, right top, color-stop(0%,#ffffff), color-stop(100%,#BBDBED)); /* Chrome,Safari4+ */
background: -webkit-linear-gradient(left,  #ffffff 0%,#BBDBED 100%); /* Chrome10+,Safari5.1+ */
background: -o-linear-gradient(left,  #ffffff 0%,#BBDBED 100%); /* Opera 11.10+ */
background: -ms-linear-gradient(left,  #ffffff 0%,#BBDBED 100%); /* IE10+ */
background: linear-gradient(to right,  #ffffff 0%,#BBDBED 100%); /* W3C */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#BBDBED',GradientType=1 ); /* IE6-8 */
padding-bottom: 1.5em;
position: relative;
}
div.bg-extender {
background-color: #BBDBED; position: absolute; top: 0; height: 100%; left: 100%; width: 1000px;
}
.signed-out div.bg-container {
margin-top: -1000px;
padding-top: 1000px
}
div.bg-container>div:first-child{padding-top: 20px}
div.preso-container {margin-top: 200px; position: relative}
ul.preso-nav li.last a{border:none!important;}
ul.preso-nav.main{margin-left: -90px !important}
ul.preso-nav.main,ul.preso-comment{margin:0;padding-left:0;}
ul.preso-comment{margin-top:-200px;position:absolute;margin-left: 0 !important}
ul.preso-nav.main li{background:url(/documents/10180/58937/arrow.png/a491e765-50c2-40a7-9472-a18e0a038031?t=1380742444640) no-repeat -102px 11px;}
ul.preso-nav.main li,ul.preso-nav.dots li,ul.preso-nav.counties li{font-family:"tk-freight-sans-pro","freight-sans-pro";letter-spacing: 0.1em;font-size:12px;font-weight:bold;text-transform:uppercase;margin:0;}

ul.preso-nav.main li.selected{background-position:58px 15px;}
ul.preso-nav.main li a,ul.preso-nav.counties li a{display:block;margin-left:90px;line-height:3}
ul.preso-nav li,ul.preso-comment li{margin-left:0;padding-left:0;list-style-type:none;line-height: 1.5}
ul.preso-nav li a{text-decoration:none;color:#afbfb5;border-bottom:1px solid #afbfb5;}
ul.preso-nav li a:active,ul.preso-nav li a:hover,ul.preso-nav li.selected a{color:#000;}ul.preso-nav.dots{padding:0;margin:0;}
ul.preso-nav.dots {position: relative;margin: auto; width: 66%}
ul.preso-nav.dots li{display:block;}
ul.preso-nav.dots li.middle{position: absolute; margin: auto 50%; left: -12px;}
ul.preso-nav.dots li.first {position: absolute}
ul.preso-nav.dots li{background:url(/documents/10180/58937/dots.png/fa4780d3-d532-4c46-9f04-42764c0e67d8?t=1380741578000) no-repeat -100px -100px;text-align:center;height:24px;}
ul.preso-nav.dots li a {
    background: url("/documents/10180/58937/dots.png/fa4780d3-d532-4c46-9f04-42764c0e67d8?t=1380741578000") no-repeat scroll 0 0 transparent;
    border: medium none;
    color: #AFBFB5;
    display: block;
    font-size: 11px;
    height: 24px;
    line-height: 23px;
    margin: 0;
    padding-left: 1px;
    text-align: center;
    width: 24px;
}

.mac ul.preso-nav.dots li a {line-height: 24px}

ul.preso-nav.dots li a:hover,ul.preso-nav.dots li.selected a{color:#fff;}ul.preso-nav.dots li div{background-image:url(/documents/10180/58937/dots.png/fa4780d3-d532-4c46-9f04-42764c0e67d8?t=1380741578000);background-repeat:no-repeat;background-position:-24px 0;background-color:#fff;}ul.preso-nav.dots li.selected div{background-position:0 0;}
ul.preso-nav.counties {
    position: relative;
	margin-top: 2em
}
ul.preso-nav.counties li a,ul.preso-nav.counties li span{margin-left:105px;}ul.preso-nav.counties li span{border-bottom:1px solid #afbfb5;line-height:40px;color:#f47932;display:block;}ul.preso-nav.counties li img{position:absolute;top:16px;visibility:hidden;left: 0}ul.preso-nav.counties li.selected img{visibility:visible;}
#preso_one{margin-top:220px;}
#preso_one>div>img{height:336px;width:842px;}#preso_one>div{padding-top:40px;}
#preso_two{min-height:520px;}
#preso_two .preso-comment, #preso_three .preso-comment {margin-top: 1.5em; position: relative}
#preso_two #preso_grid_container{width: 66%;}
#preso_two #preso_grid_container ul{margin-left:0;padding-left:0;}
#preso_two #preso_grid_container ul li{
position:absolute;z-index: 0;margin-left:0;padding-left:0;list-style-type:none;margin:0;padding:0;}#preso_two #preso_grid_container ul li a{display:block;}#preso_two #preso_grid_container ul li a img{cursor:default}#preso_two #preso_grid_container ul li div{background-color:#c00;}#preso_three{min-height:620px;}
#preso_one>.pane {width: 66%; margin: auto}
#preso_three #chart{margin: auto }

#content-footer{background: url(/documents/10180/58937/image_gallery%2821%29.png/221a1d5a-2cc6-4b4b-ad7f-e63c73a79aa1?t=1379348534000) no-repeat right 32px}
#content-footer>div {margin-top: -8px;
}
#content-footer>div:last-child {
	padding-top: 382px;
}
.portlet-journal-content .icons-container{float: right}
</style>
<div class="preso">
<ul class="preso-nav main">
	<li class="item"><a href="#">how do tax rates get determined?</a></li>
	<li class="item"><a href="#">what services do property taxes pay for?</a></li>
	<li class="item last"><a href="#">which government units get the revenue?</a></li>
</ul>

<div id="preso_one">
<ul class="preso-nav dots">
	<li class="item first" comment="0"><a href="#">1</a></li>
	<li class="item middle" comment="1"><a href="#">2</a></li>
	<li class="item pull-right" comment="2"><a href="#" style="float: right">3</a></li>
</ul>

<ul class="preso-comment">
	<li>
	<p><strong>Units of government propose their tax levies</strong><br />
	The vast majority of local governments in northeastern Illinois impose a property tax. Each taxing district decides how much revenue it needs from property taxes for its budget and then certifies that amount &mdash; known as a <em>levy</em> &mdash; to the county clerk.</p>

	<p><strong>Click on the numbers below to learn more</strong></p>
	</li>
	<li>
	<p><strong>Property values are assessed and equalized</strong><br />
	Counties calculate each district&#39;s tax base using the equation below, minus any exemptions. The State of Illinois requires smaller counties to assess all property at the same percentage of market value. More-populous counties such as Cook may choose to apply ratios that vary depending on the class of property (such as residential, industrial, or commercial). In Cook, residential property is assessed at a lower percentage of market value than commercial and industrial property. <em>E = equalization factor</em>. <a href="#bottom">Learn more</a></p>
	</li>
	<li>
	<p><strong>Tax rates are calculated</strong><br />
	Using the equation below, the clerk sets a property tax rate that will generate revenues necessary to meet the district&#39;s levy request. This rate is subject to adjustments based on rate limits and extension caps. The relationship between property tax extensions and tax bases leads to different property tax rates throughout the region. Relatively high property values typically allow local governments to maintain lower property tax rates compared to areas with smaller tax bases.</p>
	</li>
</ul>

<div class="pane">
<div class="pane"><!-- 1_1_cc.png --><img src="/documents/10180/58937/image_gallery%285%29.png/3c5ed35d-c701-48d8-a3d8-4083872725de?t=1379348534761" /></div>

<div class="pane"><!-- 1_1_oc.png --><img src="/documents/10180/58937/image_gallery%286%29.png/e5fe2106-078e-4da0-be6e-dd4ee295fd4d?t=1379348534943" /></div>

<ul class="preso-nav counties">
	<li class="label"><span>Show Formulas For</span></li>
	<li class="item"><!-- 1_map_cc.png --><img src="/documents/10180/58937/image_gallery%287%29.png/33412d8f-f756-4194-bce1-41f718c0274a?t=1379348535726" /><a href="#">Cook County</a></li>
	<li class="item last"><!-- 1_map_oc.png --><img src="/documents/10180/58937/image_gallery%288%29.png/3fab26a6-ce7c-4206-856b-608e297f63a3?t=1379348535909" /><a href="#">Other Counties</a></li>
</ul>
</div>

<div class="pane">
<div class="pane"><!-- 1_2_cc.png --><img src="/documents/10180/58937/image_gallery%289%29.png/0c29a33a-06e6-446a-8986-a168ceef530a?t=1379348536086" /></div>

<div class="pane"><!-- 1_2_oc.png --><img src="/documents/10180/58937/image_gallery%2810%29.png/d8d08cf2-59df-4873-b648-20dd68c01c32?t=1379348532695" /></div>

<ul class="preso-nav counties">
	<li class="label"><span>Show Formulas For</span></li>
	<li class="item"><!-- 1_map_cc.png --><img src="/documents/10180/58937/image_gallery%287%29.png/33412d8f-f756-4194-bce1-41f718c0274a?t=1379348535726" /><a href="#">Cook County</a></li>
	<li class="item last"><!-- 1_map_oc.png --><img src="/documents/10180/58937/image_gallery%288%29.png/3fab26a6-ce7c-4206-856b-608e297f63a3?t=1379348535909" /><a href="#">Other Counties</a></li>
</ul>
</div>

<div class="pane">
<div class="pane"><!-- 1_3_cc.png --><img src="/documents/10180/58937/image_gallery%2811%29.png/6d91f20e-de87-46b9-acb9-ae572cd7ccfe?t=1379348532000" /></div>

<div class="pane"><!-- 1_3_oc.png --><img src="/documents/10180/58937/image_gallery%2812%29.png/004d91df-619b-4c89-9d94-6d5e79f7e97f?t=1379348533000" /></div>

<ul class="preso-nav counties">
	<li class="label"><span>Show Formulas For</span></li>
	<li class="item"><!-- 1_map_cc.png --><img src="/documents/10180/58937/image_gallery%287%29.png/33412d8f-f756-4194-bce1-41f718c0274a?t=1379348535726" /><a href="#">Cook County</a></li>
	<li class="item last"><!-- 1_map_oc.png --><img src="/documents/10180/58937/image_gallery%288%29.png/3fab26a6-ce7c-4206-856b-608e297f63a3?t=1379348535909" /><a href="#">Other Counties</a></li>
</ul>
</div>
</div>

<div id="preso_two">
<ul class="preso-comment">
	<li>
	<p>Assuming a well-designed system, the property tax is an effective and efficient means of raising local revenues. Its virtues include the stability of revenue, the ease of administering the tax (which contributes to compliance), and the intrinsic connection between the source of the revenue (property) and what is being provided in return (public services). Note: The size of each square represents its amount of expenditures relative to other service types.</p>
	</li>
</ul>

<div id="preso_grid_container" style="position: relative">
<ul>
	<li id="lawenf" style="background-color: #000000;top: 150px;left:0" title="&lt;strong&gt;Public Safety&lt;/strong&gt;"><!-- 2_icon_lawenf.png --><a href="#" style="background-color: #bb8632;width:149px;height:149px"><img src="/documents/10180/58937/image_gallery%2813%29.png/d072ead6-87e8-4eff-8a2c-d44faf14b4f1?t=1379348533000" /></a></li>
	<li id="refuse" style="background-color: #000000;top:299px;left:75px" title="&lt;strong&gt;Waste&lt;br /&gt;Management&lt;/strong&gt;"><!-- 2_icon_refuse.png --><a href="#" style="background-color: #005421;width:74px;height:74px"><img src="/documents/10180/58937/image_gallery%2814%29.png/f8a5b51b-38b3-4393-8b04-36afe4905756?t=1379348533000" /></a></li>
	<li id="education" style="background-color: #000000;top:150px;left:149px" title="&lt;strong&gt;Education&lt;/strong&gt;"><!-- 2_icon_education.png --><a href="#" style="background-color: #32bbed;width:246px;height:246px"><img src="/documents/10180/58937/image_gallery%2815%29.png/11003943-a6b5-4b9c-9464-d977a4692931?t=1379348533000" /></a></li>
	<li id="libraries" style="background-color: #000000;top:76px;left:247px" title="&lt;strong&gt;Libraries&lt;/strong&gt;"><!-- 2_icon_libraries.png --><a href="#" style="background-color: #ac311b;width:74px;height:74px"><img src="/documents/10180/58937/image_gallery%2816%29.png/59680baf-d0f0-4320-a628-0747ed2efdd8?t=1379348533000" /></a></li>
	<li id="nature" style="background-color: #000000;top:76px;left:321px" title="&lt;strong&gt;Parks and&lt;br /&gt;Recreation&lt;/strong&gt;"><!-- 2_icon_nature.png --><a href="#" style="background-color: #905a00;width:74px;height:74px"><img src="/documents/10180/58937/image_gallery%2817%29.png/6014c4bf-19fb-4fd9-afa8-9c38520498ff?t=1379348533000" /></a></li>
	<li id="government" style="background-color: #000000;top:1px;left:395px" title="&lt;strong&gt;General and Financial&lt;br /&gt; Administration&lt;/strong&gt;"><!-- 2_icon_govt.png --><a href="#" style="background-color: #00508b;width:149px;height:149px"><img src="/documents/10180/58937/image_gallery%2818%29.png/8337c9c3-e349-45f8-acc6-d0b842eadf70?t=1379348534000" /></a></li>
	<li id="transportation" style="background-color: #000000;top:150px;left:544px" title="&lt;strong&gt;Transportation&lt;br /&gt;and Public Works&lt;/strong&gt;"><!-- 2_icon_transport.png --><a href="#" style="background-color: #6cad4e;width:149px;height:149px"><img src="/documents/10180/58937/image_gallery%2819%29.png/a35a0e96-0d29-4f1e-85da-024f48e6a55a?t=1379348534000" /></a></li>
	<li id="family" style="background-color: #000000;top:76px;left:693px" title="&lt;strong&gt;Social&lt;br /&gt;Services&lt;/strong&gt;"><!-- 2_icon_family.png --><a href="#" style="background-color: #ac311b;width:74px;height:74px"><img src="/documents/10180/58937/image_gallery%2820%29.png/43b420cc-ff31-4390-be04-5779675798a0?t=1379348534000" /></a></li>
</ul>
</div>
</div>

<div id="preso_three">
<ul class="preso-comment">
	<li>
	<p>The vast majority of local governments in our region levy a property tax. At nearly $20 billion annually, it is the region&#39;s largest revenue source for local units of government. Variations in property tax base across the region influence units of government&#39;s relative ability to generate revenues needed to provide public services. While some governments, such as counties and municipalities, generate revenues from diverse sources, many special districts and townships must rely on property tax revenues to pay for nearly all services. <a href="#bottom">Learn more</a></p>
	</li>
</ul>
<!-- 3_graph_bg.png -->

<div id="chart" style="height:425px; width:425px;background: url(/documents/10180/58937/image_gallery%2822%29.png/081ea34d-1daf-4cac-83a4-8885b1518ff8?t=1379350622479) no-repeat center center;"><a href="#" id="chart_anchor" onclick="return false;" title="temp">&nbsp;</a></div>
</div>
</div>

<div class="bg-extender">&nbsp;</div>

<h2>Why property tax assessment classification matters</h2>

<p>Cook County is the only Illinois county that assesses commercial and industrial properties at a percentage of market value higher than residential properties&#39; percentage. As a result, businesses in Cook shoulder more of the property tax burden than residents do (although the magnitude of this impact varies from place to place).</p>

<p>This disproportionate burden does not exist in the collar counties, where businesses and residents with similar property values typically share similar tax burdens.</p>

<p class="callout">The higher tax burden on businesses in Cook County creates a discontinuity in taxation within the region, which impedes implementation of GO TO 2040 recommendations for redevelopment of infill land to strengthen existing communities.</p>

<p>Eliminating classification would reduce commercial and industrial property tax rates in many communities, where the availability of existing infrastructure and land for infill would make them attractive for development.</p>

<p>Lower property tax rates for businesses in Cook would help the county &mdash; especially its border communities &mdash; compete more effectively for economic development opportunities.</p>

<p>While gradually eliminating the classification system would increase residential property owners&#39; tax burden over time, this effect would be mitigated if the business property tax base grows due to greater economic development.</p>

<p>Keeping the current system would be a recipe for low growth of Cook County&#39;s property tax base, putting a greater tax burden on both residents and businesses.</p>

<p><img src="/documents/10180/58937/image_gallery%2821%29.png/221a1d5a-2cc6-4b4b-ad7f-e63c73a79aa1?t=1379348534000" style="float: right" /> <strong>Imagine this scenario</strong><br />
Suppose a business owner is deciding between purchasing two commercial properties with identical market value ($500,000) but drastically different property tax rates &mdash; one in Village A, and the other in Village B.</p>

<p>Village A is located in Cook County, and Village B is located in a different county of northeastern Illinois.</p>

<p>Both villages have the same total property tax levy ($1 million), the same aggregate market value across all taxable properties ($100 million), and the same mix of residential, commercial, and industrial properties.</p>

<p>However, Village A&#39;s property has a higher tax rate than the property in Village B due to the property tax classification system in Cook County.</p>

<h2>About Assessment and Equalization</h2>

<p>Because the property tax base determines state funding for school districts, among other calculations, it is important to &quot;equalize&quot; property values to avoid under- and over-assessment. The Illinois Department of Revenue (IDOR) equalizes assessments so the <em>median level</em> of assessment across counties within the state, including Cook County, is at the same level as determined by statute. IDOR determines an equalization factor that counties apply to each assessed property value. Among the few counties that receive an equalization factor, most adjust their assessments by only a minor amount. Because no Cook properties are assessed at the statutorily determined level, IDOR usually issues a large multiplier for Cook to significantly modify its assessments. In addition to residential, commercial, and industrial properties, the tax base also includes mineral property, as well as property types not subject to equalization such as farm and railroad properties.</p>

<h2>About Methodology</h2>

<p>Service costs were derived from 2010 Illinois Office of the Comptroller data.</p>

<p>Property tax revenues by unit of government were derived from Illinois Department of Revenue data for the 2009 tax year.</p>

<p>&quot;Imagine this scenario&quot; is based on a hypothetical taxing district, &quot;Taxing District 2,&quot; described on page 62 of the Regional Tax Policy Task Force <a href="/documents/10180/58937/FY12-0069+REGIONAL+POLICY+TASK+FORCE+REPORT+lowres.pdf/027da165-6d80-4cdd-81c5-ff37a9249d45">advisory report</a>. The numbers were proportionately increased to represent a property tax bill, which is made up of several taxing districts.</p>

<h2>About Taxing Districts</h2>

<p>Municipalities, Counties, and Townships include extensions for Special Service Areas.</p>

<p>&quot;Other&quot; includes Airport Authority, Mosquito Abatement, Cemetery, Public Health, River Conservancy, Surface Water Protection, Solid Waste Disposal, Street Lighting, and Water Service districts.</p>

<p><a name="bottom"></a></p>

<h2>About the Regional Tax Policy Task Force</h2>

<p>As part of its recommendations for <a href="http://www.cmap.illinois.gov/2040/efficient-governance">efficient governance</a>, the GO TO 2040 comprehensive regional plan called for the creation of a <a href="http://www.cmap.illinois.gov/regional-tax-policy-task-force">Regional Tax Policy Task Force</a>, which subsequently worked throughout 2011 to prepare its <a href="/documents/10180/58937/FY12-0069+REGIONAL+POLICY+TASK+FORCE+REPORT+lowres.pdf/027da165-6d80-4cdd-81c5-ff37a9249d45">advisory report</a> for consideration by the CMAP Board. The task force&#39;s charge, as defined by GO TO 2040, was to advise the Board by:</p>

<p style="color: #000">&quot;...addressing issues central to state and local fiscal policy, viewed through the lens of the regional economy, sustainability, equity, and the connections between tax policy and development decisions.&quot;</p>

<p>Concerned about the degree to which commercial and industrial properties are subject to high property tax rates in many Cook County communities as result of property tax assessment classification, the Regional Tax Policy Task Force recommended phasing out this regional inconsistency over a period of years to help residential taxpayers adjust to the increased burden.</p>


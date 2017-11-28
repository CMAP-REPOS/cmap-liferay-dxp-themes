<%@ include file="/init.jsp" %>

<%
boolean notConfigured = Validator.isNull(assetCategoryId) || 
	"0".equals(assetCategoryId) || 
	Validator.isNull(assetCount) || 
	"0".equals(assetCount);
%>

<c:choose>
	<c:when test="<%= notConfigured %>">
		This Updates Slider is not configured yet. Please select "Configuration" from the widget menu.
	</c:when>
	<c:otherwise>
	<section class="update-slider slider" id="<%=themeDisplay.getPortletDisplay().getId() %>">
		<header class="row">
			<div
				class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
				<div class="buttons">
					<h3>Updates</h3>
					<div class="view-all">
						<a href="/updates/all/-/categories/<%=assetCategoryId %>">View all</a>
					</div>
				</div>
			</div>
		</header>
		<div class="slider-container">
	 		<c:forEach var="assetModel" items="${assetModels}">
			<div class="item col-xl-4 col-sm-8 col-xs-16">
				<h4 class="item-date">${assetModel.getDate()}</h4>
				<h3 class="item-title">
					<a href="${assetModel.getLink()}">${assetModel.getTitle()}</a>
				</h3>
				<p class="item-description">${assetModel.getSummary()}</p>
				<a class="read-more-link"
					href="${assetModel.getLink()}">
					Read more <span class="sr-only">about ${assetModel.getTitle()}</span></a>
			</div>
			</c:forEach>
		</div>
	</section>
	</c:otherwise>
</c:choose>

<script>
$(document).ready(function(){
	var $this = $('#<%=themeDisplay.getPortletDisplay().getId() %>');
	var $container = $this.find('.slider-container');
	var $spacer = $('<div class="col-xl-4"></div>');
	var $row = $('<div class="row"></div>');
	var $nav = $('<nav class="slider-nav"></nav>');

	var items = $container.find('.item');

	function addItem(dom){
		var $node = $(dom);
		if($node){
			$node.remove();
			$row.append($node);
		} else {
			$row.append($spacer.clone());
		}
	}
	for(let i=0; i<Math.ceil(items.length / 4); i++){
		// create row
		addItem(items[(i*4)]);
		addItem(items[(i*4)+1]);
		addItem(items[(i*4)+2]);
		addItem(items[(i*4)+3]);

		var $slide = $(`<div class="slider-slide"></div>`);
		var $navItem = $('<div class="nav-item"></div>');
		if(i===0){ $navItem.addClass('active'); }

		$navItem.click(function(){
			$container.css('transform', 'translateX(-'+(i*100)+'%)');
      $nav.find('.nav-item.active').removeClass('active');
			$(this).addClass('active');
		});

		$nav.append($navItem);
		$slide.append($row);
		$container.append($slide);

		// reset
		$row = $('<div class="row"></div>');
	}
	$this.append($nav);
});

</script>

<#if !entries?has_content>
	<#if preview>
		<div class="alert alert-info">
			<@liferay.language key="there-are-no-pages-to-display-for-the-current-page-level" />
		</div>
	</#if>
<#else>
	<#assign
		portletDisplay = themeDisplay.getPortletDisplay()
		navbarId = "navbar_" + portletDisplay.getId()
	/>
	<div class="navbar" id="${navbarId}" role="navigation">
		<ul aria-label="<@liferay.language key="site-pages" />" class="nav navbar-blank nav-justified navbar-site" role="menubar">
			<h1 class="hide-accessible"><@liferay.language key="navigation" /></h1>

			<#assign nav_items = entries />

			<#list nav_items as nav_parent_item>
				<#assign showChildren = (displayDepth != 1) && nav_parent_item.hasBrowsableChildren() />

				<#if nav_parent_item.isBrowsable() || showChildren >
					<#assign
						nav_item_attr_has_popup = ""
						nav_item_attr_selected = ""
						nav_item_css_class = "lfr-nav-item"
						nav_item_caret = ""
						nav_item_href_link = ""
						nav_item_link_css_class = ""
					/>

					<#if nav_parent_item.isSelected()>
						<#assign
							nav_item_attr_selected = "aria-selected='true'"
							nav_item_css_class = "${nav_item_css_class} selected active"
						/>
					</#if>

					<#if nav_parent_item.isBrowsable()>
						<#assign nav_item_href_link = "href='${nav_parent_item.getURL()}'" />
					</#if>

					<#if showChildren>
						<#assign nav_item_attr_has_popup = "aria-haspopup='true'" />
						<#assign nav_item_caret = '<span class="lfr-nav-child-toggle"><i class="icon-caret-down"></i></span>' />
						<#assign
							nav_item_css_class = "${nav_item_css_class} dropdown"
							nav_item_link_css_class = "dropdown-toggle"
						/>
						<#assign nav_item_css_class = "${nav_item_css_class} has-children parent-menu" />
					</#if>

					<li ${nav_item_attr_selected} class="${nav_item_css_class}" id="layout_${nav_parent_item.getLayoutId()}" role="presentation">
						<a aria-labelledby="layout_${nav_parent_item.getLayoutId()}" ${nav_item_attr_has_popup} class="${nav_item_link_css_class}"
								${nav_item_href_link} ${nav_parent_item.getTarget()} role="menuitem">
							<span>
								<@liferay_theme["layout-icon"] layout=nav_item_layout />
								${nav_parent_item.getName()}
								${nav_item_caret}
							</span>
						</a>

						<#if showChildren>
							<ul class="child-menu dropdown-menu" role="menu">
								<#list nav_parent_item.getChildren() as nav_child>
									<#assign grandChildren = (displayDepth != 1) && nav_child.hasBrowsableChildren() />

									<#assign
										nav_child_attr_selected = ""
										nav_child_css_class = "lfr-nav-item"
										nav_child_attr_has_popup = ""
										nav_child_link_css_class = ""
										nav_child_caret = ""
									/>

									<#if nav_child.isSelected()>
										<#assign
											nav_child_attr_selected = "aria-selected='true'"
											nav_child_css_class = "${nav_child_css_class} selected active"
										/>
									</#if>

									<#if grandChildren>
										<#assign nav_child_css_class = "${nav_child_css_class} has-children" />
										<#assign nav_child_attr_has_popup = "aria-haspopup='true'" />
										<#assign nav_child_caret = '<a style="position: absolute; left: calc(83%); bottom: calc(6%);" class="childnav-toggler lfr-nav-child-toggle dropright" data-toggle="collapse" data-target="#grandchild"><i class="icon-caret-right"></i></a>' />
										<#assign
											nav_child_css_class = "${nav_child_css_class} dropdown dropdown-submenu"
											nav_child_link_css_class = "dropdown-toggle"
										/>
									</#if>

									<li ${nav_child_attr_selected} class="${nav_child_css_class}" id="layout_${nav_child.getLayoutId()}" role="presentation">
										<a aria-labelledby="layout_${nav_child.getLayoutId()}" ${nav_child_attr_has_popup} class="${nav_child_link_css_class}"
										   href="${nav_child.getURL()}" ${nav_child.getTarget()} role="menu">
											<span>
												${nav_child.getName()}
												${nav_child_caret}
											</span>
										</a>

										<#if grandChildren>
											<ul style="position: relative; float: right;" class="grandchild-menu dropdown-menu pull-right collapse" role="menuitem" id="grandchild">
												<#list nav_child.getChildren() as nav_grandchild>
													<#assign
														nav_grandchild_attr_selected = ""
														nav_grandchild_css_class = "lfr-nav-item"
													/>

													<#if nav_grandchild.isSelected()>
														<li style="position: relative; float: right;" class="selected" role="presentation">
													<#else>
														<li style="position: relative; float: right;">
													</#if>
													<a aria-labelledby="layout_${nav_grandchild.getLayoutId()}" class="${nav_grandchild_css_class}"
													   href="${nav_grandchild.getURL()}" ${nav_grandchild.getTarget()} role="menuitem">
														${nav_grandchild.getName()}
													</a>
													</li>
												</#list>
											</ul>
										</#if>
									</li>
								</#list>
							</ul>
						</#if>
					</li>
				</#if>
			</#list>
		</ul>
	</div>
	<@liferay_aui.script use="liferay-navigation-interaction">
		var navigation = A.one('#${navbarId}');

		Liferay.Data.NAV_INTERACTION_LIST_SELECTOR = '.navbar-site';
		Liferay.Data.NAV_LIST_SELECTOR = '.navbar-site';

		if (navigation) {
		navigation.plug(Liferay.NavigationInteraction);
		}

	</@>
</#if>

<script>
	$(document).on("click", '.childnav-toggler', function() {
		$(this).next().collapse('toggle');
	});
</script>

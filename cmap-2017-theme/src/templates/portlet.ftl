<#assign
	portlet_display = portletDisplay

	portlet_back_url = htmlUtil.escapeHREF(portlet_display.getURLBack())
	portlet_content_css_class = "portlet-content"
	portlet_display_name = htmlUtil.escape(portlet_display.getPortletDisplayName())
	portlet_display_root_portlet_id = htmlUtil.escapeAttribute(portlet_display.getRootPortletId())
	portlet_id = htmlUtil.escapeAttribute(portlet_display.getId())
	portlet_title = htmlUtil.escape(portlet_display.getTitle())
/>

<section class="portlet" id="portlet_${portlet_id}">
	<#if portlet_display.isPortletDecorate() && !portlet_display.isStateMax() && portlet_display.getPortletConfigurationIconMenu()?? && portlet_display.getPortletToolbar()??>
		<#assign
			portlet_configuration_icon_menu = portlet_display.getPortletConfigurationIconMenu()
			portlet_toolbar = portlet_display.getPortletToolbar()

			portlet_configuration_icons = portlet_configuration_icon_menu.getPortletConfigurationIcons(portlet_display_root_portlet_id, renderRequest, renderResponse)
			portlet_title_menus = portlet_toolbar.getPortletTitleMenus(portlet_display_root_portlet_id, renderRequest, renderResponse)
		/>

		<#if (portlet_configuration_icons?has_content || portlet_title_menus?has_content)>
			<header class="portlet-topper">
				<div class="portlet-title-default">
					<span class="portlet-name-text">
						<#if portlet_display.getPortletDecoratorId() == "full-width-content">
							<span>Full Width: </span> ${portlet_display_name}
						</#if>
						<#if portlet_display.getPortletDecoratorId() == "centered-content">
							<span>Centered: </span> ${portlet_display_name}
						</#if>
					</span>
				</div>

				<#foreach portletTitleMenu in portlet_title_menus>
					<menu class="portlet-title-menu portlet-topper-toolbar" id="portlet-title-menu_${portlet_id}_${portletTitleMenu_index + 1}" type="toolbar">
						<@liferay_ui["menu"] menu=portletTitleMenu />
					</menu>
				</#foreach>

				<#if portlet_configuration_icons?has_content>
					<menu class="portlet-topper-toolbar" id="portlet-topper-toolbar_${portlet_id}" type="toolbar">
						<@liferay_portlet["icon-options"] portletConfigurationIcons=portlet_configuration_icons />
					</menu>
				</#if>

				<menu class="portlet-topper-toolbar">
					<@liferay_util["dynamic-include"] key="portlet_header_${portlet_display_root_portlet_id}"/>
				</menu>
			</header>

			<#assign portlet_content_css_class = portlet_content_css_class + " portlet-content-editable" />
		</#if>
	</#if>

	<div class="${portlet_content_css_class}">
		<#if portlet_display.isShowBackIcon()>
			<a class="icon-monospaced portlet-icon-back list-unstyled text-default" href="${portlet_back_url}" title="<@liferay.language key="return-to-full-page" />">
				<@liferay_ui["icon"]
					icon="angle-left"
					markupView="lexicon"
				/>
			</a>
		</#if>

		<div class="row">
			<#if portlet_display.getPortletDecoratorId() == "centered-content">
				 <div class="col-xl-10 col-xl-offset-3 col-sm-16 col-sm-offset-0">
					 <h2 class="portlet-title-text sr-only">${portlet_title}</h2>
					 ${portlet_display.writeContent(writer)}
				 </div>
			<#elseif portlet_display.getPortletDecoratorId() == "full-width-content">
				<#-- no padding because it probably has a sub grid -->
				 <div class="col-xl-16" style="padding: 0 !important;">
					 <h2 class="portlet-title-text sr-only">${portlet_title}</h2>
					 ${portlet_display.writeContent(writer)}
				 </div>
			<#else>
				 <div class="col-xl-10 col-xl-offset-3 col-sm-16 col-sm-offset-0">
					 <h2 class="portlet-title-text sr-only">${portlet_title}</h2>
					 ${portlet_display.writeContent(writer)}
				 </div>
			</#if>
		</div>


	</div>
</section>

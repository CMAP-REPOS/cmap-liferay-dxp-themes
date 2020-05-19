<#include init />

<@liferay_util["dynamic-include"] key="portlet_header_${portlet_display_root_portlet_id}" />
<section class="portlet" id="portlet_${htmlUtil.escapeAttribute(portletDisplay.getId())}">
	${portletDisplay.writeContent(writer)}
</section>

<#if portletDisplay.isStateMax()>
	<@liferay.control_menu />
</#if>

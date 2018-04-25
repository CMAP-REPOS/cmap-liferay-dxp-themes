<#--
This file allows you to override and define new FreeMarker variables.
-->

<#assign my_variable_name = getterUtil.getBoolean(theme_settings["my-setting-language-key"])>

<#function validate_field field_name>
  <#if field_name?? && field_name != "">
    <#return field_name>
  <#else>
    <#return ''>
  </#if>
</#function>

<#assign butts = 'ha'>

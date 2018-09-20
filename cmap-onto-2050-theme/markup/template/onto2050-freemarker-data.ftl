<#function validate_field field>
  <#if field?? && field != "">
    <#return field>
  <#else>
    <#return ''>
  </#if>
</#function>

<#macro render_anchor name>
  <#if name != ''>
    <button class="page-anchor">
      <img class="anchor-icon" src="/icons/ic_clipboard.svg" />
    </button>
    <script>
      function init_anchor(){
        $('.anchor-icon').attr('src', Liferay.ThemeDisplay.getPathThemeImages()+'/icons/ic_clipboard.svg');
      }
      Liferay.on(
      	'allPortletsReady',
      	function() {
          init_anchor();
      	}
      );
    </script>
  </#if>
</#macro>

<#function anchor_signature class_name anchor_slug>
  <#if anchor_slug != ''>
    <#return 'class="${anchor_signature} anchor-point" id="${anchor_slug}"'>
  <#else>
    <#return 'class="${anchor_signature}"'>
  </#if>'>
</#function>

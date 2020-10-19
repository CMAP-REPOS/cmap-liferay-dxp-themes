<#function validate_field field>
  <#if field?? && field != "">
    <#return field>
  <#else>
    <#return ''>
  </#if>
</#function>

<#macro render_anchor name>
  <#if name != ''>
    <button class="page-anchor" data-anchor="${name}">
      <img class="anchor-icon" src="${themeDisplay.getPathThemeImages()}/icons/ic_clipboard.svg" />
    </button>
    <script>
      function init_anchor(){
        $('.anchor-icon').attr('src', Liferay.ThemeDisplay.getPathThemeImages()+'/icons/ic_clipboard.svg');
        $('.page-anchor').click(function(){
          console.log(window.location, $(this).data('anchor'));
        });
      }
      function copyToClipboard(str) {
        var el = document.createElement('textarea');
        el.value = str;
        el.setAttribute('readonly', '');
        el.style.position = 'absolute';
        el.style.left = '-9999px';
        document.body.appendChild(el);
        el.select();
        document.execCommand('copy');
        document.body.removeChild(el);
      };
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
    <#return 'class="${class_name} anchor-point" id="${anchor_slug}"'>
  <#else>
    <#return 'class="${class_name}"'>
  </#if>'>
</#function>

<#if entries?has_content>
  <nav class="breadcrumb breadcrumb-cmap row">

    <div class="share-col col-xl-3 col-sm-4 col-xs-6">
      <a class="share-button" data-toggle="popover" data-content="<div id='social-bookmarks-container'></div>" data-placement="bottom" title="Share">
				<svg xmlns="http://www.w3.org/2000/svg" width="14" height="18" viewBox="0 0 14 18"> <g fill="#3C5976"> <path d="M13,16.027 L12.125,16.902 L12.125,16.027 L13,16.027 Z M12.125,7.902 C12.125,7.41875084 12.5167508,7.027 13,7.027 C13.4832492,7.027 13.875,7.41875084 13.875,7.902 L13.875,17.777 L0.125,17.777 L0.125,7.902 C0.125,7.41875084 0.516750844,7.027 1,7.027 C1.48324916,7.027 1.875,7.41875084 1.875,7.902 L1.875,16.027 L12.125,16.027 L12.125,7.902 Z"/> <path d="M6.125,2.54 L6.125,11.313 C6.125,11.7962492 6.51675084,12.188 7,12.188 C7.48324916,12.188 7.875,11.7962492 7.875,11.313 L7.875,2.54 C7.875,2.05675084 7.48324916,1.665 7,1.665 C6.51675084,1.665 6.125,2.05675084 6.125,2.54 Z"/> <path d="M9.56091097,5.37903305 C9.92598944,5.69565183 10.4786143,5.6563675 10.795233,5.29128903 C11.1118518,4.92621056 11.0725675,4.37358574 10.707489,4.05696695 L7.0002,0.841775 L3.29291097,4.05696695 C2.9278325,4.37358574 2.88854817,4.92621056 3.20516695,5.29128903 C3.52178574,5.6563675 4.07441056,5.69565183 4.43948903,5.37903305 L7.0002,3.158225 L9.56091097,5.37903305 Z"/> </g></svg>
				<span class="whitney-small">Share</span>
			</a>
      <div class="share-popup">
        <!-- Go to www.addthis.com/dashboard to customize your tools -->
        <div class="addthis_inline_share_toolbox"></div> 
      </div>
    </div>

    <#assign cssClass="" />

    <div class="trail-col col-xl-13 col-sm-12 col-xs-10">
      <div class="breadcrumb-trail">
        <span class="entry home"> 
          <span class="square"></span> 
          <a class="whitney-small" href="/"> Home </a> 
        </span>

        <#list entries as entry>

          <#if entry?is_last>
            <#assign cssClass="active" />
          </#if>

          <span class="entry whitney-small ${cssClass}">
            <#assign url = entry.getURL()! "" >
            <#if url?has_content && url?contains("/web/guest")>
              <#assign url = url?replace("/web/guest","") >
            </#if>
            <#if entry.isBrowsable()>
              <#if entry?is_last>
                ${htmlUtil.escape(entry.getTitle())}
              <#else>
                <a href="${url}">
                  ${htmlUtil.escape(entry.getTitle())}
                </a>
              </#if>
            </#if>
  				</span>
        </#list>
      </div>
    </div>

    <div class="col-xl-16">
      <!-- Go to www.addthis.com/dashboard to customize your tools -->
      <div class="addthis_inline_share_toolbox"></div> 
    </div>
  </nav>
</#if>

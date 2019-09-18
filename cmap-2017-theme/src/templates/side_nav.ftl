<div id="side-nav">

  <#include "${full_templates_path}/components/logo.ftl" />

  <div class="side-nav-links">
    <#include "${full_templates_path}/components/site_pages.ftl" />
  </div>

  <div class="side-nav-search">
      <#include "${full_templates_path}/components/search_widget.ftl" />
  </div>

  <div class="side-nav-share-toggle">
	  <button class="share-button">
	    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
	      <g fill="#3C5976" transform="translate(4 2)">
	        <path d="M1.5,13.3333333 L1.5,6.5625 C1.5,6.15979237 1.16421356,5.83333333 0.75,5.83333333 C0.335786438,5.83333333 0,6.15979237 0,6.5625 L0,14.7916667 L11.7857143,14.7916667 L11.7857143,6.5625 C11.7857143,6.15979237 11.4499278,5.83333333 11.0357143,5.83333333 C10.6215007,5.83333333 10.2857143,6.15979237 10.2857143,6.5625 L10.2857143,13.3333333 L1.5,13.3333333 Z"/>
	        <path d="M6.75755451,2.56260921 L6.75755451,8.72602083 C6.75755451,9.12872846 6.42176807,9.4551875 6.00755451,9.4551875 C5.59334095,9.4551875 5.25755451,9.12872846 5.25755451,8.72602083 L5.25755451,2.56289829 L3.81283082,3.78104837 C3.49990642,4.04489736 3.026228,4.01216042 2.75484047,3.70792836 C2.48345294,3.4036963 2.51712523,2.94317562 2.83004963,2.67932663 L6.00772594,0 L9.18540225,2.67932663 C9.49832665,2.94317562 9.53199894,3.4036963 9.26061141,3.70792836 C8.98922388,4.01216042 8.51554546,4.04489736 8.20262106,3.78104837 L6.75755451,2.56260921 Z"/>
	      </g>
	    </svg>
	    <span class="whitney-small">Share</span>
	  </button>
	  <button class="close-button">
	    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
	      <path fill="#3A5776" d="M10.7928932,9.29289322 L10.7928932,2 L9.29289322,2 L9.29289322,9.29289322 L2,9.29289322 L2,10.7928932 L9.29289322,10.7928932 L9.29289322,18 L10.7928932,18 L10.7928932,10.7928932 L18,10.7928932 L18,9.29289322 L10.7928932,9.29289322 Z" transform="rotate(45 10 10)"/>
	    </svg>
	    <span class="whitney-small">Close</span>
	  </button>
  </div>

  <div class="share-menu">
    <input class="page-url" type="text" value=""/>
    <div class="addthis_inline_share_toolbox"></div>
  </div>

  <div class="dummy-div"></div>
</div>

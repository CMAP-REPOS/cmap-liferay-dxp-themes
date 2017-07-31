<style type="text/css">
.header-back-to {
    display: none;
}
</style>
<div class="updateslayout" id="main-content" role="main">
  #if ($browserSniffer.isIe($request) && $browserSniffer.getMajorVersion($request) < 8)

    <table class="portlet-layout">
      <tr>
        <td width="30%" class="portlet-column portlet-column-first more-in-section">
          &nbsp;
        </td> <!-- .portlet-column -->

        <td width="40%" class="portlet-column breadcrumbs-wrap">
          <!-- processor.processPortlet("categoriesfilter_WAR_CustomPortletsportlet") -->
        </td> <!-- .portlet-column -->

        <td width="30%" class="portlet-column portlet-column-last share-this-block">
          <label for="share-this-toggle" id="share-this-label">Share</label>
          <div class="share-wrapper"></div>
        </td> <!-- .portlet-column -->
      </tr>
    </table> <!-- .portlet-layout -->

    <table class="portlet-layout">
      <tr>
        <td class="portlet-column portlet-column-first secondary" id="column-2">
          <p class="menu-heading">More in this section:</p>
          <!-- processor.processPortlet("71_INSTANCE_Nj25") -->
          $processor.processColumn("column-2", "portlet-column-content portlet-column-content-first")
        </td> <!-- .portlet-column -->
        
        <td class="portlet-column portlet-column-last primary" id="column-3">
          <!-- processor.processPortlet("73_INSTANCE_Nj25") -->
          $processor.processColumn("column-3", "portlet-column-content portlet-column-content-last")
        </td> <!-- .portlet-column -->
      </tr>
    </table> <!-- .portlet-layout -->

  #else

    <div class="portlet-layout page-meta-data">
      <div class="row-fluid container-fluid">
        <div class="portlet-column portlet-column-first span2 more-in-section">
        </div> <!-- .portlet-column -->

        <div class="portlet-column span7 offset1 breadcrumbs-wrap">
          <!-- processor.processPortlet("categoriesfilter_WAR_CustomPortletsportlet") -->
        </div> <!-- .portlet-column -->

        <div class="portlet-column portlet-column-last span2 share-this-block">  
          <label for="share-this-toggle" id="share-this-label">Share</label>
          <div class="share-wrapper"></div>
        </div> <!-- .portlet-column -->
      </div> <!-- .row-fluid -->
    </div> <!-- .portlet-layout -->

    <div class="portlet-layout main-content">
      <div class="row-fluid container-fluid">        
        <div class="portlet-column portlet-column-last span9 pull-right primary" id="column-3">
          $processor.processColumn("column-3", "portlet-column-content portlet-column-content-last")
        </div> <!-- .portlet-column -->
        
        <div class="portlet-column portlet-column-first span2 secondary" id="column-2">
          <p class="menu-heading">More in this section:</p>
          <!-- processor.processPortlet("71_INSTANCE_Nj25") -->
          $processor.processColumn("column-2", "portlet-column-content portlet-column-content-first")
        </div> <!-- .portlet-column -->
      </div> <!-- .row-fluid -->
    </div> <!-- .portlet-layout -->
  
  #end
</div> <!-- .updateslayout -->


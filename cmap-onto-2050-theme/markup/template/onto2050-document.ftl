<#function si num>
    <#assign order = num?round?c?length />
    <#assign thousands = ((order - 1) / 3)?floor />
    <#if (thousands < 0)><#assign thousands = 0 /></#if>
    <#assign siMap = [ {"factor": 1, "unit": ""}, {"factor": 1000, "unit": "kB"}, {"factor": 1000000, "unit": "MB"}, {"factor": 1000000000, "unit":"GB"}, {"factor": 1000000000000, "unit": "TB"} ]/>
    <#assign siStr = (num / (siMap[thousands].factor))?string("0.#") + siMap[thousands].unit />
    <#return siStr />
</#function>

<#if Document?? && Document.getData()?? && Document.getData() != "">
  <#assign DLFileEntryLocalService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLFileEntryLocalService")>

  <#assign FileCounter = 0 >

  <#list Document.getData()?split("/") as x>
    <#if FileCounter == 5>
      <#assign uuId = x >
    </#if>
    <#assign FileCounter = FileCounter+1 >
  </#list>

  <#attempt>
    <#assign file = DLFileEntryLocalService.getFileEntryByUuidAndGroupId(uuId, groupId)>
    <#assign link = Document.getData()>
  <#recover>
    <#assign file = "">
    <#assign link = "">
  </#attempt>
</#if>

<div class="onto2050-document" id="${randomNamespace}">
  <div class="row">
    <div class="col-xs-8">
      <#if link?? && link != "">
      <a class="document-img-link" href="${link}" target="_blank">
      </#if>

      <#if DocumentImage?? && DocumentImage.getData()?? && DocumentImage.getData() != "">
        <img class="document-img" src="${DocumentImage.getData()}" alt="${DocumentImage.getAttribute("alt")}"/>
      </#if>

      <#if link?? && link != "">
      </a>
      </#if>
    </div>

    <div class="col-xs-8">
    <#if DocumentTitle?? && DocumentTitle.getData()?? && DocumentTitle.getData() != "">
      <div class="document-title">
        <span class="normal-headline">${DocumentTitle.getData()}</span>
      </div>
    </#if>

    <#if file?? && file != "">
      <div class="document-cta">
        <a href="${link}" target="_blank">
          <div class="file-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="18" viewBox="0 0 14 18">
              <path fill="#3C5976" d="M14,4.82159223 L14,17.99 L0,17.99 L0,0 L9.46872143,0 L9.47572959,4.79258408 L14,4.82159223 Z M1.75,16.24 L12.25,16.24 L12.25,6.56040777 L7.72827041,6.53141592 L7.72127857,1.75 L1.75,1.75 L1.75,16.24 Z"/>
            </svg>
          </div>
          Download <span class="file-extension">${file.getExtension()}</span>  [${si(file.getSize())}]
        </a>
      </div>
    </#if>
    </div>
  </div>
</div>

<script>
$(document).ready(function(){
  var $this = $('#${randomNamespace}');


  if($this.parents('.col-md-16.portlet-column').length){
    // col-md-16 col-sm-16 portlet-column portlet-column-only yui3-dd-drop
    // col-md-8 col-sm-16 portlet-column yui3-dd-drop
    var $row = $this.find('.row').remove();
    var $container = $('<div class="row"></div>');
    var $center = $('<div class="col-md-8 col-md-offset-4 col-sm-16 col-sm-offset-0"></div>');
    $this.append($container.append($center.append($row)));
  }
});
</script>
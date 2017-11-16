<#function si num>
    <#assign order = num?round?c?length />
    <#assign thousands = ((order - 1) / 3)?floor />
    <#if (thousands < 0)><#assign thousands = 0 /></#if>
    <#assign siMap = [ {"factor": 1, "unit": ""}, {"factor": 1000, "unit": "kB"}, {"factor": 1000000, "unit": "MB"}, {"factor": 1000000000, "unit":"GB"}, {"factor": 1000000000000, "unit": "TB"} ]/>
    <#assign siStr = (num / (siMap[thousands].factor))?string("0.#") + siMap[thousands].unit />
    <#return siStr />
</#function>

<#if Url?? && Url.getData()?? && Url.getData() != "">
  <#assign link = Url.getData()>
</#if>

<#if Page?? && Page.getData()?? && Page.getData() != "">
  <#assign link = Page.getFriendlyUrl()>
</#if>

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

<#if OptionalContentBefore?? && OptionalContentBefore.getData()?? && OptionalContentBefore.getData() != "">
${OptionalContentBefore.getData()}
</#if>

<section class="featured-card" id="${randomNamespace}">
  <div class="row">
    <div class="col-xl-8">
      <#if file?? && file != "">
      <a class="featured-card-img-link" href="${link}">
      </#if>

      <#if ImageToDisplay?? && ImageToDisplay.getData()?? && ImageToDisplay.getData() != "">
        <img class="featured-card-img" src="${ImageToDisplay.getData()}" alt="${ImageToDisplay.getAttribute("alt")}"/>
      </#if>

      <#if file?? && file != "">
      </a>
      </#if>
    </div>


    <div class="col-xl-8">
      <p class="whitney-normal">Document</p>
    <#if Caption?? && Caption.getData()?? && Caption.getData() != "">
      <div class="featured-card-description">
        ${Caption.getData()}
      </div>
    </#if>
    <#if CardTitle??>
      <div class="featured-card-title">
        <span class="whitney-normal__bold">${CardTitle.getData()}</span>
      </div>
    </#if>

    <#if file?? && file != "">
      <div class="featured-card-cta">
        <a class="underline-link" href="${link}">
          <div class="file-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="18" viewBox="0 0 14 18">
              <path fill="#3C5976" d="M14,4.82159223 L14,17.99 L0,17.99 L0,0 L9.46872143,0 L9.47572959,4.79258408 L14,4.82159223 Z M1.75,16.24 L12.25,16.24 L12.25,6.56040777 L7.72827041,6.53141592 L7.72127857,1.75 L1.75,1.75 L1.75,16.24 Z"/>
            </svg>
          </div>
          Download <span class="file-extension">${file.getExtension()}</span>  [${si(file.getSize())}]
        </a>
      </div>
    </#if>
    <#if Page?? && Page.getData()?? && Page.getData() != "">
      <div class="featured-card-cta">
        <a class="underline-link" href="${Page.getData()}">
          View Page
        </a>
      </div>
    </#if>
    <#if Url?? && Url.getData()?? && Url.getData() != "">
      <div class="featured-card-cta">
        <a class="underline-link" href="${Url.getData()}">
          View URL
        </a>
      </div>
    </#if>
    </div>
  </div>
</section>

<#if OptionalContentAfter?? && OptionalContentAfter.getData()?? && OptionalContentAfter.getData() != "">
${OptionalContentAfter.getData()}
</#if>

<script>
$(document).ready(function(){
  var $this = $('#${randomNamespace}');

  if($this){
    var $row = $this.find('.row').remove();
    var $container = $('<div class="row"></div>');
    var $center = $('<div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0"></div>');
    $this.append($container.append($center.append($row)));
  }
});
</script>
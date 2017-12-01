<#assign titleTextColor = "#000"/>
<#assign descriptionTextColor = "#000"/>

<#if Title.TitleTextColor?? && 
    Title.TitleTextColor.getData()?? && 
    Title.TitleTextColor.getData() != "">
    <#assign titleTextColor = Title.TitleTextColor.getData() />
</#if>

<#if Description.DescriptionTextColor?? && 
    Description.DescriptionTextColor.getData()?? && 
    Description.DescriptionTextColor.getData() != "">
    <#assign descriptionTextColor = Title.TitleTextColor.getData() />
</#if>

<section class="section-hero">

  <div class="top">
    <div class="row">
      <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
        <h1 class="section-title" style="color: ${titleTextColor}">${Title.getData()}</h1>
      </div>
    </div>
  </div>

  <div class="bottom" style="background: url('${Background.getData()}')">
    <div class="row">
      <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0" 
      style="color: ${descriptionTextColor}">
        ${Description.getData()}
      </div>
    </div>
  </div>

</section>
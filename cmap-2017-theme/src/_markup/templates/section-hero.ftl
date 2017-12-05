<#assign titleTextColor = "black"/>
<#assign descriptionTextColor = "white"/>

<#if Title.TitleTextColor?? && 
    Title.TitleTextColor.getData()?? && 
    Title.TitleTextColor.getData() != "">
    <#assign titleTextColor = Title.TitleTextColor.getData() />
</#if>

<#if Description.DescriptionTextColor?? && 
    Description.DescriptionTextColor.getData()?? && 
    Description.DescriptionTextColor.getData() != "">
    <#assign descriptionTextColor = Description.DescriptionTextColor.getData() />
</#if>


<section class="section-hero">

  <div class="top ${titleTextColor}">
    <div class="row">
      <div class="col-xl-10 col-xl-offset-3 col-sm-16 col-sm-offset-0">
        <h1 class="section-title">${Title.getData()}</h1>
      </div>
    </div>
  </div>

  <div class="bottom ${descriptionTextColor}" style="background: url('${Background.getData()}')">
    <div class="row">
      <div class="col-xl-10 col-xl-offset-3 col-sm-16 col-sm-offset-0">
        ${Description.getData()}
      </div>
    </div>
  </div>

</section>
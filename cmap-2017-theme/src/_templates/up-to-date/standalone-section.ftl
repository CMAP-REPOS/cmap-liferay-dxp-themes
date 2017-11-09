<#list Subtitle.getSiblings() as section>

<section class="title-with-sections standalone-title-with-sections">
  <div class="row page-layout">
    <div class="col-xl-3 col-sm-16">
    </div>
    <div class="col-xl-10 col-sm-12 col-xs-16">
        <section class="standalone-section"> 
            <div class="section-title standalone-section-title"> 
                <h2 id="${section.getData()?replace(" ", "_")}" data-text="${section.getData()}">${section.getData()}</h2>
            </div> 
            <div class="section-content standalone-section-content"> 
                ${section.Body.getData()}
            </div> 
        </section>    
    </div>
    <div class="col-xl-3 col-sm-4">
    </div>
  </div>
</section>

</#list>
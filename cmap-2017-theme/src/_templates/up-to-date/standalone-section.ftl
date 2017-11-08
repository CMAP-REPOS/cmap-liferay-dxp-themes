<#list Subtitle.getSiblings() as section>

<section class="title-with-sections">
  <div class="row page-layout">
    <div class="col-xl-3 col-sm-16">
    </div>
    <div class="col-xl-10 col-sm-12 col-xs-16">
        <section> 
            <div class="section-title"> 
                <h2 id="${section.getData()?replace(" ", "_")}">${section.getData()}</h2>
            </div> 
            <div class="section-content"> 
                ${section.Body.getData()}
            </div> 
        </section>    
    </div>
  </div>
</section>

</#list>

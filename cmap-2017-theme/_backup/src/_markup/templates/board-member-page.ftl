<section class="board-member">
  <div class="top row">
    <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
      <h1 class="board-member-name whitney-large__bold"> ${Name.getData()} </h1>
      <h2 class="board-member-district whitney-large"> ${District.getData()} </h2>
    </div>
  </div>

  <div class="middle row">
    <div class="col-xl-5 col-xl-offset-3 col-md-6 col-md-offset-2 col-sm-16 col-sm-offset-0">
      <#if Picture.getData()?? && Picture.getData() != "">
      	<img data-fileentryid="${Picture.getAttribute("fileEntryId")}" alt="${Picture.getAttribute("alt")}" src="${Picture.getData()}" />
      </#if>
    </div>
    <div class="col-xl-5 col-md-6 col-sm-16">
      <h3 class="board-member-position">${Profession.getData()}</h3>
    </div>
  </div>

  <div class="bottom row">
    <div class="col-xl-10 col-xl-offset-3 col-md-12 col-md-offset-2 col-sm-16 col-sm-offset-0">
      ${Description.getData()}
    </div>
  </div>
</section>

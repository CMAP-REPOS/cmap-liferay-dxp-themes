<#if ThumbnailImage.getData()?? && ThumbnailImage.getData() != "">
    <img class="thumbnail-img" data-fileentryid="${ThumbnailImage.getAttribute("fileEntryId")}" alt="${ThumbnailImage.getAttribute("alt")}" src="${ThumbnailImage.getData()}" />
</#if>


<style>
    .thumbnail-img {
        display: none;
    }
</style>
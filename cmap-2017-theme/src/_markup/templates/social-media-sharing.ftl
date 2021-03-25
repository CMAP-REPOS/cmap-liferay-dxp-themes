<#assign serviceContext = staticUtil["com.liferay.portal.kernel.service.ServiceContextThreadLocal"].getServiceContext() />
<#assign themeDisplay = serviceContext.getThemeDisplay() />

<#function cleanContractions str>
    <#assign returnString = '' />
    <#list 0..<str?length as i>>
        <#if i != 0 && i != str?length - 1 >
            <#if str[i - 1] == "-" && str[i + 1] == "-">
                <#if str[i] != "a" && str[i] != "i">
                    <#assign returnString = str[0..i-2] + "'" + str[i..str?length-1] />
                <#else>
                    <#assign returnString = str />
                </#if>
            <#else>
                <#assign returnString = str />
            </#if>
        </#if>
    </#list>
    <#return returnString>
</#function>

<#if SocialMediaCardTitle?? && SocialMediaCardTitle.getData()?? && SocialMediaCardTitle.getData() != "">
    <#assign title = SocialMediaCardTitle.getData() />
<#else>
    <#assign title = themeDisplay.getURLCurrent()?keep_after_last("/") />
    <#assign title = cleanContractions(title)?replace("-", " ")?capitalize />
</#if>

<#assign imageURL = ThumbnailImage.getData() >

<#function cleanImageURL imageURL>
    <#if imageURL?contains("@root")>
        <#return imageURL?keep_after("root_path@") >
    <#else>
        <#return imageURL >
    </#if>
</#function>

<@liferay_util["html-top"]>

    <!-- Twitter
    <meta name="twitter:description" content="${ThumbnailImage.getAttribute("alt")}">
    -->
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:site" content="@onto2050">

    <meta name="twitter:title" content="${title}">
    <meta name="twitter:image" content="https://www.cmap.illinois.gov${cleanImageURL(imageURL)}">

    <!-- Facebook and LinkedIn
    <meta property="og:description" content="${ThumbnailImage.getAttribute("alt")}"/>
    -->
    <meta property="og:title" content="${title}" />
    <meta property="og:image" content="https://www.cmap.illinois.gov${cleanImageURL(imageURL)}" />
    <meta property="og:url" content="https://www.cmap.illinois.gov${themeDisplay.getURLCurrent()}" />

</@>

<div>
    <#if ThumbnailImage.getData()?? && ThumbnailImage.getData() != "">
        <img class="thumbnail-img" data-fileentryid="${ThumbnailImage.getAttribute("fileEntryId")}" alt="${ThumbnailImage.getAttribute("alt")}" src="${ThumbnailImage.getData()}" />
    </#if>
</div>

<style>
    .thumbnail-img {
        display: none;
    }
</style>
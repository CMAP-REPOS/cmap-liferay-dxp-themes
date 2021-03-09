<#--<#include "${templatesPath}/875701">-->
<#include "${templatesPath}/848954">

<#assign anchor = validate_field(Anchor.getData())>
<#assign title = validate_field(Title.getData())>

<div ${anchor_signature('page-cards', anchor)}>
    <h4 class="section-title">${title}</h4>

    <@render_anchor name=anchor/>

    <#if Card.getSiblings()?has_content>
        <div class="row">

            <#list Card.getSiblings() as cur_Card>

                <#assign card_picture = validate_field(cur_Card.CardAsset.getData())>
                <#assign card_title = validate_field(cur_Card.CardTitle.getData())>
                <#assign card_link = validate_field(cur_Card.CardLink.getData())>

                <div class="page-card col-sm-8 col-xs-16">
                    <div class="top">
                        <#if card_link != '' >
                        <a href="${card_link}">
                            </#if>
                            <#if card_picture != '' >
                                <img data-fileentryid="${cur_Card.CardAsset.getAttribute("fileEntryId")}" alt="${cur_Card.CardAsset.getAttribute("alt")}" src="${card_picture}" />
                            <#else>
                                <div class="placeholder-image"></div>
                            </#if>
                            <#if card_link != '' >
                        </a>
                        </#if>
                    </div>

                    <div class="bottom">
                        <#if card_title != "" >
                            <h4>
                                <#if card_link != "" >
                                    <a href="${card_link}"> ${card_title} </a>
                                <#else>
                                    ${card_title}
                                </#if>
                            </h4>
                        </#if>
                    </div>
                </div>
            </#list>
        </div>
    </#if>

</div>

<script>
    Liferay.on(
            'allPortletsReady',
            function() {
                $('.page-cards').each(function(){
                    var $this = $(this);
                    if($this.parents('.col-md-16.portlet-column').length){

                        $this.parents('.col-md-16.portlet-column').addClass('no-padding');
                        $this.after('<div class="col-lg-4 col-md-3 col-sm-16"></div>');
                        $this.before('<div class="col-lg-4 col-md-3 col-sm-16"></div>');
                        $this.wrap('<div class="col-lg-8 col-md-10 col-sm-16"></div>');
                    }
                });
            });
</script>
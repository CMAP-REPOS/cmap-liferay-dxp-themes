<#if Profile.getSiblings()?has_content>
<section id="profile-grid" class="row">

	<#list Profile.getSiblings() as cur_Profile>
		<#assign profilepicture>
			<#if cur_Profile.Photo.getData()?? && cur_Profile.Photo.getData() != "">
				background-image: url('${cur_Profile.Photo.getData()}');
			<#else>
				background: transparent;
			</#if>
		</#assign>

		<#assign profilehref>
			<#if cur_Profile.Href.getData()??>
				${cur_Profile.Href.getData()}
			</#if>
		</#assign>


		<a href="${profilehref}" class="col-sm-8 profile-grid-item" style="${profilepicture}">
			<div class="profile-text">
				<#if cur_Profile.Name.getData()??>
					<span class="profile-name">${cur_Profile.Name.getData()}</span>
				</#if>
				<#if cur_Profile.Title.getSiblings()?has_content>
        	<#list cur_Profile.Title.getSiblings() as profile_title>
						<span class="profile-title">${profile_title.getData()}</span>
        	</#list>
        </#if>
				<#if cur_Profile.Title.getData()??>
				</#if>
			</div>
			<#if cur_Profile.Photo.getData()?? && cur_Profile.Photo.getData() != "">
				<span class="sr-only">${cur_Profile.Photo.getAttribute("alt")}</span>
			</#if>
		</a>
	</#list>
</section>
</#if>

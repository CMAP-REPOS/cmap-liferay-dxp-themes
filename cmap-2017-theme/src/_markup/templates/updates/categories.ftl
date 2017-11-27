
<header class="updates-header">
	<#if entries?has_content>
	<h1 class="updates-header-title">Policy Updates</h1>
	<nav class="updates-filter">
	<#list entries as curVocabulary>
		<#if curVocabulary.name == 'Updates'>
		<div class="updates-filter-type">
			<label class="updates-filter-label">Show</label>
			<#list curVocabulary.getCategories() as sub >
				<#if sub.name == 'All Updates'>
					<a class="filter-button" href="/updates/all">All</a>
				</#if>
				<#if sub.name == 'Policy Updates'>
					<a class="filter-button" href="/updates/all/-/categories/${sub.categoryId}" data-catid="${sub.categoryId}">Policy</a>
				</#if>
				<#if sub.name == 'Weekly Updates'>
					<a class="filter-button" href="/updates/all/-/categories/${sub.categoryId}" data-catid="${sub.categoryId}">Weekly</a>
				</#if>
				<#if sub.name == 'Legislative Updates'>
					<a class="filter-button" href="/updates/all/-/categories/${sub.categoryId}" data-catid="${sub.categoryId}">Legislative</a>
				</#if>
			</#list>
		</div>
		</#if>

		<#if curVocabulary.name == 'Updates Topics'>
		<div class="updates-filter-topic">
			<label class="updates-filter-label">Filter by</label>
			<select class="dropdown-input">
				<option selected disabled="true">Topic</option>
				<#list curVocabulary.getCategories() as sub >
					<option data-catid="${sub.categoryId}">${sub.name}</option>
				</#list> 
			</select>
		</div>
		</#if>

	</#list>
	</nav>
	</#if>
</header>


<#-- https://docs.liferay.com/portal/7.0/javadocs/portal-kernel/com/liferay/asset/kernel/model/AssetCategory.html -->
<#-- https://docs.liferay.com/portal/7.0/javadocs/portal-kernel/com/liferay/asset/kernel/model/AssetVocabulary.html -->
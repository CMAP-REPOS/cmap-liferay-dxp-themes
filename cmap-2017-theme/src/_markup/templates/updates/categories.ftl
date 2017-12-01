
<header class="updates-header">
	<#if entries?has_content>
	<h1 class="updates-header-title"></h1>
	<nav class="updates-filter">
	<#list entries as curVocabulary>
		<#if curVocabulary.name == 'Updates'>
		<div class="updates-filter-type">
			<label class="updates-filter-label">Show</label>
			<a class="filter-button all-option" href="/updates/all">All</a>
			<a class="filter-button policy-option" href="/updates/policy">Policy</a>
			<a class="filter-button weekly-option" href="/updates/weekly">Weekly</a>
			<a class="filter-button legislative-option" href="/updates/legislative">Legislative</a>
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

<script type="text/javascript">

$(document).ready(function(){


	function capitalize(string) {
	  return string.charAt(0).toUpperCase() + string.slice(1);
	}

	// http://regexr.com/3h9gi
	var pageTopic = window.location.pathname.replace(/.*\/updates\/(\w*).*/, '$1');
	$('.updates-header-title').text(capitalize(pageTopic)+' Updates');
	$('.filter-button.'+pageTopic+'-option').addClass('active');

	var options = {};
	$('select.dropdown-input option').each(function(){
		var $this = $(this), v = $this.text(), d = $this.data('catid');
		options[v] = {
			id: d,
			object: $this
		};
	});

	$('select.dropdown-input').on('change', function(){
		var val = $(this).val();
		// WARNING: the next line will redirect the page causing a refresh
		window.location.pathname = '/updates/'+pageTopic+'/-/categories/' + options[val].id;
	});

	$('select.dropdown-input option').removeAttr('selected');
	var category_id = window.location.pathname.replace(/.*\/categories\/(\w*).*/, '$1');
	if(category_id !== '/updates/all/'){ // we have a match!
		for (i in options){
			if(options[i].id === parseInt(category_id)){
				console.log(options[i].object);
				options[i].object.attr('selected', 'true');
			}
		}
	}
	
	var $gross_layout = $('section.title-with-sections');
	if($gross_layout.length){
		$('#layout-column_column-1').append($gross_layout.remove());
		$gross_layout.find('.page-nav-container').remove();
		$gross_layout.find('.page-date').remove();
	}

	var $asset_preview = $('.asset-content');
	if($asset_preview.length){
		$('header.updates-header').hide();
		var $back =  $('.portlet-body .h2 .header-back-to a');
		$back.find('span:first-of-type').addClass('icon').removeAttr('id');
		$back.find('span:last-of-type').removeAttr('class').text('View all updates');
		if($gross_layout.length){
			$gross_layout.find('.col-xl-3:first-of-type').append($back.remove());
			$('.portlet-body .h2').remove();
		} else {
			var update_title = $('.header-title').text();
			$('.portlet-body .h2').append('<h1 class="whitney-huge">' + update_title + '</h1>');
			$('.header-title').remove();
		}

	}
});
</script>
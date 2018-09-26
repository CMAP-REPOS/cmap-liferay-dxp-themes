<#assign glossary = []>
<#assign initials = []>

<#if Term.getSiblings()?has_content>

	<#list Term.getSiblings() as cur_Term>
		<#if cur_Term?has_content >
			<#assign term = cur_Term.getData()>
			<#assign definition = cur_Term.Definition.getData()>
			<#assign anchor = term?lower_case?replace('[^a-z]', '-', 'ri')>
			<#assign initial = term?upper_case[0]>
			<#-- generate array of unique first letters for  jump list -->
			<#assign initialIndex = initials?seq_index_of(initial)>
			<#if initialIndex == -1>
				<#assign initials = initials + [initial]>
			</#if>
			<#assign glossary = glossary + [{
				"term"			: term,
				"anchor"		: anchor,
				"initial"		: initial, 
				"definition"	: definition
			}]>
		</#if>
	</#list>

	<div class="onto2050-glossary">
		<header>
			<div clas="row">
				<div class="col-xs-16 col-md-8">
					<div class="field-label-container">
						<label for="jump">Jump to</label>
						<div class="select-wrapper">
							<select name="jump" id="glossary_jump">
								<option value=""></option>
								<#list initials as i>
									<option value="${i}">${i}</option>
								</#list>
							</select>
						</div>
					</div>
				</div>
				<div class="col-xs-16 col-md-8">
					<div class="field-label-container">
						<input type="text" id="glossary_search" placeholder="Find by term">
					</div>
				</div>
			</div>
			<div class="row"></div>
		</header>
		<div class="row">
			<div class="col-xs-16">
				<dl>
							<div class="character-group">
					<#assign separators = []>
					<#list glossary?sort_by("term") as g>
						<#assign separatorIndex = separators?seq_index_of(g.initial)>
						<#if separatorIndex == -1>
							<#assign separators = separators + [g.initial]>
							</div>
							<div class="character-group">
								<div class="row">
									<a id="${g.initial}"></a>
									<div class="initial">${g.initial}</div>
								</div>
						</#if>
								<div data-term="${g.term?lower_case}" class="row term-wrapper">
									<a id="${g.anchor}"></a>
									<dt class="col-xs-16 col-sm-4">${g.term}</dt>
									<dd class="col-xs-16 col-sm-12">${g.definition}</dd>
								</div>
					</#list>
							</div>
				</dl>
			</div>
		</div>
	</div>

</#if>

<script>
AUI().ready( function () {
	$('#glossary_jump').val('').on('change', function () {
		var initial = $(this).val();
		var hashless = window.location.href.replace(window.location.hash, '');
		if (initial !== '') {
			window.location.href = hashless + '#' + initial;
		} else {
			window.location.href = hashless;
		}
	});
	$('#glossary_search').val('').on('input', function () {
		var term = $(this).val().toLowerCase();
		if ($.trim(term) === '') {
			$("dl").find('div.term-wrapper').show();
		} else {
			$("dl").find('div.term-wrapper').hide();
			$("dl").find('div.term-wrapper[data-term*="' + term + '"]').show();
		}
	});
});
</script>

<style>
::placeholder {
	color: #475C66;
	opacity: 1;
}
</style>
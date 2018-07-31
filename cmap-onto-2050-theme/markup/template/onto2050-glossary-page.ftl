<#assign glossary = []>
<#assign initials = []>

<#if Term.getSiblings()?has_content>

	<div class="onto2050-glossary-page">
		<#list Term.getSiblings() as cur_Term>
		
			<#assign term = cur_Term.getData()>
			<#assign definition = cur_Term.Definition.getData()>
			<#assign anchor = term?lower_case?replace('[^a-z]', '-', 'ri')>
			<#assign initial = term[0]?upper_case>
		
			<#-- generate array of unique first letters for  jump list -->
			<#assign initialIndex = initials?seq_index_of(initial)>
			<#if initialIndex == -1>
				<#assign initials = initials + [initial]>
			</#if>

			<#assign glossary = glossary + [{
				"term" : term,
				"anchor" : anchor,
				"initial" : initial, 
				"definition" : definition
			}]>
		</#list>

		<header class="page-header">
			<h2 class="page-title alt-color">Glossary</h2>
			<div class="row">
				<div class="form-group col-sm-6">
					<label>
						<span>Jump to </span>
						<select id="glossary_jump" class="form-control">
							<option value=""></option>
							<#list initials as i>
								<option value="${i}">${i}</option>
							</#list>
						</select>
					</label>
				</div>
				<div class="form-group col-sm-10">
					<label>
						<span>Find by term </span>
						<input type="text" id="glossary_search" class="form-control" />
					</label>
				</div>
			</div>
		</header>
		
		<main>
			<dl>
			<#assign separators = []>
			<#list glossary?sort_by("term") as g>
				<section class="glossary-section">
					<#assign separatorIndex = separators?seq_index_of(g.initial)>
					<#if separatorIndex == -1>
						<#assign separators = separators + [g.initial]>
						<header id="${g.initial}" class="row">
							<h3 class="whitney-middle bold">${g.initial}</h3>
						</header>
					</#if>
					<div id="${g.anchor}" data-term="${g.term?lower_case}" class="glossary-term-def row">
						<dt class="col-sm-6">${g.term}</dt>
						<dd class="col-sm-10">${g.definition}</dd>
					</div>
				</section>
			</#list>
			</dl>
		</main>
	</div>
</#if>

<script>

AUI().ready(

  function () {
  
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
        $("dl").find('div.glossary-wrapper').show();
      } else {
        $("dl").find('div.glossary-wrapper').hide();
        $("dl").find('div.glossary-wrapper[data-term*="' + term + '"]').show();
      }
    });

  }
);

</script>
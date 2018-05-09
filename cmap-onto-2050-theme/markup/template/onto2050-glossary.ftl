<#assign glossary = []>
<#assign initials = []>

<#if Term.getSiblings()?has_content>
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

<div class="col-lg-4 col-md-3 col-sm-16"></div>
<div class="col-lg-8 col-md-10 col-sm-16">
	<div class="form-inline">
		<div class="form-group">
			<label for="glossary_jump" class="control-label">Jump to</label> 
			<select id="glossary_jump" class="form-control">
				<option value=""></option>
				<#list initials as i>
				<option value="${i}">${i}</option>
				</#list>
			</select>
		</div>
		<div class="form-group">
			<label for="glossary_search" class="control-label">Find by term</label> 
			<input type="text" id="glossary_search" class="form-control">
		</div>
	</div>
</div>
<div class="col-lg-4 col-md-3 col-sm-16"></div>
<div class="col-md-16 col-sm-16">
	<#assign separators = []>
	<#list glossary?sort_by("term") as g>
	<#assign separatorIndex = separators?seq_index_of(g.initial)>
	<#if separatorIndex == -1>
    <#assign separators = separators + [g.initial]>
	<#if !g?is_first>
    </dl>
	</#if>
	<a id="${g.initial}"></a>
    <h3 class="glossary-initial">${g.initial}</h3>
	<#if !g?is_last>
	<dl>
	</#if>
	</#if>
	<div data-term="${g.term?lower_case}" class="glossary-wrapper">
		<a id="${g.anchor}"></a>
		<dt class="glossary-term">${g.term}</dt>
		<dd class="glossary-definition">${g.definition}</dd>
	</div>
	</#list>
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
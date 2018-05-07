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

    Jump to <select id="glossary_jump">
    <option value=""></option>
	<#list initials as i>
	    <option value="${i}">${i}</option>
    </#list>
    </select>
    Find by term <input type="text" id="glossary_search">
    <dl>
    <#assign separators = []>
	<#list glossary?sort_by("term") as g>
		<#assign separatorIndex = separators?seq_index_of(g.initial)>
    	<#if separatorIndex == -1>
    		<#assign separators = separators + [g.initial]>
    		<a id="${g.initial}"></a>
    		<h3>${g.initial}</h3>
    	</#if>
		<a id="${g.anchor}"></a>
    	<div data-term="${g.term?lower_case}" class="glossary-wrapper">
    		<dt>${g.term}</dt>
    		<dd>${g.definition}</dd>
    	</div>
	</#list>
	</dl>

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

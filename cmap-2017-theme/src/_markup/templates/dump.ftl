<#-- dump.ftl
  --
  -- Generates tree representations of data model items.
  --
  -- Usage:
  -- <#import "dump.ftl" as dumper>
  --
  -- <#assign foo = something.in["your"].data[0].model />
  --
  -- <@dumper.dump foo />
  --
  -- When used within html pages you've to use <pre>-tags to get the wanted
  -- result:
  -- <pre>
  -- <@dumper.dump foo />
  -- <pre>
  -->

<#-- @ftlvariable name=".data_model" type="java.util.Map" -->
<#-- @ftlvariable name="request" type="java.util.Map" -->

<#-- The black_list contains bad hash keys. Any hash key which matches a
  -- black_list entry is prevented from being displayed.
  -->
<#assign black_list = ["class", "request", "downloadURL", "getDownloadURL", "getreader", "getinputstream", "writer"] />

<#--The max depth to recurse when expanding the data model and request vars.-->
<#--If you set this to more than about 5, your machine might melt. Give it a go!-->
<#assign maxdepth = 3>


<#--
  -- The main macro.
  -->

<#macro dump key data>
  <#if data?is_enumerable>
  <p><b>${key}</b>
    <@printList data,[], 0 />
  <#elseif data?is_hash_ex>
  <p><b>${key}</b>
    <@printHashEx data,[] />
  <#else>
  <p><@printItem data!,[], key, false, 0 /></#if>
</#macro>

<#-- private helper macros. it's not recommended to use these macros from
  -- outside the macro library.
  -->

<#macro printList list has_next_array depth>
  <#local counter=0 />
  <#list list as item>
    <#list has_next_array+[true] as has_next><#if !has_next>    <#else>  | </#if></#list>
    <#list has_next_array as has_next><#if !has_next>    <#else>  | </#if></#list><#t>
    <#t><@printItem item!"unk",has_next_array+[item_has_next], counter, false, depth />
    <#local counter = counter + 1/>
  </#list>
</#macro>

<#macro printHashEx hash has_next_array>
	= <code>${(hash.data!(hash.toString()))!"No String Representation"}</code>
<ul>Callable methods:
	<ul>
          <#list hash?keys as key>
            <#list has_next_array+[true] as has_next><#if !has_next>    <#else>  | </#if></#list>
            <#list has_next_array as has_next><#if !has_next>    <#else>  | </#if></#list><#t>
          ${key}
          </#list>
	</ul>
</ul>
</#macro>

<#macro printHashExFull hash has_next_array depth>
  <#list hash?keys as key>
    <#--<#list has_next_array+[true] as has_next><#if !has_next>    <#else>  | </#if></#list>-->
    <#--<#list has_next_array as has_next><#if !has_next>    <#else>  | </#if></#list><#t>-->
    <#t><@printItem hash[key]!,has_next_array+[key_has_next], key, true, depth />
  </#list>
</#macro>


<#macro printItem item has_next_array key full depth>
  <#if (depth > maxdepth) >
    <#return>
  </#if>
<br>
  <#assign tabs = "">
  <#list 0..depth as dt>
    <#assign tabs = tabs + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;">
  </#list>
${tabs}|<br>
<#attempt>
  <#if item?is_method>
  ${tabs}+- <b>${key}</b> = ?? (method)
  <#elseif item?is_enumerable>
  ${tabs}+- <b>${key} (list)</b>
    <@printList item, has_next_array, depth+1 /><#t>
  <#elseif item?is_hash_ex && omit(key?string)><#-- omit bean-wrapped java.lang.Class objects -->
  ${tabs}+- <b>${key} (map)</b> (omitted)
  <#elseif item?is_hash_ex>
  ${tabs}+- <b>${key} (map)</b>
    <#if full>
      <@printHashExFull item, has_next_array, depth+1 /><#t>
    <#else>
      <@printHashEx item, has_next_array /><#t>
    </#if>
  <#elseif item?is_number>
  ${tabs}+- <b>${key} (number)</b> = <code>${item}</code>
  <#elseif item?is_string>
  ${tabs}+- <b>${key} (string)</b> = <code>"${item}"</code>
  <#elseif item?is_boolean>
  ${tabs}+- <b>${key} (boolean)</b> = <code>${item?string}</code>
  <#elseif item?is_date>
  ${tabs}+- <b>${key} (date)</b> = <code>${item?string("yyyy-MM-dd HH:mm:ss zzzz")}</code>
  <#elseif item?is_transform>
  ${tabs}+- <b>${key}</b> = ?? (transform)
  <#elseif item?is_macro>
  ${tabs}+- <b>${key}</b> = ?? (macro)
  <#elseif item?is_hash>
  ${tabs}+- <b>${key}</b> = ?? (hash)
  <#elseif item?is_node>
  ${tabs}+- <b>${key}</b> = ?? (node)
  </#if>
<#recover>
  ${tabs}+- <b>${key}</b> = ?? (failed to resolve, sorry!)
</#attempt>
</#macro>

<#function omit key>
  <#local what = key?lower_case>
  <#list black_list as item>
    <#if what?index_of(item) gte 0>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<h1>All Liferay Variables</h1>

<em>See the bottom for the <code>request</code> variable expansion</em>
<hr>
<#list .data_model?keys as var>
  <#if var?index_of("writer") lt 0>
    <@dump var,.data_model[var] />
  </#if>
</#list>
<hr>
<h1>The <code>request</code> object</h1>

<@printHashExFull request,[], 0 />

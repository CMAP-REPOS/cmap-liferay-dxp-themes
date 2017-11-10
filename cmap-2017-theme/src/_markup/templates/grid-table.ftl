<section class="grid-table-container">
    <table class="grid-table">
        <#if ShowCaption?? && getterUtil.getBoolean(ShowCaption.getData())>
        <caption>
        <#else>
        <caption class="sr-only">
        </#if>
            ${Caption.getData()}
        </caption>
        <#if ShowHeaderRow?? && getterUtil.getBoolean(ShowHeaderRow.getData())>
        <thead>
        <#else>
        <thead class="sr-only">
        </#if>
            <tr>
                <#list HeaderRow.HeaderCell.getSiblings() as HeaderCell>
                <th class="td-xl-${HeaderCell.HeaderCellSize.getData()}">
                    ${HeaderCell.HeaderCellContent.getData()}
                </th>
                </#list>
            </tr>
        </thead>
        <tbody>
            <#list BodyRow.getSiblings() as BodyRow>
            <tr>
                <#list BodyRow.BodyCell.getSiblings() as BodyCell>
                <#assign cellIndex = BodyCell?index>
                <#assign cellHeader = HeaderRow.HeaderCell.getSiblings()[cellIndex]>
                <#assign cellSize = cellHeader.HeaderCellSize.getData()>
                <td class="td-xl-${cellSize}">
                    ${BodyCell.getData()}
                </td>
                </#list>
            </tr>        
            </#list>
        </tbody>
    </table>
</section>
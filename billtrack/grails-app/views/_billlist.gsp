<div class="list">
    <table>
        <thead>
            <tr>
            
       	        <g:sortableColumn property="createdDate" title="Date" defaultOrder="desc" />
            
       	        <g:sortableColumn property="address" title="Address" />
       	        
       	        <th>Payer</th>
            
       	        <g:sortableColumn property="cost" title="Cost" />
            
       	        <g:sortableColumn property="checkOut" title="CheckOut" />
            
            	<th>Show</th>
            	
            </tr>
        </thead>
        <tbody>
        <g:each in="${billInstanceList}" status="i" var="billInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            
                <td><g:formatDate format="yyyy-MM-dd" date="${billInstance.createdDate}" /></td>
            
                <td>${fieldValue(bean:billInstance, field:'address')}</td>
                
                <td>${billInstance.payer.encodeAsHTML()}</td>
            
                <td>${fieldValue(bean:billInstance, field:'cost')}</td>
            
            	<td class="${ifTrue(!billInstance.checkOut,'highlight','')}">${ifTrue(billInstance.checkOut,'Yes','No')}</td>
            	
            	<td><g:link controller="bill" action="${ifTrue(billInstance.payer==User,'edit','show')}" id="${billInstance.id}">show</g:link></td>
            	
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<div class="paginateButtons">
	<g:if test="${!SimpleMode}">
    <g:paginate total="${billInstanceTotal}" />
    </g:if>
</div>
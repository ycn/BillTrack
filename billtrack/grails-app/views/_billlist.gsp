<div class="list">
    <table>
        <thead>
            <tr>
            
       	        <g:if test="${SimpleMode}"><th>Date</th></g:if><g:else><g:sortableColumn property="createdDate" title="Date" defaultOrder="desc" /></g:else>
            
       	        <g:if test="${SimpleMode}"><th>Address</th></g:if><g:else><g:sortableColumn property="address" title="Address" /></g:else>
       	        
       	        <g:if test="${SimpleMode}"><th>Payer</th></g:if><g:else><th>Comment</th></g:else>
       	        
       	        <g:if test="${SimpleMode}"><th>Cost</th></g:if><g:else><g:sortableColumn property="cost" title="Cost" /></g:else>
            
       	        <g:if test="${!SimpleMode}"><g:sortableColumn property="checkOut" title="CheckOut" /></g:if>
       	        
            	<th>Show</th>
            	
            </tr>
        </thead>
        <tbody>
        <g:each in="${billInstanceList}" status="i" var="billInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            
                <td><g:formatDate format="yyyy-MM-dd" date="${billInstance.createdDate}" /></td>
            
                <td>${fieldValue(bean:billInstance, field:'address')}</td>
                
                <g:if test="${SimpleMode}"><td>${billInstance.payer.encodeAsHTML()}</td></g:if><g:else><td>${fieldValue(bean:billInstance, field:'comment')}</td></g:else>
                
                <td>${fieldValue(bean:billInstance, field:'cost')}</td>
            
            	<g:if test="${!SimpleMode}"><td class="${ifTrue(!billInstance.checkOut,'highlight','')}">${ifTrue(billInstance.checkOut,'Yes','No')}</td></g:if>
            	
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
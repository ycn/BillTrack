<div class="list">
 <table>
     <thead>
         <tr>
         
         		<g:if test="${SimpleMode}"><th>Date</th></g:if><g:else><g:sortableColumn property="createdDate" title="Date" defaultOrder="desc" /></g:else>
         
    	        <th>Bill</th>
    	    
    	    	<th>Comment</th>
    	    	
    	        <g:if test="${SimpleMode}"><th>Cost</th></g:if><g:else><g:sortableColumn property="cost" title="Cost" /></g:else>
         
    	        <g:if test="${!SimpleMode}"><g:sortableColumn property="confirmed" title="Confirmed" /></g:if>
    	        
    	        <th>Show</th>
    	        
         </tr>
     </thead>
     <tbody>
     <g:each in="${accountInstanceList}" status="i" var="accountInstance">
         <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
             
             <td><g:formatDate format="yyyy-MM-dd" date="${accountInstance.bill.createdDate}" /></td>
         
             <td>${fieldValue(bean:accountInstance, field:'bill')}</td>
             
             <td>${fieldValue(bean:accountInstance, field:'comment')}</td>
             
             <td>${fieldValue(bean:accountInstance, field:'cost')}</td>
         
             <g:if test="${!SimpleMode}"><td class="${ifTrue(!accountInstance.confirmed,'highlight','')}">${ifTrue(accountInstance.confirmed,'Yes','No')}</td></g:if>
             
             <td><g:link controller="account" action="${ifTrue(accountInstance.consumer==User,'edit','show')}" id="${accountInstance.id}">show</g:link></td>
            
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<div class="paginateButtons">
	<g:if test="${!SimpleMode}">
    <g:paginate total="${accountInstanceTotal}" />
    </g:if>
</div>
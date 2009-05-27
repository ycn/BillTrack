<div class="list">
 <table>
     <thead>
         <tr>
         
         		<g:sortableColumn property="createdDate" title="Date" defaultOrder="desc" />
         
    	        <th>Bill</th>
    	    
    	    	<th>Consumer</th>
    	    	
    	        <g:sortableColumn property="cost" title="Cost" />
         
    	        <g:sortableColumn property="confirmed" title="Confirmed" />
    	        
    	        <th>Show</th>
    	        
         </tr>
     </thead>
     <tbody>
     <g:each in="${accountInstanceList}" status="i" var="accountInstance">
         <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
             
             <td><g:formatDate format="yyyy-MM-dd" date="${accountInstance.bill.createdDate}" /></td>
         
             <td>${fieldValue(bean:accountInstance, field:'bill')}</td>
             
             <td>${accountInstance.consumer.encodeAsHTML()}</td>
         
             <td>${fieldValue(bean:accountInstance, field:'cost')}</td>
         
             <td class="${ifTrue(!accountInstance.confirmed, 'highlight')}">${fieldValue(bean:accountInstance, field:'confirmed')}</td>
             
             <td><g:link controller="account" action="show" id="${accountInstance.id}">show</g:link></td>
            
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<div class="paginateButtons">
    <g:paginate total="${accountInstanceTotal}" />
</div>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Check Out</title>
    </head>
    <body>
        <div class="body">
            <h1>Check Out ( ${billInstanceTotal} ) </h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form action="checkoutresult" method="post" >
            <div class="list">
		    <table>
		        <thead>
		            <tr>
		            
		       	        <g:sortableColumn property="createdDate" title="Date" defaultOrder="desc" />
		            
		       	        <g:sortableColumn property="address" title="Address" />
		       	        
		       	        <th>Payer</th>
		       	        
		       	        <th>Comment</th>
		       	        
		       	        <g:sortableColumn property="cost" title="Cost" />
		       	        
		       	        <th>Confirmed</th>
		       	        
		            	<th>Show</th>
		       	        
		       	        <g:sortableColumn property="checkOut" title="CheckOut" />
		            	
		            </tr>
		        </thead>
		        <tbody>
		        <g:each in="${billInstanceList}" status="i" var="billInstance">
		            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		            
		                <td><g:formatDate format="yyyy-MM-dd" date="${billInstance.createdDate}" /></td>
		            
		                <td>${fieldValue(bean:billInstance, field:'address')}</td>
		                
		                <td>${billInstance.payer.encodeAsHTML()}</td>
		                
		                <td>${fieldValue(bean:billInstance, field:'comment')}</td>
		                
		                <td>${fieldValue(bean:billInstance, field:'cost')}</td>
		                
		                <td>
		                	<span class="${ifTrue(map.get(i).confirmed_num!=billInstance.accounts.size(),'highlight','')}">
		                	${map.get(i).confirmed_num} / ${billInstance.accounts.size()}</span>
		                	<span class="${ifTrue(map.get(i).confirmed_cost!=billInstance.cost,'highlight','')}">
		                	 ( sum: ${map.get(i).confirmed_cost} ) </span>
		                </td>
		            
		            	<td><g:link controller="bill" action="show" id="${billInstance.id}">show</g:link></td>
		            	
		            	<td><input type="checkbox" checked="checked" name="${billInstance.id}" onclick="checkOut(this,'${billInstance.id}');" /></td>
		            	
		            </tr>
		        </g:each>
		        </tbody>
		    </table>
			</div>
			<div class="paginateButtons"></div>
			<div class="buttons">
                <span class="button"><input type="submit" onclick="return confirm('Are you sure?');" value="CheckOut" /></span>
            </div>
        	</g:form>
        </div>
    </body>
</html>

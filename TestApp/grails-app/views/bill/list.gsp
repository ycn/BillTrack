

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Bill List</title>
    </head>
    <body>
        <div class="body">
            <h1>Bill List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="address" title="Address" />
                        
                   	        <th>Payer</th>
                   	    
                   	        <g:sortableColumn property="cost" title="Cost" />
                        
                   	        <g:sortableColumn property="createdDate" title="Created Date" />
                   	        
                   	        <g:sortableColumn property="checkOut" title="CheckOut" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${billInstanceList}" status="i" var="billInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${billInstance.id}">${fieldValue(bean:billInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:billInstance, field:'address')}</td>
                        
                            <td>${fieldValue(bean:billInstance, field:'payer')}</td>
                        
                            <td>${fieldValue(bean:billInstance, field:'cost')}</td>
                        
                            <td>${fieldValue(bean:billInstance, field:'createdDate')}</td>
                        
                        	<td>${fieldValue(bean:billInstance, field:'checkOut')}</td>
                        	
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${billInstanceTotal}" />
            </div>
        </div>
    </body>
</html>

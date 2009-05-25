

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
                        
                   	        <g:sortableColumn property="createdDate" title="Date" defaultOrder="desc" />
                        
                   	        <g:sortableColumn property="address" title="Address" />
                        
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
                        
                            <td>${fieldValue(bean:billInstance, field:'cost')}</td>
                        
                        	<td>${fieldValue(bean:billInstance, field:'checkOut')}</td>
                        	
                        	<td><g:link action="show" id="${billInstance.id}">show</g:link></td>
                        	
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

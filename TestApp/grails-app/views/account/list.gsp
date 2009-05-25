

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Account List</title>
    </head>
    <body>
        <div class="body">
            <h1>Account List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                        	<g:sortableColumn property="createdDate" title="Date" defaultOrder="desc" />
                        
                   	        <th>Bill</th>
                   	    
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
                        
                            <td>${fieldValue(bean:accountInstance, field:'cost')}</td>
                        
                            <td>${fieldValue(bean:accountInstance, field:'confirmed')}</td>
                            
                            <td><g:link action="show" id="${accountInstance.id}">show</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${accountInstanceTotal}" />
            </div>
        </div>
    </body>
</html>

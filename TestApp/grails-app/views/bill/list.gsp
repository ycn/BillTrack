

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Bill List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Bill</g:link></span>
        </div>
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
                        
                   	        <g:sortableColumn property="cost" title="Cost" />
                        
                   	        <th>Payer</th>
                   	    
                   	        <g:sortableColumn property="comment" title="Comment" />
                        
                   	        <g:sortableColumn property="createdDate" title="Created Date" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${billInstanceList}" status="i" var="billInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${billInstance.id}">${fieldValue(bean:billInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:billInstance, field:'address')}</td>
                        
                            <td>${fieldValue(bean:billInstance, field:'cost')}</td>
                        
                            <td>${fieldValue(bean:billInstance, field:'payer')}</td>
                        
                            <td>${fieldValue(bean:billInstance, field:'comment')}</td>
                        
                            <td>${fieldValue(bean:billInstance, field:'createdDate')}</td>
                        
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

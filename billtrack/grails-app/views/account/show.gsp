

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Show Account</title>
    </head>
    <body>
    	<div class="nav">
            <span class="menuButton"><g:link controller="bill" action="${ifTrue(accountInstance.bill.payer==User,'edit','show')}" id="${accountInstance.bill.id}">Back to Bill</g:link></span>
        </div>
        <div class="body">
            <h1>Show Account</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name">Bill:</td>
                            
                            <td valign="top" class="value"><g:link controller="bill" action="${ifTrue(accountInstance.bill.payer==User,'edit','show')}" id="${accountInstance?.bill?.id}">${accountInstance?.bill?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Consumer:</td>
                            
                            <td valign="top" class="value">${accountInstance?.consumer?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Cost:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:accountInstance, field:'cost')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Comment:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:accountInstance, field:'comment')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Confirmed:</td>
                            
                            <td valign="top" class="value ${ifTrue(!accountInstance.confirmed,'highlight','')}">${ifTrue(accountInstance.confirmed,'Yes','No')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Confirmed Date:</td>
                            
                            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${accountInstance?.confirmedDate}" /></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>

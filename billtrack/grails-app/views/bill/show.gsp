

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Show Bill</title>
    </head>
    <body>
    	<div class="nav">
            <span class="menuButton"><g:link controller="person" action="home">Home</g:link></span>
        </div>
        <div class="body">
            <h1>Show Bill</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Address:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:billInstance, field:'address')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Payer:</td>
                            
                            <td valign="top" class="value">${billInstance?.payer?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Cost:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:billInstance, field:'cost')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Comment:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:billInstance, field:'comment')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Created Date:</td>
                            
                            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${billInstance?.createdDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Check Out:</td>
                            
                            <td valign="top" class="value ${ifTrue(!billInstance.checkOut,'highlight','')}">${ifTrue(billInstance.checkOut,'Yes','No')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Check Out Date:</td>
                            
                            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${billInstance?.checkOutDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Accounts:</td>
                            
                            <td  valign="top" style="text-align:left;" class="value">
                                <ul>
                                <g:each var="a" in="${billInstance.accounts}">
                                    <li><g:link controller="account" action="${ifTrue(a.consumer==User,'edit','show')}" id="${a.id}">${a?.encodeAsHTML()}</g:link>
                                    ${ifTrue(!a.confirmed, '&nbsp;&nbsp;<span class=\"highlight\">Not confirmed</span>','')}</li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>

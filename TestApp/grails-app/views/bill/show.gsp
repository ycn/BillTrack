

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show Bill</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Bill List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Bill</g:link></span>
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
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:billInstance, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Address:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:billInstance, field:'address')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Cost:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:billInstance, field:'cost')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Payer:</td>
                            
                            <td valign="top" class="value"><g:link controller="person" action="show" id="${billInstance?.payer?.id}">${billInstance?.payer?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Comment:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:billInstance, field:'comment')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Created Date:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:billInstance, field:'createdDate')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Check Out:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:billInstance, field:'checkOut')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Check Out Date:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:billInstance, field:'checkOutDate')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Accounts:</td>
                            
                            <td  valign="top" style="text-align:left;" class="value">
                                <ul>
                                <g:each var="a" in="${billInstance.accounts}">
                                    <li><g:link controller="account" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Optionals:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:billInstance, field:'optionals')}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${billInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>

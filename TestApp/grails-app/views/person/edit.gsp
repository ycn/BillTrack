

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Edit Person</title>
    </head>
    <body>
        <div class="body">
            <h1>Edit Person</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${personInstance}">
            <div class="errors">
                <g:renderErrors bean="${personInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${personInstance?.id}" />
                <input type="hidden" name="version" value="${personInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:personInstance,field:'name','errors')}">
                                    <input type="text" maxlength="30" id="name" name="name" value="${fieldValue(bean:personInstance,field:'name')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accounts">Accounts:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:personInstance,field:'accounts','errors')}">
                                    
<ul>
<g:each var="a" in="${personInstance?.accounts?}">
    <li><g:link controller="account" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="account" params="['person.id':personInstance?.id]" action="create">Add Account</g:link>

                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paidBills">Paid Bills:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:personInstance,field:'paidBills','errors')}">
                                    
<ul>
<g:each var="p" in="${personInstance?.paidBills?}">
    <li><g:link controller="bill" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="bill" params="['person.id':personInstance?.id]" action="create">Add Bill</g:link>

                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>

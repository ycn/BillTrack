

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit Bill</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Bill List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Bill</g:link></span>
        </div>
        <div class="body">
            <h1>Edit Bill</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${billInstance}">
            <div class="errors">
                <g:renderErrors bean="${billInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${billInstance?.id}" />
                <input type="hidden" name="version" value="${billInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="address">Address:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'address','errors')}">
                                    <input type="text" id="address" name="address" value="${fieldValue(bean:billInstance,field:'address')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="cost">Cost:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'cost','errors')}">
                                    <input type="text" id="cost" name="cost" value="${fieldValue(bean:billInstance,field:'cost')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="payer">Payer:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'payer','errors')}">
                                    <g:select optionKey="id" from="${Person.list()}" name="payer.id" value="${billInstance?.payer?.id}" ></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comment">Comment:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'comment','errors')}">
                                    <input type="text" id="comment" name="comment" value="${fieldValue(bean:billInstance,field:'comment')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createdDate">Created Date:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'createdDate','errors')}">
                                    <g:datePicker name="createdDate" value="${billInstance?.createdDate}" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="checkOut">Check Out:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'checkOut','errors')}">
                                    <g:checkBox name="checkOut" value="${billInstance?.checkOut}" ></g:checkBox>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="checkOutDate">Check Out Date:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'checkOutDate','errors')}">
                                    <g:datePicker name="checkOutDate" value="${billInstance?.checkOutDate}" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accounts">Accounts:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'accounts','errors')}">
                                    
<ul>
<g:each var="a" in="${billInstance?.accounts?}">
    <li><g:link controller="account" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="account" params="['bill.id':billInstance?.id]" action="create">Add Account</g:link>

                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="optionals">Optionals:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'optionals','errors')}">
                                    
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
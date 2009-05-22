

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Edit Account</title>
    </head>
    <body>
        <div class="body">
            <h1>Edit Account</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${accountInstance}">
            <div class="errors">
                <g:renderErrors bean="${accountInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${accountInstance?.id}" />
                <input type="hidden" name="version" value="${accountInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bill">Bill:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:accountInstance,field:'bill','errors')}">
                                    <g:select optionKey="id" from="${Bill.list()}" name="bill.id" value="${accountInstance?.bill?.id}" ></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="consumer">Consumer:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:accountInstance,field:'consumer','errors')}">
                                    <g:select optionKey="id" from="${Person.list()}" name="consumer.id" value="${accountInstance?.consumer?.id}" ></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="cost">Cost:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:accountInstance,field:'cost','errors')}">
                                    <input type="text" id="cost" name="cost" value="${fieldValue(bean:accountInstance,field:'cost')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comment">Comment:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:accountInstance,field:'comment','errors')}">
                                    <textarea rows="5" cols="40" name="comment">${fieldValue(bean:accountInstance, field:'comment')}</textarea>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="confirmed">Confirmed:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:accountInstance,field:'confirmed','errors')}">
                                    <g:checkBox name="confirmed" value="${accountInstance?.confirmed}" ></g:checkBox>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="confirmedDate">Confirmed Date:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:accountInstance,field:'confirmedDate','errors')}">
                                	<g:formatDate format="yyyy-MM-dd" date="${accountInstance?.confirmedDate}" />
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

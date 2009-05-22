

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Create Bill</title>         
    </head>
    <body>
        <div class="body">
            <h1>Create Bill</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${billInstance}">
            <div class="errors">
                <g:renderErrors bean="${billInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="address">Address:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'address','errors')}">
                                    <input type="text" maxlength="200" id="address" name="address" value="${fieldValue(bean:billInstance,field:'address')}"/>
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
                                    <label for="cost">Cost:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'cost','errors')}">
                                    <input type="text" id="cost" name="cost" value="${fieldValue(bean:billInstance,field:'cost')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comment">Comment:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'comment','errors')}">
                                    <textarea rows="5" cols="40" name="comment">${fieldValue(bean:billInstance, field:'comment')}</textarea>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createdDate">Created Date:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:billInstance,field:'createdDate','errors')}">
                                    <g:formatDate format="yyyy-MM-dd" date="${billInstance?.createdDate}" />
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
                                	<g:formatDate format="yyyy-MM-dd" date="${billInstance?.checkOutDate}" />
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>

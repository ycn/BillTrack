

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Create Account</title>         
    </head>
    <body>
    	<div class="nav">
            <span class="menuButton"><g:link controller="bill" action="edit" id="${accountInstance?.bill?.id}">Back</g:link></span>
        </div>
        <div class="body">
            <h1>Create Account</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${accountInstance}">
            <div class="errors">
                <g:renderErrors bean="${accountInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                        	<g:hiddenField name="bill.id" value="${accountInstance?.bill?.id}" />
                        	
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="consumer">Consumer:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:accountInstance,field:'consumer','errors')}">
                                    <g:select optionKey="id" from="${PersonList}" name="consumer.id" value="${accountInstance?.consumer?.id}" ></g:select>
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

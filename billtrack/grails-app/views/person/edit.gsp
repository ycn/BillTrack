

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Edit Settings</title>
    </head>
    <body>
        <div class="body">
            <h1>Edit Settings</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${User}">
            <div class="errors">
                <g:renderErrors bean="${User}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${User?.id}" />
                <input type="hidden" name="version" value="${User?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:User,field:'name','errors')}">
                                	<input type="text" maxlength="20" id="name" name="name" value="${fieldValue(bean:User,field:'name')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accounts">New Password:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:User,field:'password','errors')}">
                                    <input type="password" maxlength="20" id="password" name="password" value=""/>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>

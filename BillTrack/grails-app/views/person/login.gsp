

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Please Log In</title>         
    </head>
    <body>
        <div class="body">
            <h1>Please Log In</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${personInstance}">
            <div class="errors">
                <g:renderErrors bean="${personInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:if test="${!session.UserID}">
            <g:form action="login" method="post" >
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
                                    <label for="name">Password:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:personInstance,field:'password','errors')}">
                                    <input type="password" maxlength="20" id="password" name="password" value="${fieldValue(bean:personInstance,field:'password')}"/>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Login" /></span>
                </div>
            </g:form>
            </g:if>
        </div>
    </body>
</html>

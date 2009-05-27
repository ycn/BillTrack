

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Bill List</title>
    </head>
    <body>
        <div class="body">
            <h1>Bill List ( ${billInstanceTotal} ) </h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:render template="/billlist" />
        </div>
    </body>
</html>

<html>
    <head>
        <title>Bill Track</title>
		<meta name="layout" content="billtrack" />
    </head>
    <body>
        <h1>Welcome to Bill Track</h1>
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <g:if test="${session.UserID}">
        	<div class="welcome-title">Hello ${session.UserName} !</div>
			<div class="action-button"><g:link controller="bill" action="create">Create Today's Bill</g:link></div>
			<div class="action-button"><g:link controller="checkout">Check Out</g:link></div>
        </g:if>
    </body>
</html>
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
        	<h3>Hello ${user.name}! Today is <g:formatDate format="yyyy-MM-dd" date="${now}" />.</h3>
        	<br />
			<h4>Accounts to confirm ( ${accountInstanceTotal} ) </h4>
			<g:render template="/accountlist" />
			<br />
			<h4>Recent Bills to check out ( ${billInstanceTotal} ) </h4>
			<g:render template="/billlist" />
        </g:if>
    </body>
</html>
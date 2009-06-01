<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="billtrack" />
        <title>Check Out Result</title>
    </head>
    <body>
        <div class="body">
            <h1>Check Out ${checkout_num} Bills</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
			 <table>
			     <thead>
			         <tr>
			         	<th>Name</th>
			         	<th>Consumed</th>
			         	<th>Paid</th>
			         	<th>Diff</th>
			         </tr>
			     </thead>
			     <tbody>
			     <g:each in="${users}" status="i" var="user">
			         <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			         	<td>${user}</td>
			         	<td>${consumedmap.get(user, 0)}</td>
			         	<td>${paidmap.get(user, 0)}</td>
			         	<td>${paidmap.get(user, 0) - consumedmap.get(user, 0)}</td>
			         </tr>
		         </g:each>
		         </tbody>
		     </table>
		    </div>
		    <div class="paginateButtons"></div>
        </div>
    </body>
</html>
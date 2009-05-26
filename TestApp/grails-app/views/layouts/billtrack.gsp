<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
	<meta content="Bill Track" name="description" />
	<title><g:layoutTitle default="Bill Track" /></title>
	<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'billtrack.css')}" />
	<link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
	<g:layoutHead />
    <g:javascript library="billtrack" />
</head>
<body>
	<div id="container">
		<div id="spinner" class="spinner" style="display:none;">
            <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>
		<div id="header"></div>
		<table class="columns" cellspacing="0">
		<tbody>
		<tr>
			<td id="content" class="column round-left">
				<g:layoutBody />
			</td>
			<td id="sidebar" class="column round-right">
				<g:if test="${session.UserID}">
					<div class="welcome-title">From <g:formatDate format="yyyy-MM-dd" date="${session.toCheckOutDate}" /> till now</div>
					<div class="welcome-title">Total Paid : ${session.totalPaid}</div>
					<div class="welcome-title">Total Consumed : ${session.totalConsumed}</div>
					<div class="action-button"><g:link controller="bill" action="create">Create Today's Bill</g:link></div>
					<div class="action-button"><g:link controller="bill" action="checkout">Check Out</g:link></div>
				</g:if>
			</td>
		</tr>
		</tbody>
		</table>
		<div id="footer" class="round">
			<ul>
				<li class="first">&copy; 2009 SX</li>
				<li><a>About Us</a></li>
				<li><a>Statistics</a></li>
				<li><a>Help</a></li>
				<li><a>Privacy</a></li>
			</ul>
		</div>
		<div id="navigation">
			<ul class="round">
				<li><g:link controller="person" action="home">Home</g:link></li>
				<li><a>Graph</a></li>
				<g:if test="${!session.UserID}">
					<li class="last"><g:link controller="person" action="login">Log in</g:link></li>
				</g:if>
				<g:else>
					<li><g:link controller="person" action="edit">Settings</g:link></li>
					<li><g:link controller="account" action="list">Accounts</g:link></li>
					<li><g:link controller="bill" action="list">Paid Bills</g:link></li>
					<li class="last"><g:link controller="person" action="logout">Log out</g:link></li>
				</g:else>
			</ul>
		</div>
	</div>
</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
	<meta content="en-us" http-equiv="Content-Language" />
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
				<li><a href="${createLinkTo(dir:'')}">Home</a></li>
				<li><a>Graph</a></li>
				<li class="last"><a>Sign out</a></li>
			</ul>
		</div>
	</div>
</body>
</html>
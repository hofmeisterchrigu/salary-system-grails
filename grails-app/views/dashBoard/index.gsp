<%@ page import="com.deerwalk.dss.Employee" %>
<!doctype html>
<html xmlns="http://www.w3.org/1999/html">
<head>
      <meta name="layout" content="bootstrap">
      <title>DeerWalk Salary System - DashBoard</title>
      <link rel="stylesheet" type="text/css" href='${resource(dir: 'css',file: 'bootstrap.css')}' />
      <script type="text/javascript" href='${resource(dir: 'js',file: 'bootstrap.js')}'></script>
</head>
<body>
<div>
      <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
      </g:if>
      <g:render template="/dashBoard/dashBoardIndex"/>
</div>
</body>
</html>


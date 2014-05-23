<%@ page import=" org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes" %>
<!doctype html>
<html lang="en">
<head>
      <meta charset="utf-8">
      <title><g:layoutTitle default="${meta(name: 'app.name')}"/></title>
      <meta name="description" content="">
      <meta name="author" content="">
      <meta name="viewport" content="initial-scale = 1.0">

      <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
      <!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->

      <r:require modules="scaffolding"/>
      <!-- Le fav and touch icons -->
      <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
      <g:layoutHead/>
      <r:layoutResources/>
</head>

<body>

<nav class="navbar navbar-fixed-top">
      <div class="navbar-inner">
            <div class="container-fluid">
                  <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                  </a>

                  <a class="brand" href="${createLink(uri: '/')}">
                        <img class="brand" src="${resource(dir: 'images', file: 'logo.png')}"/>
                  </a>

                  <div class="nav-collapse">
                        <ul class="nav">
                              <sec:ifLoggedIn>
                                    <sec:ifAllGranted roles="ROLE_USER">
                                          <li <%= controllerName == "employee" ? ' class="active"' : '' %>><g:link controller="employee" action="index">Employee</g:link> </li>
                                          <li <%= controllerName == "payRoll" ? ' class="active"' : '' %>><g:link controller="payRoll" action="index">Payroll</g:link> </li>
                                          <li <%= controllerName == "payRollDetail" ? ' class="active"' : '' %>><g:link controller="payRollDetail" action="index">Payroll Details</g:link> </li>
                                          <li <%= controllerName == "salaryConfiguration" ? ' class="active"' : '' %>><g:link controller="salaryConfiguration" action="index">Settings</g:link> </li>
                                          <li><g:link controller="dashBoard" action="exportData" target="_blank">BackUp DB</g:link> </li>
                                    </sec:ifAllGranted>
                                    <sec:ifAllGranted roles="ROLE_ADMIN">
                                          <li <%= controllerName == "dssUser" ? ' class="active"' : '' %>><g:link controller="dssUser" action="index">User</g:link> </li>
                                    </sec:ifAllGranted>
                              </sec:ifLoggedIn>
                        %{--<li<%= request.forwardURI == "${createLink(uri: '/')}" ? ' class="active"' : '' %>><a href="${createLink(uri: '/')}">Home</a></li>
                        <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
                            <li<%= c.logicalPropertyName == controllerName ? ' class="active"' : '' %>><g:link controller="${c.logicalPropertyName}">${c.naturalName}</g:link></li>
                        </g:each>--}%
                        </ul>
                        <div id="login">
                              <div><sec:ifLoggedIn>
                              %{--<g:link controller="generalSettings" action="changePassword" class="welcomeuser" style="margin-right:5px;">--}%
                                    <a href="#changePasswordModel"  class="welcomeuser" style="margin-right:10px;" role="button" data-toggle="modal" title="Change password">
                                         <dss:fullName/>
                                    </a>
                              %{--</g:link>--}%
                                    <g:link controller="logout"><img src="<g:resource file='images/logout.png' />">
                                          Log Out </g:link>
                              </sec:ifLoggedIn>
                              </div>
                        </div>
                  </div>
            </div>
      </div>
</nav>
<sec:ifLoggedIn>
      <div style="margin-top: 40px">
            %{--<g:render template="/dashBoard/dashBoardIndex">
            </g:render>--}%
      </div>
</sec:ifLoggedIn>
<%
      def actionMap = ['providentFund':'Generate Provident Fund Report',
              'socialSecurityExport':'Generate Social Security Tax Report',
              'salaryReport':'Generate Salary Report',
              'citGenerator':'Generate CIT Report',
              'incomeTaxExport':'Generate Income Tax Report'
      ]
%>
<div class="subNav">
      <div class="OtherPageNav" id="subMenu" style="display:none;">
            <ul>
                  <g:each in="${actionMap}" var="reports">
                        <g:if test="${reports.key!=params.action}">
                              <li><g:link controller="dashBoard" action="${reports.key}">${reports.value}</g:link></li>
                              <li class="seperater">|</li>
                        </g:if>
                  </g:each>
            %{--<li><g:link controller="dashBoard" action="providentFund">Generate PF Report</g:link></li>
            <li class="seperater">|</li>
            <li><g:link controller="dashBoard" action="socialSecurityExport">Generate Social Security Tax report</g:link></li>
            <li class="seperater">|</li>
            <li><g:link  controller="dashBoard" action="salaryReport">Generate Salary report</g:link></li>
            <li class="seperater">|</li>
            <li><g:link  controller="dashBoard" action="citGenerator">Generate CIT report</g:link></li>
            <li class="seperater">|</li>
            <li><g:link  controller="dashBoard" action="incomeTaxExport">Generate Income Tax report</g:link></li>--}%
            %{--<li class="seperater">|</li>
            <li><g:link>Generate Employee Statement</g:link></li>--}%
            </ul>
      </div>
      <h1 class="title">${actionMap.get(params.action)}</h1>
      <div class="dateSearch input-append" id="dateInLayout">
            %{--<g:form name="socialSecurityExport" action="socialSecurityExport" method="post">
                <select>
                    <option>1</option>
                </select>
                <select>
                    <option>1</option>
                </select>
                <g:select name="month" from="${Month.values()}" noSelection="['':'--Select Month--']" id="month" optionKey="${key}" optionValue="value" value="${params?.month}"/>
                <g:select name="year" from="${yearList}" noSelection="['':'--Select Year--']" id="year" value="${params?.year}"/>
                <input type="submit" style="display: none;"/>
                <button class="btn" type="submit">Go!</button>
            </g:form>--}%
      </div>
      <div style="clear:both;"></div>
</div>
<div class="container-fluid" >
      <g:layoutBody/>

      <sec:ifLoggedIn>
            <g:render template="/model/changePassword"/>
      </sec:ifLoggedIn>
      <footer>
            <div class="footer">&copy; Deerwalk Services 2013</div>
      </footer>
</div>
<r:layoutResources/>
<script>
      $( "h1.title" ).click(function() {
            $( "#subMenu" ).slideToggle( "slow" );
      });
</script>
</body>
</html>
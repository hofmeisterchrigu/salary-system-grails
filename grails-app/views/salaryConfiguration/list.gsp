
<%@ page import="com.deerwalk.dss.SalaryConfiguration" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'salaryConfiguration.label', default: 'SalaryConfiguration')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row-fluid">
			
			<div class="span3">
				<div class="well">
					<ul class="nav nav-list">
						<li class="nav-header">${entityName}</li>
						<li class="active">
							<g:link class="list" action="list">
								<i class="icon-list icon-white"></i>
								<g:message code="default.list.label" args="[entityName]" />
							</g:link>
						</li>
						<li>
							<g:link class="create" action="create">
								<i class="icon-plus"></i>
								<g:message code="default.create.label" args="[entityName]" />
							</g:link>
						</li>
					</ul>
				</div>
			</div>

			<div class="span9">
				
				<div class="page-header">
					<h1><g:message code="default.list.label" args="[entityName]" /></h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>
				
				<table class="table table-striped">
					<thead>
						<tr>
						
							<g:sortableColumn property="particular" title="${message(code: 'salaryConfiguration.particular.label', default: 'Particular')}" />
						
							<g:sortableColumn property="particularValue" title="${message(code: 'salaryConfiguration.particularValue.label', default: 'Particular Value')}" />
						
							%{--<g:sortableColumn property="type" title="${message(code: 'salaryConfiguration.type.label', default: 'Type')}" />--}%
						
							<th></th>
						</tr>
					</thead>
					<tbody>
					<g:each in="${salaryConfigurationInstanceList}" var="salaryConfigurationInstance">
						<tr>
						
							<td>${fieldValue(bean: salaryConfigurationInstance, field: "particular")}</td>
						
							<td>${fieldValue(bean: salaryConfigurationInstance, field: "particularValue")}</td>
						
							%{--<td>${fieldValue(bean: salaryConfigurationInstance, field: "type")}</td>--}%
						
							<td class="link">
								<g:link action="show" id="${salaryConfigurationInstance.id}" class="btn btn-small">Show &raquo;</g:link>
							</td>
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<bootstrap:paginate total="${salaryConfigurationInstanceTotal}" />
				</div>
			</div>

		</div>
	</body>
</html>

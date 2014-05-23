
<%@ page import="com.deerwalk.dss.Employee" %>
<!doctype html>
<html>
<head>
	<meta name="layout" content="bootstrap">
	<g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
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
				<th></th>
				<g:sortableColumn property="uniqueEmployeeId" title="${message(code: 'employee.uniqueEmployeeId.label', default: 'Id')}" />

				<g:sortableColumn property="employeeFirstName" title="${message(code: 'employee.employeeFirstName.label', default: 'First Name')}" />

				<g:sortableColumn property="employeeMiddleName" title="${message(code: 'employee.employeeMiddleName.label', default: 'Middle Name')}" />

				<g:sortableColumn property="employeeLastName" title="${message(code: 'employee.employeeLastName.label', default: 'Last Name')}" />

				<g:sortableColumn property="phoneNumber" title="${message(code: 'employee.phoneNumber.label', default: 'Phone Number')}" />

				<g:sortableColumn property="designation" title="${message(code: 'employee.designation.label', default: 'Designation')}" />

				<th></th>
			</tr>
			</thead>
			<tbody>
			<g:each in="${employeeInstanceList}" var="employeeInstance">
				<tr>
					<td>
						<g:link action="show" id="${employeeInstance.id}"><img src="${resource(dir: "images/skin",file:"database_table.png")}"/></g:link>
						<g:link action="edit" id="${employeeInstance.id}"><img src="${resource(dir: "images/skin",file:"database_edit.png")}"/></g:link>
						<g:link action="delete" id="${employeeInstance.id}"><img src="${resource(dir: "images/skin",file:"cross.png")}"/></g:link>
					</td>
					<td>${fieldValue(bean: employeeInstance, field: "uniqueEmployeeId")}</td>

					<td>${fieldValue(bean: employeeInstance, field: "employeeFirstName")}</td>

					<td>${fieldValue(bean: employeeInstance, field: "employeeMiddleName")}</td>

					<td>${fieldValue(bean: employeeInstance, field: "employeeLastName")}</td>

					<td>${fieldValue(bean: employeeInstance, field: "phoneNumber")}</td>

					<td>${fieldValue(bean: employeeInstance, field: "designation")}</td>

					%{--<td class="link">
						<g:link action="show" id="${employeeInstance.id}" class="btn btn-small">Show &raquo;</g:link>
					</td>--}%
					<td class="link">
						<g:link controller="dashBoard" action="employeeDetails" id="${employeeInstance.id}" class="btn btn-small">Details &raquo;</g:link>
					</td>
				</tr>
			</g:each>
			</tbody>
		</table>
		<div class="pagination">
			<bootstrap:paginate total="${employeeInstanceTotal}" />
		</div>
	</div>

</div>
</body>
</html>

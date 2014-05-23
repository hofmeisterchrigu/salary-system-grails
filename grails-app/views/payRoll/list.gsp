
<%@ page import="com.deerwalk.dss.Month; com.deerwalk.dss.PayRoll" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'payRoll.label', default: 'PayRoll')}" />
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
							<g:sortableColumn property="formNumber" title="${message(code: 'payRoll.formNumber.label', default: 'Form Number')}" />
						
							<g:sortableColumn property="year" title="${message(code: 'payRoll.year.label', default: 'Year')}" />
						
							<g:sortableColumn property="com.deerwalk.dss.Month" title="${message(code: 'payRoll.com.deerwalk.dss.Month.label', default: 'Month')}" />
						
							<g:sortableColumn property="description" title="${message(code: 'payRoll.description.label', default: 'Description')}" />
						
							<g:sortableColumn property="salary" title="${message(code: 'payRoll.salary.label', default: 'Salary')}" />
						
							<th></th>
						</tr>
					</thead>
					<tbody>
					<g:each in="${payRollInstanceList}" var="payRollInstance">
						<tr>
							<td>
								<g:link action="show" id="${payRollInstance.id}"><img src="${resource(dir: "images/skin",file:"database_table.png")}"/></g:link>
								<g:link action="edit" id="${payRollInstance.id}"><img src="${resource(dir: "images/skin",file:"database_edit.png")}"/></g:link>
								<g:link action="delete" id="${payRollInstance.id}"><img src="${resource(dir: "images/skin",file:"cross.png")}"/></g:link>
							</td>
							<td>${fieldValue(bean: payRollInstance, field: "formNumber")}</td>
						
							<td>${fieldValue(bean: payRollInstance, field: "year")}</td>
						
							<td>${fieldValue(bean: payRollInstance, field: "month")?Month.valueOf(fieldValue(bean: payRollInstance, field: "month").toString()).getValue():''}</td>
						
							<td>${fieldValue(bean: payRollInstance, field: "description")}</td>
						
							<td>${fieldValue(bean: payRollInstance, field: "salary")}</td>
						
							%{--<td class="link">
								<g:link action="show" id="${payRollInstance.id}" class="btn btn-small">Show &raquo;</g:link>
							</td>--}%
							<td class="link">
								<g:link action="generatePayRollDetails" id="${payRollInstance.id}" class="btn btn-small">Generate Details</g:link>
							</td>
							<td class="link">
								<g:link action="calculateTaxes" id="${payRollInstance.id}" class="btn btn-small">Calculate Taxes</g:link>
							</td>
							<td class="link">
								<g:link action="generateSalaryStatement" id="${payRollInstance.id}" class="btn btn-small">Send Email</g:link>
							</td>
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<bootstrap:paginate total="${payRollInstanceTotal}" />
				</div>
			</div>

		</div>
	</body>
</html>

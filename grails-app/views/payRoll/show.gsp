
<%@ page import="com.deerwalk.dss.PayRoll" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'payRoll.label', default: 'PayRoll')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row-fluid">
			
			<div class="span3">
				<div class="well">
					<ul class="nav nav-list">
						<li class="nav-header">${entityName}</li>
						<li>
							<g:link class="list" action="list">
								<i class="icon-list"></i>
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
					<h1><g:message code="default.show.label" args="[entityName]" /></h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>

				<dl class="showlist">
				
					<g:if test="${payRollInstance?.formNumber}">
						<dt><g:message code="payRoll.formNumber.label" default="Form Number" /></dt>
						
							<dd><g:fieldValue bean="${payRollInstance}" field="formNumber"/></dd>
						
					</g:if>
				
					<g:if test="${payRollInstance?.year}">
						<dt><g:message code="payRoll.year.label" default="Year" /></dt>
						
							<dd><g:fieldValue bean="${payRollInstance}" field="year"/></dd>
						
					</g:if>
				
					<g:if test="${payRollInstance?.month}">
						<dt><g:message code="payRoll.month.label" default="com.deerwalk.dss.Month" /></dt>
						
							<dd><g:fieldValue bean="${payRollInstance}" field="month"/></dd>
						
					</g:if>
				
					<g:if test="${payRollInstance?.description}">
						<dt><g:message code="payRoll.description.label" default="Description" /></dt>
						
							<dd><g:fieldValue bean="${payRollInstance}" field="description"/></dd>
						
					</g:if>
				
					<g:if test="${payRollInstance?.salary}">
						<dt><g:message code="payRoll.salary.label" default="Salary" /></dt>
						
							<dd><g:fieldValue bean="${payRollInstance}" field="salary"/></dd>
						
					</g:if>

					%{--<g:if test="${payRollInstance?.dashainBonus}">--}%
						<dt><g:message code="payRoll.dashainBonus.label" default="Dashain Bonus" /></dt>

							<dd><g:fieldValue bean="${payRollInstance}" field="dashainBonus"/></dd>

					%{--</g:if>--}%
				
				</dl>
				<div class="clear"></div>

				<g:form>
					<g:hiddenField name="id" value="${payRollInstance?.id}" />
					<div class="form-actions">
						<g:link class="btn" action="edit" id="${payRollInstance?.id}">
							<i class="icon-pencil"></i>
							<g:message code="default.button.edit.label" default="Edit" />
						</g:link>
						<button class="btn btn-danger" type="submit" name="_action_delete">
							<i class="icon-trash icon-white"></i>
							<g:message code="default.button.delete.label" default="Delete" />
						</button>
					</div>
				</g:form>

			</div>

		</div>
	</body>
</html>


<%@ page import="com.deerwalk.dss.Employee" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
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
				
					<g:if test="${employeeInstance?.uniqueEmployeeId}">
						<dt><g:message code="employee.uniqueEmployeeId.label" default="Unique Employee Id" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="uniqueEmployeeId"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.employeeFirstName}">
						<dt><g:message code="employee.employeeFirstName.label" default="Employee First Name" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="employeeFirstName"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.employeeMiddleName}">
						<dt><g:message code="employee.employeeMiddleName.label" default="Employee Middle Name" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="employeeMiddleName"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.employeeLastName}">
						<dt><g:message code="employee.employeeLastName.label" default="Employee Last Name" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="employeeLastName"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.phoneNumber}">
						<dt><g:message code="employee.phoneNumber.label" default="Phone Number" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="phoneNumber"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.designation}">
						<dt><g:message code="employee.designation.label" default="Designation" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="designation"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.gender}">
						<dt><g:message code="employee.gender.label" default="Gender" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="gender"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.email}">
						<dt><g:message code="employee.email.label" default="Email" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="email"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.basicScaleAmount}">
						<dt><g:message code="employee.basicScaleAmount.label" default="Basic Scale Amount" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="basicScaleAmount"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.department}">
						<dt><g:message code="employee.department.label" default="Department" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="department"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.isMarried}">
						<dt><g:message code="employee.isMarried.label" default="Is Married" /></dt>
						
							<dd><g:formatBoolean boolean="${employeeInstance?.isMarried}" /></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.disability}">
						<dt><g:message code="employee.disability.label" default="Disability" /></dt>
						
							<dd><g:formatBoolean boolean="${employeeInstance?.disability}" /></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.panNumber}">
						<dt><g:message code="employee.panNumber.label" default="Pan Number" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="panNumber"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.bankAccountNumber}">
						<dt><g:message code="employee.bankAccountNumber.label" default="Bank Account Number" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="bankAccountNumber"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.citNumber}">
						<dt><g:message code="employee.citNumber.label" default="Cit Number" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="citNumber"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.providentFundNumber}">
						<dt><g:message code="employee.providentFundNumber.label" default="Provident Fund Number" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="providentFundNumber"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.citPercentage}">
						<dt><g:message code="employee.citPercentage.label" default="Cit Percentage" /></dt>
						
							<dd><g:fieldValue bean="${employeeInstance}" field="citPercentage"/></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.willGetDashainBonus}">
						<dt><g:message code="employee.willGetDashainBonus.label" default="Will Get Dashain Bonus" /></dt>
						
							<dd><g:formatBoolean boolean="${employeeInstance?.willGetDashainBonus}" /></dd>
						
					</g:if>
				
					<g:if test="${employeeInstance?.willGetPf}">
						<dt><g:message code="employee.willGetPf.label" default="Will Get Pf" /></dt>
						
							<dd><g:formatBoolean boolean="${employeeInstance?.willGetPf}" /></dd>
						
					</g:if>
				
				</dl>
				<div class="clear"></div>

				<g:form>
					<g:hiddenField name="id" value="${employeeInstance?.id}" />
					<div class="form-actions">
						<g:link class="btn" action="edit" id="${employeeInstance?.id}">
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

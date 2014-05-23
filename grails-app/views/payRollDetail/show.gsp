
<%@ page import="com.deerwalk.dss.PayRollDetail" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'payRollDetail.label', default: 'PayRollDetail')}" />
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
				
					<g:if test="${payRollDetailInstance?.employee}">
						<dt><g:message code="payRollDetail.employee.label" default="Employee" /></dt>
						
							<dd><g:link controller="employee" action="show" id="${payRollDetailInstance?.employee?.id}">${payRollDetailInstance?.employee?.encodeAsHTML()}</g:link></dd>
						
					</g:if>
				
					<g:if test="${payRollDetailInstance?.payRoll}">
						<dt><g:message code="payRollDetail.payRoll.label" default="Pay Roll" /></dt>
						
							<dd><g:link controller="payRoll" action="show" id="${payRollDetailInstance?.payRoll?.id}">${payRollDetailInstance?.payRoll?.encodeAsHTML()}</g:link></dd>
						
					</g:if>
				
					<g:if test="${payRollDetailInstance?.basicSalary}">
						<dt><g:message code="payRollDetail.basicSalary.label" default="Basic Salary" /></dt>
						
							<dd><g:fieldValue bean="${payRollDetailInstance}" field="basicSalary"/></dd>
						
					</g:if>
				
					<g:if test="${payRollDetailInstance?.providentFund}">
						<dt><g:message code="payRollDetail.providentFund.label" default="Provident Fund" /></dt>
						
							<dd><g:fieldValue bean="${payRollDetailInstance}" field="providentFund"/></dd>
						
					</g:if>
				
					<g:if test="${payRollDetailInstance?.cit}">
						<dt><g:message code="payRollDetail.cit.label" default="Cit" /></dt>
						
							<dd><g:fieldValue bean="${payRollDetailInstance}" field="cit"/></dd>
						
					</g:if>
				
					<g:if test="${payRollDetailInstance?.socialSecurityTax}">
						<dt><g:message code="payRollDetail.socialSecurityTax.label" default="Social Security Tax" /></dt>
						
							<dd><g:fieldValue bean="${payRollDetailInstance}" field="socialSecurityTax"/></dd>
						
					</g:if>
				
					<g:if test="${payRollDetailInstance?.incomeTax}">
						<dt><g:message code="payRollDetail.incomeTax.label" default="Income Tax" /></dt>
						
							<dd><g:fieldValue bean="${payRollDetailInstance}" field="incomeTax"/></dd>
						
					</g:if>
				
					<g:if test="${payRollDetailInstance?.dashainBonus}">
						<dt><g:message code="payRollDetail.dashainBonus.label" default="Dashain Bonus" /></dt>
						
							<dd><g:fieldValue bean="${payRollDetailInstance}" field="dashainBonus"/></dd>
						
					</g:if>
				
					<g:if test="${payRollDetailInstance?.foodDeduction}">
						<dt><g:message code="payRollDetail.foodDeduction.label" default="Food Deduction" /></dt>
						
							<dd><g:fieldValue bean="${payRollDetailInstance}" field="foodDeduction"/></dd>
						
					</g:if>
				
					<g:if test="${payRollDetailInstance?.bonus}">
						<dt><g:message code="payRollDetail.bonus.label" default="Bonus" /></dt>
						
							<dd><g:fieldValue bean="${payRollDetailInstance}" field="bonus"/></dd>
						
					</g:if>
				
				</dl>
				<div class="clear"></div>

				<g:form>
					<g:hiddenField name="id" value="${payRollDetailInstance?.id}" />
					<div class="form-actions">
						<g:link class="btn" action="edit" id="${payRollDetailInstance?.id}">
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

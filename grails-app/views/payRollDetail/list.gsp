
<%@ page import="com.deerwalk.dss.PayRollDetail" %>
<!doctype html>
<html>
<head>
      <meta name="layout" content="bootstrap">
      <g:set var="entityName" value="${message(code: 'payRollDetail.label', default: 'PayRollDetail')}" />
      <title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="typehead" />
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
            <div class="span8 offset6">
                  <g:form class="form-search" action="search" controller="payRollDetail">
                      <g:select id="search" name="search" data-provide="typeahead"  data-items="4" noSelection="['':'']" from="${com.deerwalk.dss.Employee.list()}" optionKey="email" value="${params.search}" optionValue="searchCrit" placeholder="Employee email" class="span7"/>
                      %{--<input type="text" name="search" value="${params.search}" class="input-medium search-query" placeholder="Name or Email">--}%
                        <button type="submit" class="btn">Search</button>
                  </g:form>
            </div>
            <g:if test="${flash.message}">
                  <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
            </g:if>

            <table class="table table-striped">
                  <thead>
                  <tr>
				<th></th>
                        <th class="header"><g:message code="payRollDetail.employee.label" default="Employee" /></th>

                        <th class="header"><g:message code="payRollDetail.payRoll.label" default="Pay Roll" /></th>

                        <g:sortableColumn property="basicSalary" title="${message(code: 'payRollDetail.basicSalary.label', default: 'Basic Salary')}" />

                        <g:sortableColumn property="providentFund" title="${message(code: 'payRollDetail.providentFund.label', default: 'PF')}" />

                        <g:sortableColumn property="cit" title="${message(code: 'payRollDetail.cit.label', default: 'CIT')}" />

                        <g:sortableColumn property="socialSecurityTax" title="${message(code: 'payRollDetail.socialSecurityTax.label', default: 'S.S Tax')}" />

                        <g:sortableColumn property="advanceSalary" title="${message(code: 'payRollDetail.advanceSalary.label', default: 'Advance Salary')}" />

                        <g:sortableColumn property="isMailSent" title="${message(code: 'payRollDetail.isMailSent.label', default: 'Is Mail Sent?')}" />

                        <th></th>
                  </tr>
                  </thead>
                  <tbody>
                  <g:each in="${payRollDetailInstanceList}" var="payRollDetailInstance">
                        <tr>
	                        <td>
		                        <g:link action="show" id="${payRollDetailInstance.id}"><img src="${resource(dir: "images/skin",file:"database_table.png")}"/></g:link>
		                        <g:link action="edit" id="${payRollDetailInstance.id}"><img src="${resource(dir: "images/skin",file:"database_edit.png")}"/></g:link>
		                        <g:link action="delete" id="${payRollDetailInstance.id}"><img src="${resource(dir: "images/skin",file:"cross.png")}"/></g:link>
	                        </td>
                              <td>${fieldValue(bean: payRollDetailInstance, field: "employee")}</td>

                              <td>${fieldValue(bean: payRollDetailInstance, field: "payRoll")}</td>

                              <td>${fieldValue(bean: payRollDetailInstance, field: "basicSalary")}</td>

                              <td>${fieldValue(bean: payRollDetailInstance, field: "providentFund")}</td>

                              <td>${fieldValue(bean: payRollDetailInstance, field: "cit")}</td>

                              <td>${fieldValue(bean: payRollDetailInstance, field: "socialSecurityTax")}</td>

                              <td>${fieldValue(bean: payRollDetailInstance, field: "advanceSalary")}</td>

                              <td><g:formatBoolean boolean="${payRollDetailInstance.isMailSent}" /></td>

                              %{--<td class="link">
                                    <g:link action="show" id="${payRollDetailInstance.id}" class="btn btn-small">Show &raquo;</g:link>
                              </td>--}%
	                        <td class="link">
                                    <g:link action="calculateTaxes" id="${payRollDetailInstance.id}" class="btn btn-small">Calculate Taxes</g:link>
                              </td>
	                        <td class="link">
                                    <g:link action="generateSalaryStatement" id="${payRollDetailInstance.id}" class="btn btn-small">Send Email</g:link>
                              </td>
                        </tr>
                  </g:each>
                  </tbody>
            </table>
            <div class="pagination">
                  <bootstrap:paginate total="${payRollDetailInstanceTotal}" />
            </div>
      </div>

</div>
<script>
    $(document).ready(function(){
        $('#search').typeahead()
    })
</script>

</body>
</html>


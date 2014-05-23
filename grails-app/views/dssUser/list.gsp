
<%@ page import="com.deerwalk.dss.usermanagement.DssUser" %>
<!doctype html>
<html>
<head>
      <meta name="layout" content="bootstrap">
      <g:set var="entityName" value="${message(code: 'dssUser.label', default: 'DssUser')}" />
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

                        <g:sortableColumn property="username" title="${message(code: 'dssUser.firstName.label', default: 'First Name')}" />
                        <g:sortableColumn property="username" title="${message(code: 'dssUser.middleName.label', default: 'Middle Name')}" />
                        <g:sortableColumn property="username" title="${message(code: 'dssUser.lastName.label', default: 'Last Name')}" />
                        <g:sortableColumn property="username" title="${message(code: 'dssUser.username.label', default: 'Username')}" />

                        <g:sortableColumn property="password" title="${message(code: 'dssUser.email.label', default: 'Email')}" />

                        <g:sortableColumn property="enabled" title="${message(code: 'dssUser.enabled.label', default: 'Enabled')}" />


                        <th></th>
                  </tr>
                  </thead>
                  <tbody>
                  <g:each in="${dssUserInstanceList}" var="dssUserInstance">
                        <tr>

                              <td>${fieldValue(bean: dssUserInstance, field: "firstName")}</td>
                              <td>${fieldValue(bean: dssUserInstance, field: "middleName")}</td>
                              <td>${fieldValue(bean: dssUserInstance, field: "lastName")}</td>
                              <td>${fieldValue(bean: dssUserInstance, field: "username")}</td>

                              <td>${fieldValue(bean: dssUserInstance, field: "email")}</td>

                              <td><g:formatBoolean boolean="${dssUserInstance.enabled}" /></td>

                              <td class="link">
                                    <g:link action="show" id="${dssUserInstance.id}" class="btn btn-small">Show &raquo;</g:link>
                              </td>
                        </tr>
                  </g:each>
                  </tbody>
            </table>
            <div class="pagination">
                  <bootstrap:paginate total="${dssUserInstanceTotal}" />
            </div>
      </div>

</div>
</body>
</html>

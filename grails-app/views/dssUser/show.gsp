
<%@ page import="com.deerwalk.dss.usermanagement.DssUser" %>
<!doctype html>
<html>
<head>
      <meta name="layout" content="bootstrap">
      <g:set var="entityName" value="${message(code: 'dssUser.label', default: 'DssUser')}" />
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
                  <g:if test="${dssUserInstance?.firstName}">
                        <dt><g:message code="dssUser.firstName.label" default="First Name" /></dt>

                        <dd><g:fieldValue bean="${dssUserInstance}" field="firstName"/></dd>

                  </g:if>
                  <g:if test="${dssUserInstance?.middleName}">
                        <dt><g:message code="dssUser.middleName.label" default="Middle Name" /></dt>

                        <dd><g:fieldValue bean="${dssUserInstance}" field="middleName"/></dd>

                  </g:if>

                  <g:if test="${dssUserInstance?.lastName}">
                        <dt><g:message code="dssUser.lastName.label" default="Last Name" /></dt>

                        <dd><g:fieldValue bean="${dssUserInstance}" field="lastName"/></dd>

                  </g:if>
                  <g:if test="${dssUserInstance?.username}">
                        <dt><g:message code="dssUser.username.label" default="Username" /></dt>

                        <dd><g:fieldValue bean="${dssUserInstance}" field="username"/></dd>

                  </g:if>


                  <g:if test="${dssUserInstance?.email}">
                        <dt><g:message code="dssUser.email.label" default="Email" /></dt>

                        <dd><g:fieldValue bean="${dssUserInstance}" field="email"/></dd>

                  </g:if>


                  <g:if test="${dssUserInstance?.enabled}">
                        <dt><g:message code="dssUser.enabled.label" default="Enabled" /></dt>

                        <dd><g:formatBoolean boolean="${dssUserInstance?.enabled}" /></dd>

                  </g:if>


            </dl>
            <div class="clear"></div>

            <g:form>
                  <g:hiddenField name="id" value="${dssUserInstance?.id}" />
                  <div class="form-actions">

                        <g:link class="btn btn-primary" action="edit" id="${dssUserInstance?.id}">
                              <i class="icon-pencil"></i>
                              <g:message code="default.button.edit.label" default="Edit" />
                        </g:link>
                        <g:link class="btn btn-success" action="resetPassword" id="${dssUserInstance?.id}">
                              <i class="icon-pencil"></i>
                              <g:message code="default.button.reset.label" default="Reset Password" />
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

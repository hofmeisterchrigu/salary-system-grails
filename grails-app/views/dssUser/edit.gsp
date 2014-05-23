<%@ page import="com.deerwalk.dss.usermanagement.DssUser" %>
<!doctype html>
<html>
<head>
      <meta name="layout" content="bootstrap">
      <g:set var="entityName" value="${message(code: 'dssUser.label', default: 'DssUser')}" />
      <title><g:message code="default.edit.label" args="[entityName]" /></title>
      <r:require module="jquery-validation-ui" />
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
                  <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            </div>

            <g:if test="${flash.message}">
                  <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
            </g:if>

            <g:hasErrors bean="${dssUserInstance}">
                  <bootstrap:alert class="alert-error">
                        <ul>
                              <g:eachError bean="${dssUserInstance}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                              </g:eachError>
                        </ul>
                  </bootstrap:alert>
            </g:hasErrors>

            <fieldset>
                  <g:form class="form-horizontal" action="edit" id="${dssUserInstance?.id}" >
                        <g:hiddenField name="version" value="${dssUserInstance?.version}" />
                        <g:hiddenField name="id" value="${dssUserInstance?.id}" />
                        <fieldset>
                              <g:render template="form" model="[roles:dssUserInstance?.getAuthorities() as List]"/>
                              %{--<f:all bean="dssUserInstance"/>--}%
                              <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">
                                          <i class="icon-ok icon-white"></i>
                                          <g:message code="default.button.update.label" default="Update" />
                                    </button>
                                    <button type="submit" class="btn btn-danger" name="_action_delete" formnovalidate>
                                          <i class="icon-trash icon-white"></i>
                                          <g:message code="default.button.delete.label" default="Delete" />
                                    </button>
                              </div>
                        </fieldset>
                  </g:form>
            </fieldset>

      </div>
      <jqvalui:renderValidationScript for="com.deerwalk.dss.PayRoll" />
</div>
</body>
</html>

<%@ page import="com.deerwalk.dss.usermanagement.DssRole; com.deerwalk.dss.usermanagement.DssUser" %>

<div class="control-group ${hasErrors(bean: dssUserInstance, field: 'firstName', 'error')} required">
      <label class="control-label" for="firstName">
            <g:message code="dssUser.firstName.label" default="First Name" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="firstName" required="" value="${dssUserInstance?.firstName}"/>
</div></div>
<div class="control-group ${hasErrors(bean: dssUserInstance, field: 'middleName', 'error')}">
      <label class="control-label" for="middleName">
            <g:message code="dssUser.middleName.label" default="Middle Name" />
      </label><div class="controls">
      <g:textField name="middleName" value="${dssUserInstance?.middleName}"/>
</div></div>
<div class="control-group ${hasErrors(bean: dssUserInstance, field: 'lastName', 'error')} required">
      <label class="control-label" for="lastName">
            <g:message code="dssUser.lastName.label" default="Last Name" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="lastName" required="" value="${dssUserInstance?.lastName}"/>
</div></div>
<div class="control-group ${hasErrors(bean: dssUserInstance, field: 'email', 'error')} required">
      <label class="control-label" for="lastName">
            <g:message code="dssUser.email.label" default="Email" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="email" required="" value="${dssUserInstance?.email}"/>
</div></div>

<div class="control-group ${hasErrors(bean: dssUserInstance, field: 'username', 'error')} required">
      <label class="control-label" for="username">
            <g:message code="dssUser.username.label" default="Username" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="username" required="" value="${dssUserInstance?.username}"/>
</div></div>

%{--<div class="control-group ${hasErrors(bean: dssUserInstance, field: 'password', 'error')} required">--}%
      %{--<label class="control-label" for="password">--}%
            %{--<g:message code="dssUser.password.label" default="Password" />--}%
            %{--<span class="required-indicator">*</span>--}%
      %{--</label><div class="controls">--}%
      %{--<g:textField name="password" required="" value="${dssUserInstance?.password}"/>--}%
%{--</div></div>--}%

<div class="control-group ${hasErrors(bean: dssUserInstance, field: 'enabled', 'error')} ">
      <label class="control-label" for="enabled">
            <g:message code="dssUser.enabled.label" default="Enabled" />

      </label><div class="controls">
      <g:checkBox name="enabled" value="${dssUserInstance?.enabled}" />
</div></div>
<div class="control-group  required">
      <label class="control-label" for="userRole">
            User Role
            <span class="required-indicator">*</span>
      </label><div class="controls">
%{--<g:each in="${DssRole.findAll()}" var="dssRole">--}%
%{--<g:radio name="gender" value="${dssRole.id}" checked="${roleId==dssRole.id}"/>${dssRole}--}%
%{--</g:each>--}%
      <g:set var="dssRoles" value="${DssRole.findAll()}"/>
      <g:set var="selectedRole" value="${roles?.get(0)?:dssRoles.find {it.authority=='ROLE_USER'}}"/>
      <g:radioGroup name="role" id="userRole"
                    labels="${dssRoles}"
                    values="${dssRoles.id}" value="${selectedRole?.id}">
            <label class="radio inline"> ${it.radio} ${it.label}</label>
      </g:radioGroup>
</div></div>



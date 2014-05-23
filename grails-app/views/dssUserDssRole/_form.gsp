<%@ page import="com.deerwalk.dss.usermanagement.DssUserDssRole" %>



<div class="fieldcontain ${hasErrors(bean: dssUserDssRoleInstance, field: 'dssRole', 'error')} required">
	<label for="dssRole">
		<g:message code="dssUserDssRole.dssRole.label" default="Dss Role" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="dssRole" name="dssRole.id" from="${com.deerwalk.dss.usermanagement.DssRole.list()}" optionKey="id" required="" value="${dssUserDssRoleInstance?.dssRole?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dssUserDssRoleInstance, field: 'dssUser', 'error')} required">
	<label for="dssUser">
		<g:message code="dssUserDssRole.dssUser.label" default="Dss User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="dssUser" name="dssUser.id" from="${com.deerwalk.dss.usermanagement.DssUser.list()}" optionKey="id" required="" value="${dssUserDssRoleInstance?.dssUser?.id}" class="many-to-one"/>
</div>


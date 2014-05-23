<%@ page import="com.deerwalk.dss.usermanagement.DssRole" %>



<div class="fieldcontain ${hasErrors(bean: dssRoleInstance, field: 'authority', 'error')} required">
	<label for="authority">
		<g:message code="dssRole.authority.label" default="Authority" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="authority" required="" value="${dssRoleInstance?.authority}"/>
</div>


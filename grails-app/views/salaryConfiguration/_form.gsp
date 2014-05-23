<%@ page import="com.deerwalk.dss.SalaryConfiguration" %>



<div class="fieldcontain ${hasErrors(bean: salaryConfigurationInstance, field: 'particular', 'error')} ">
	<label for="particular">
		<g:message code="salaryConfiguration.particular.label" default="Particular" />
		
	</label>
	<g:textField name="particular" value="${salaryConfigurationInstance?.particular}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: salaryConfigurationInstance, field: 'particularValue', 'error')} ">
	<label for="particularValue">
		<g:message code="salaryConfiguration.particularValue.label" default="Particular Value" />
		
	</label>
	<g:textField name="particularValue" value="${salaryConfigurationInstance?.particularValue}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: salaryConfigurationInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="salaryConfiguration.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${salaryConfigurationInstance?.type}"/>
</div>


<%@ page import="com.deerwalk.dss.PayRollDetail" %>



<div class="control-group fieldcontain ${hasErrors(bean: payRollDetailInstance, field: 'employee', 'error')} required">
	<label class="control-label" for="employee">
		<g:message code="payRollDetail.employee.label" default="Employee" />
		<span class="required-indicator">*</span>
	</label><div class="controls">
	<g:select id="employee" name="employee.id" data-provide="typeahead" data-items="4" noSelection="['':'']" from="${com.deerwalk.dss.Employee.list()}" optionKey="id" required="" value="${payRollDetailInstance?.employee?.id}" class="many-to-one"/>
</div></div>

<div class="control-group fieldcontain ${hasErrors(bean: payRollDetailInstance, field: 'payRoll', 'error')} required">
	<label class="control-label" for="payRoll">
		<g:message code="payRollDetail.payRoll.label" default="Pay Roll" />
		<span class="required-indicator">*</span>
	</label><div class="controls">
	<g:select id="payRoll" name="payRoll.id" from="${com.deerwalk.dss.PayRoll.list()}" optionKey="id" required="" value="${payRollDetailInstance?.payRoll?.id}" class="many-to-one"/>
</div></div>

<div class="control-group fieldcontain ${hasErrors(bean: payRollDetailInstance, field: 'basicSalary', 'error')} required">
	<label class="control-label" for="basicSalary">
		<g:message code="payRollDetail.basicSalary.label" default="Basic Salary" />
		<span class="required-indicator">*</span>
	</label><div class="controls">
	<g:textField name="basicSalary" value="${fieldValue(bean: payRollDetailInstance, field: 'basicSalary')}" required=""/>
</div></div>

<div class="control-group fieldcontain ${hasErrors(bean: payRollDetailInstance, field: 'providentFund', 'error')} required">
	<label class="control-label" for="providentFund">
		<g:message code="payRollDetail.providentFund.label" default="Provident Fund" />
		<span class="required-indicator">*<data-provide="typeahead"/span>
	</label><div class="controls">
	<g:textField name="providentFund" value="${fieldValue(bean: payRollDetailInstance, field: 'providentFund')}" required=""/>
</div></div>

<div class="control-group fieldcontain ${hasErrors(bean: payRollDetailInstance, field: 'cit', 'error')} required">
	<label class="control-label" for="cit">
		<g:message code="payRollDetail.cit.label" default="Cit" />
		<span class="required-indicator">*</span>
	</label><div class="controls">
	<g:textField name="cit" value="${fieldValue(bean: payRollDetailInstance, field: 'cit')}" required=""/>
</div></div>

<div class="control-group fieldcontain ${hasErrors(bean: payRollDetailInstance, field: 'socialSecurityTax', 'error')} required">
	<label class="control-label" for="socialSecurityTax">
		<g:message code="payRollDetail.socialSecurityTax.label" default="Social Security Tax" />
		<span class="required-indicator">*</span>
	</label><div class="controls">
	<g:textField  name="socialSecurityTax" value="${fieldValue(bean: payRollDetailInstance, field: 'socialSecurityTax')}" required=""/>
</div></div>

<div class="control-group fieldcontain ${hasErrors(bean: payRollDetailInstance, field: 'incomeTax', 'error')} required">
	<label class="control-label" for="incomeTax">
		<g:message code="payRollDetail.incomeTax.label" default="Income Tax" />
		<span class="required-indicator">*</span>
	</label><div class="controls">
	<g:textField  name="incomeTax" value="${fieldValue(bean: payRollDetailInstance, field: 'incomeTax')}" required=""/>
</div></div>

<div class="control-group fieldcontain ${hasErrors(bean: payRollDetailInstance, field: 'dashainBonus', 'error')} required">
	<label class="control-label" for="dashainBonus">
		<g:message code="payRollDetail.dashainBonus.label" default="Dashain Bonus" />
		<span class="required-indicator">*</span>
	</label><div class="controls">
	<g:textField  name="dashainBonus" value="${fieldValue(bean: payRollDetailInstance, field: 'dashainBonus')}" required=""/>
</div></div>

<div class="control-group fieldcontain ${hasErrors(bean: payRollDetailInstance, field: 'foodDeduction', 'error')} required">
	<label class="control-label" for="foodDeduction">
		<g:message code="payRollDetail.foodDeduction.label" default="Food Deduction" />
		<span class="required-indicator">*</span>
	</label><div class="controls">
	<g:textField  name="foodDeduction" value="${fieldValue(bean: payRollDetailInstance, field: 'foodDeduction')}" required=""/>
</div></div>

<div class="control-group fieldcontain ${hasErrors(bean: payRollDetailInstance, field: 'bonus', 'error')} required">
	<label class="control-label" for="bonus">
		<g:message code="payRollDetail.bonus.label" default="Bonus" />
		<span class="required-indicator">*</span>
	</label><div class="controls">
	<g:textField  name="bonus" value="${fieldValue(bean: payRollDetailInstance, field: 'bonus')}" required=""/>
</div></div>
<div class="control-group ${hasErrors(bean: payRollDetailInstance, field: 'advanceSalary', 'error')}">
      <label class="control-label" for="advanceSalary">
            <g:message code="payRollDetail.advanceSalary.label" default="Advance Salary" />
      </label><div class="controls">
      <g:textField  name="advanceSalary" value="${fieldValue(bean: payRollDetailInstance, field: 'advanceSalary')}"/>
</div></div>
<div id="is_mail_sent_holder" class="control-group fieldcontain">
    <div class="controls">
        <label class="checkbox">
            <input type="checkbox" name="isMailSent" value="${payRollDetailInstance?.isMailSent}">Has Mail Sent
        </label>
    </div>
</div>
<script>
   $(document).ready(function(){
       $('#employee').typeahead()
   })
</script>


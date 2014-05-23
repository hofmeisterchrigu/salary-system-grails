<%@ page import="com.deerwalk.dss.Month; com.deerwalk.dss.PayRoll;" %>
<%
      def yearList=[]
      int year=Calendar.getInstance().get(Calendar.YEAR)
      yearList=[year-1,year,year+1];
%>

<div class="control-group ${hasErrors(bean: payRollInstance, field: 'formNumber', 'error')} required">
      <label class="control-label" for="formNumber">
            <g:message code="payRoll.formNumber.label" default="Form Number" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="formNumber" required="" value="${payRollInstance?.formNumber}"/>
</div></div>

<div class="control-group ${hasErrors(bean: payRollInstance, field: 'year', 'error')} required">
      <label class="control-label" for="year">
            <g:message code="payRoll.year.label" default="Year" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:select name="year" from="${yearList}" noSelection="['':'--Select--']" value="${payRollInstance?.year}" required=""></g:select>
</div></div>

<div class="control-group ${hasErrors(bean: payRollInstance, field: 'month', 'error')} required">
      <label class="control-label" for="month">
            <g:message code="payRoll.month.label" default="Month" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:select name="month" required="" from="${Month.values()}" noSelection="['':'--Select--']" optionKey="${key}" optionValue="value" value="${payRollInstance?.month}"></g:select>

</div></div>

<div class="control-group ${hasErrors(bean: payRollInstance, field: 'description', 'error')} required">
      <label class="control-label" for="description">
            <g:message code="payRoll.description.label" default="Description" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="description" value="${payRollInstance?.description}" required=""/>
</div></div>

<div class="control-group ${hasErrors(bean: payRollInstance, field: 'salary', 'error')} required">
      <label class="control-label" for="salary">
            <g:message code="payRoll.salary.label" default="Salary" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="salary" value="${payRollInstance?.salary}" required=""/>
</div></div>
<div id="dashain_bonus_holder" class="control-group fieldcontain">
      <div class="controls">
            <label class="checkbox">
                  <input type="checkbox" name="dashainBonus" value="${payRollInstance?.dashainBonus}">Dashain Bonus
            </label>
      </div>
</div>


<%@ page import="com.deerwalk.dss.Gender; com.deerwalk.dss.Employee" %>


<div class="control-group ${hasErrors(bean: employeeInstance, field: 'uniqueEmployeeId', 'error')} required">
      <label class="control-label" for="uniqueEmployeeId">
            <g:message code="employee.uniqueEmployeeId.label" default="Employee Id" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="uniqueEmployeeId" required="" value="${employeeInstance?.uniqueEmployeeId}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'employeeFirstName', 'error')} required">
      <label class="control-label" for="employeeFirstName">
            <g:message code="employee.employeeFirstName.label" default="Employee First Name" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="employeeFirstName" required="" value="${employeeInstance?.employeeFirstName}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'employeeMiddleName', 'error')}">
      <label class="control-label" for="employeeMiddleName">
            <g:message code="employee.employeeMiddleName.label" default="Employee Middle Name" />
      </label><div class="controls">
      <g:textField name="employeeMiddleName" value="${employeeInstance?.employeeMiddleName}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'employeeLastName', 'error')} required">
      <label class="control-label" for="employeeLastName">
            <g:message code="employee.employeeLastName.label" default="Employee Last Name" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="employeeLastName" required="" value="${employeeInstance?.employeeLastName}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'phoneNumber', 'error')} ">
      <label class="control-label" for="phoneNumber">
            <g:message code="employee.phoneNumber.label" default="Phone Number" />

      </label><div class="controls">
      <g:textField name="phoneNumber" value="${employeeInstance?.phoneNumber}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'designation', 'error')} required">
      <label class="control-label" for="designation">
            <g:message code="employee.designation.label" default="Designation" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="designation" required="" value="${employeeInstance?.designation}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'gender', 'error')} required">
      <label class="control-label" for="gender">
            <g:message code="employee.gender.label" default="Gender" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:set var="allGender" value="${com.deerwalk.dss.Gender.values()}"/>
      <g:set var="selectedGender" value="${gender?:Gender.M}"/>
      <g:radioGroup name="gender" id="gender"
                    labels="${allGender.value}"
                    values="${allGender}" value="${selectedGender}">
            <label class="radio inline"> ${it.radio} ${it.label}</label>
      </g:radioGroup>

</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'email', 'error')} required">
      <label class="control-label" for="email">
            <g:message code="employee.email.label" default="Email" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="email" value="${employeeInstance?.email}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'basicScaleAmount', 'error')} required">
      <label class="control-label" for="basicScaleAmount">
            <g:message code="employee.basicScaleAmount.label" default="Basic Scale Amount" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="basicScaleAmount" value="${fieldValue(bean: employeeInstance, field: 'basicScaleAmount')}" required=""/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'department', 'error')} required">
      <label class="control-label" for="department">
            <g:message code="employee.department.label" default="Department" />
            <span class="required-indicator">*</span>
      </label><div class="controls">
      <g:textField name="department" required="" value="${employeeInstance?.department}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'isMarried', 'error')} ">
      <label class="control-label" for="isMarried">
            <g:message code="employee.isMarried.label" default="Is Married" />

      </label><div class="controls">
      <g:checkBox name="isMarried" value="${employeeInstance?.isMarried}" />
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'disability', 'error')} ">
      <label class="control-label" for="disability">
            <g:message code="employee.disability.label" default="Disability" />

      </label><div class="controls">
      <g:checkBox name="disability" value="${employeeInstance?.disability}" />
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'panNumber', 'error')} ">
      <label class="control-label" for="panNumber">
            <g:message code="employee.panNumber.label" default="Pan Number" />

      </label><div class="controls">
      <g:textField name="panNumber" value="${employeeInstance?.panNumber}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'bankAccountNumber', 'error')} ">
      <label class="control-label" for="bankAccountNumber">
            <g:message code="employee.bankAccountNumber.label" default="Bank Account Number" />

      </label><div class="controls">
      <g:textField name="bankAccountNumber" value="${employeeInstance?.bankAccountNumber}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'citNumber', 'error')} ">
      <label class="control-label" for="citNumber">
            <g:message code="employee.citNumber.label" default="Cit Number" />

      </label><div class="controls">
      <g:textField name="citNumber" value="${employeeInstance?.citNumber}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'providentFundNumber', 'error')} ">
      <label class="control-label" for="providentFundNumber">
            <g:message code="employee.providentFundNumber.label" default="Provident Fund Number" />

      </label><div class="controls">
      <g:textField name="providentFundNumber" value="${employeeInstance?.providentFundNumber}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'citPercentage', 'error')} ">
      <label class="control-label" for="citPercentage">
            <g:message code="employee.citPercentage.label" default="Cit Percentage" />

      </label><div class="controls">
      <g:field name="citPercentage" value="${fieldValue(bean: employeeInstance, field: 'citPercentage')}"/>
</div></div>

<div class="control-group ${hasErrors(bean: employeeInstance, field: 'willGetDashainBonus', 'error')} ">
      <label class="control-label" for="willGetDashainBonus">
            <g:message code="employee.willGetDashainBonus.label" default="Will Get Dashain Bonus" />

      </label><div class="controls">
      <g:checkBox name="willGetDashainBonus" value="${employeeInstance?.willGetDashainBonus}" />
</div></div>
<div class="control-group ${hasErrors(bean: employeeInstance, field: 'insuranceAmount', 'error')}">
      <label class="control-label" for="basicScaleAmount">
            <g:message code="employee.insuranceAmount.label" default="Insurance Amount" />
      </label><div class="controls">
      <g:field name="insuranceAmount" value="${fieldValue(bean: employeeInstance, field: 'insuranceAmount')}"/>
</div></div>
<div class="control-group ${hasErrors(bean: employeeInstance, field: 'willGetPf', 'error')} ">
      <label class="control-label" for="willGetPf">
            <g:message code="employee.willGetPf.label" default="Will Get Pf" />

      </label><div class="controls">
      <g:checkBox name="willGetPf" value="${employeeInstance?.willGetPf}" />
</div></div>


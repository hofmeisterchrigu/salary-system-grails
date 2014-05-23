<%--
  Created by IntelliJ IDEA.
  User: amadhikari
  Date: 9/9/13
  Time: 7:08 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.deerwalk.dss.Month" contentType="text/html;charset=UTF-8" %>
<html>
<head>
      <meta name="layout" content="reportLayout">
      <r:require module="jquery"/>
      <title>DSS-Salary Report</title>
</head>
<body>
<div id="dateFormOfReport" style="display: hidden">
    <g:form name="salaryReport" action="salaryReport" method="post">
        <g:set var="today" value="${Calendar.instance}"/>
        <g:select name="month" from="${Month.values()}" noSelection="['':'--Select--']" id="month" optionKey="${key}" optionValue="value" value="${params.month}"/>
        <g:select name="year" from="${yearList}" id="year"   value="${params.year?:today.get(Calendar.YEAR)}"/>
        <input type="submit" style="display: none;"/>
        <button class="btn" type="submit">Go!</button>
    </g:form>
</div>
<div class="content">
    <div class="generateData">
        <div class="generateIcon">
            <g:form action="salaryReport">
                <g:hiddenField name="format" value="excel"/>
                <g:hiddenField name="year" value="${params.year}"/>
                <g:hiddenField name="month" value="${params.month}"/>
                <g:submitButton name="submit" value="" class="excel_btn excel" title="Export to Excel">excel</g:submitButton>
            </g:form>
        </div>
    </div>
    <div style="clear:both;"></div>
      <table cellpadding="0" cellspacing="0" width="100%" class="mainTable" id="sr">
            <thead>
            <tr>
                  <g:each in="${columns}" var="col">
                        <th>${col}</th>
                  </g:each>
            </tr>
            </thead>
            <tbody>
            <g:each in="${data}" var="val">
                  <tr>
                        <td>${val.getAt('sn')}</td>
                        <td>${val.getAt('name')}</td>
                        <td>${val.getAt('maritalStatus')}</td>
                        <td>${val.getAt('basicSalary')}</td>
                        <td>${val.getAt('accuredSalary')}</td>
                        <td>${val.getAt('performanceBonus')}</td>
                        <td>${val.getAt('pfFromOffice')}</td>
                        <td>${val.getAt('grossSalary')}</td>
                        <td>${val.getAt('citPercent')}</td>
                        <td>${val.getAt('pfDeposited')}</td>
                        <td>${val.getAt('citDeposited')}</td>
                        <td>${val.getAt('totalTax')}</td>
                        <td>${val.getAt('foodDeduction')}</td>
                        <td>${val.getAt('netPayable')}</td>
                        <td>${val.getAt('accountNumber')}</td>
                  </tr>
            </g:each>
            </tbody>
      </table>
</div>

<jqDT:resources/>
<script type="text/javascript">
    $(document).ready(function() {
        var dateSearch = $('#dateFormOfReport');
        $('#dateInLayout').append(dateSearch.html());
        dateSearch.remove();
        $.extend( $.fn.dataTableExt.oStdClasses, {
            "sWrapper": "dataTables_wrapper form-inline"
        });
        $('#sr').dataTable({
            "sDom": "<'row-fluid'<'span12'l>r>t<'row-fluid'<'span6'i><'span6'p>>",
            "bFilter": false
        });
    });

</script>
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: sagurung
  Date: 9/9/13
  Time: 7:01 PM
  To change this template use File | Settings | File Templates.
--%>



<%@ page import="com.deerwalk.dss.Month" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="layout" content="reportLayout">
	<title>CIT Generator</title>
	%{--    <script src="http://code.highcharts.com/highcharts.js"></script>
	    <script src="http://code.highcharts.com/modules/exporting.js"></script>--}%
	%{--<script src="http://code.highcharts.com/adapters/standalone-framework.js"></script>--}%
	<r:require module="jquery"/>
	%{--<r:require module="highcharts"/>--}%

	%{--<r:require module="export"/>
	    <export:resource />
	--}%
</head>
<body>
<div id="dateFormOfReport" style="display: hidden">
	<g:form name="citGenerator" action="citGenerator" method="post">
		<g:set var="today" value="${Calendar.instance}"/>
		<g:select name="month" from="${Month.values()}" noSelection="['':'--Select--']" id="month" optionKey="${key}" optionValue="value" value="${params.month}"/>
		<g:select name="year" from="${yearList}" id="year"   value="${params.year?:today.get(Calendar.YEAR)}"/>
		<input type="submit" style="display: none;"/>
		<button class="btn" type="submit">Go!</button>
	</g:form>
</div>

%{--<input type="button" class='btn' value='HighChart' onclick="chartsNow()"></button>--}%
<div id="highchartPopUp" class="modal hide">
	<div class="modal-header" style="height:30px">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	</div>
	<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</div>
<div class="content">
	<div class="generateData">
		<div class="generateIcon">
			<g:form action="citGenerator">
				<g:hiddenField name="format" value="excel"/>
				<g:hiddenField name="year" value="${params.year}"/>
				<g:hiddenField name="month" value="${params.month}"/>
				<g:submitButton name="submit" value="" class="excel_btn excel" title="Export to Excel">excel</g:submitButton>
			</g:form>
		</div>
	</div>
	<div style="clear:both;"></div>

	<table cellpadding="0" cellspacing="0" width="100%" class="mainTable" id="cit">
		<thead>
		<tr>
			<th>SNo.</th>
			<th>Id</th>
			<th>Designation</th>
			<th>Full Name</th>
			<th>CIT Number</th>
			<th>CIT Amount</th>
			<th>Comments</th>
		</tr>
		</thead>
		<tbody>
		<g:each in="${employeeList}" var="emp">
			<tr>
				<td>${emp.getAt('sno')}</td>
				<td style="text-align: right">${emp.getAt('id')}</td>
				<td>${emp.getAt('designation')}</td>
				<td>${emp.getAt('fullName')}</td>
				<td>${emp.getAt('citNumber')}</td>
				<td style="text-align: right">${emp.getAt('cit')}</td>
				<td>${emp.getAt('comment')}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
</div>

%{--<g:if test="${total>3}">
<g:paginate total="${total}" action="citGenerator" params="${searchParams}" />
</g:if>--}%
%{--<export:formats />--}%
%{--<export:formats formats="['excel']" />--}%


<jqDT:resources/>
<script type="text/javascript">
	$(document).ready(function() {
		var dateSearch = $('#dateFormOfReport');
		$('#dateInLayout').append(dateSearch.html());
		dateSearch.remove();
		$.extend( $.fn.dataTableExt.oStdClasses, {
			"sWrapper": "dataTables_wrapper form-inline"
		} );
		$('#cit').dataTable({
//            "bPaginate": true,
//            "bLengthChange": false,
//            "bSort": true,
//            "bInfo": true,
//            "bAutoWidth": true
			"sDom": "<'row-fluid'<'span12'l>r>t<'row-fluid'<'span6'i><'span6'p>>",
			"bFilter": false
//            sScrollY: '70%'
			/*bProcessing: true,
			 bServerSide: true,
			 sAjaxSource: '%{--${request.contextPath + '/product/dataTablesSource'}--}%' ,
			 bJQueryUI: true,
			 sPaginationType: "full_numbers",
			 aLengthMenu: [[100, 500, 1000, 5000, -1], [100, 500, 1000, 5000, "All"]],
			 iDisplayLength: 500,
			 aoColumnDefs: [{
			 fnRender: renderPriceWithCents,
			 aTargets: [2]
			 }]*/
		});
	});
	function chartsNow(){
		$("#highchartPopUp").modal('show')

		var chart1 = new Highcharts.Chart({
			chart: {
				renderTo: 'container',
				defaultSeriesType: 'column'
			},
			title: {
				text: 'Monthly Cit'
			},
			xAxis: {
				categories: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
			},
			yAxis: {
				title: {
					text: 'Total CIT Amount'
				}
			},
			series: [
				{
					name:'Basic Salary',
					data:${basicSalary}
				}, {   name:'Cit',
					data:${highchart}
				}]
		});
	}
</script>

</body>
</html>

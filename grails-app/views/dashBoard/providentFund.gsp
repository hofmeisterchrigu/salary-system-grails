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
	<title>DSS - Provident Fund Report</title>
	<meta name="layout" content="reportLayout">
	%{--<link rel="stylesheet" type="text/css" href="/css/style.css" />--}%
	%{--<r:require module="mainLayout"/>--}%
	<r:require module="jquery"/>
</head>
<body>
<div id="dateFormOfReport" style="display: hidden">
	<g:form name="providentFund" action="providentFund" method="post">
		<g:set var="today" value="${Calendar.instance}"/>
		<g:select name="month" from="${Month.values()}" noSelection="['':'--Select--']" id="month" optionKey="${key}" optionValue="value" value="${params.month}"/>
		<g:select name="year" from="${yearList}" id="year"   value="${params.year?:today.get(Calendar.YEAR)}"/>
		<input type="submit" style="display: none;"/>
		<button class="btn" type="submit">Go!</button>
	</g:form>
</div>

%{--<input type="button" class='btn' value='HighChart' onclick="chartsNow()"></button>
<div id="highchartPopUp" class="modal hide">
	<div class="modal-header" style="height:30px">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	</div>
	<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</div>--}%

<div class="content">
	<div class="generateData">
		<div class="generateIcon">
			<g:form action="providentFund">
				<g:hiddenField name="format" value="excel"/>
				<g:hiddenField name="year" value="${params.year}"/>
				<g:hiddenField name="month" value="${params.month}"/>
				<g:submitButton name="submit" value="" class="excel_btn excel" title="Export to Excel">excel</g:submitButton>
			</g:form>
		</div>
	</div>
	<div style="clear:both;"></div>

	%{--<table class="table table-striped table-bordered active table-hover" id="pf">--}%
	<table cellpadding="0" cellspacing="0" width="100%" class="mainTable" id="pf">
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
				<td>${val.getAt('personalNumber')}</td>
				<td>${val.getAt('designation')}</td>
				<td>${val.getAt('fundNumber')}</td>
				<td>${val.getAt('fullName')}</td>
				<td>${val.getAt('totalFundDeduct')}</td>
				<td>${val.getAt('compulsoryFundDeduct')}</td>
				<td>${val.getAt('addFundDeduct')}</td>
				<td>${val.getAt('remark')}</td>
			</tr>
		</g:each>
		</tbody>
		%{--<tr>
			<td colspan="5"><b>Total</b></td>
			<td><b>${dataTotal.getAt('fundDeductTotal')}</b></td>
			<td><b>${dataTotal.getAt('compulsoryFundDeductTotal')}</b></td>
			<td><b>${dataTotal.getAt('addFundDeductTotal')}</b></td>
			<td></td>
		</tr>--}%
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
		} );
		$('#pf').dataTable({
			"sDom": "<'row-fluid'<'span12'l>r>t<'row-fluid'<'span6'i><'span6'p>>",
			"bFilter": false
		});
	});
	/*function chartsNow(){
		$("#highchartPopUp").modal('show');

		var chart2 = new Highcharts.Chart({
			chart: {
				renderTo: 'container',
				defaultSeriesType: 'column'
			},
			title: {
				text: 'Monthly Provident Fund'
			},
			xAxis: {
				categories: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
			},
			yAxis: {
				title: {
					text: 'Total Provident Fund'
				}
			},
			series: [{
				data:${highchart}
			}]

		});
	}*/
</script>
</body>
</html>
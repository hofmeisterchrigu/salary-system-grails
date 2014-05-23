<%@ page import="com.deerwalk.dss.Month" %>
<%--
  Created by IntelliJ IDEA.
  User: Prabin
  Date: 9/9/13
  Time: 7:21 PM
  To change this template use File | Settings | File Templates.
--%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="layout" content="reportLayout">
	<r:require module="jquery"/>
	<title>DSS-Social Security Tax  Report</title>
</head>
<body>
<div id="dateFormOfReport" style="display: hidden">
	<g:form name="socialSecurityExport" action="socialSecurityExport" method="post">
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
			<g:form action="socialSecurityExport">
				<g:hiddenField name="format" value="excel"/>
				<g:hiddenField name="year" value="${params.year}"/>
				<g:hiddenField name="month" value="${params.month}"/>
				<g:submitButton name="submit" value="" class="excel_btn excel" title="Export to Excel">excel</g:submitButton>
			</g:form>
		</div>
	</div>
	<div style="clear:both;"></div><table cellpadding="0" cellspacing="0" width="100%" class="mainTable" id="social" >
	<thead>
	%{--<tr class="nav nav-list">--}%
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
			<td>${val.getAt('panNumber')}</td>
			<td>${val.getAt('name')}</td>
			<td>${val.getAt('dates')}</td>
			<td>${val.getAt('basicSalary')}</td>
			<td>${val.getAt('taxAmount')}</td>
			<td>${val.getAt('extra')}</td>
		</tr>
	</g:each>

	</tbody>
</table>
</div>
<jqDT:resources/>
<script type="text/javascript">
	/*$(document).ready(function(){
	 $('#social').dataTable( {
	 "bPaginate": true,
	 "bLengthChange": false,
	 "bFilter": true,
	 "bSort": true,
	 "bInfo": true,
	 "bAutoWidth": true
	 });
	 });*/
	$(document).ready(function() {
		var dateSearch = $('#dateFormOfReport');
		$('#dateInLayout').append(dateSearch.html());
		dateSearch.remove();
		$.extend( $.fn.dataTableExt.oStdClasses, {
			"sWrapper": "dataTables_wrapper form-inline"
		} );
		$('#social').dataTable({
			"sDom": "<'row-fluid'<'span12'l>r>t<'row-fluid'<'span6'i><'span6'p>>",
			"bFilter": false
		});
	});
	function chartsNow(){
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
	}
</script>
</body>
</html>
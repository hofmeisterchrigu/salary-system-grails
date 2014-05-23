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
	<title>DSS-Employee Detail</title>
</head>
<body>
<div id="dateFormOfReport" style="display: hidden">
	<g:form name="employeeDetails" action="employeeDetails" method="post">
		<g:set var="today" value="${Calendar.instance}"/>
		<g:select name="year" from="${yearList}" noSelection="['':'--Select--']" id="year"   value="${params.year?:today.get(Calendar.YEAR)}"/>
		<input type="submit" style="display: none;"/>
		<button class="btn" type="submit">Go!</button>
	</g:form>
</div>
<div class="content">
	<div class="generateData">
		<div class="generateIcon">
			<g:form action="employeeDetails">
				<g:hiddenField name="format" value="excel"/>
				<g:if test="${params.year}">
					<g:hiddenField name="year" value="${params.year}"/>
				</g:if><g:else>
				<g:hiddenField name="year" value="${currentYear}"/>
			</g:else>
				<g:hiddenField name="id" value="${getEmployee}"/>
				<g:submitButton name="submit" value="" class="excel_btn excel" title="Export to Excel">excel</g:submitButton>
			</g:form>
			<a href="#" onclick="chartsNow()" class="highchart" style="float: right; margin-right: 5px;"></a>

		</div>
	</div>
	<div style="clear:both;"></div>
	%{--<a href="#" onclick="chartsNow()" class="btn"><img class="pie-chart" src="${resource(dir: "images",file:"highchart.png")}"/></a>--}%
	<div id="highchartPopUp" class="modal hide" style="width: 900px; height: 500px; margin-left: -450px;">
		<div class="modal-header" style="height:30px">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
		</div>
		<div id="container" ></div>
	</div>
	<div id="highchartPopUp1" class="modal hide">
		<div class="modal-header" style="height:30px">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
		</div>
		<div id="container1"></div>
	</div>

	<table cellpadding="0" cellspacing="0" width="100%" class="mainTable" id="social" >
		<thead>
		%{--<tr class="nav nav-list">--}%
		<tr>
			<g:each in="${columns}" var="col">
				<th>${col}</th>
			</g:each>
			<th></th>
			<th>Chart</th>
		</tr>
		</thead>
		<tbody>
		<g:each in="${data}" var="val" status="i">
			<g:if test="${i<data.size()-1 }">
				<tr>
					<td>${val.getAt('sn')}</td>
					<td>${val.getAt('name')}</td>
					<td>${val.getAt('month')}</td>
					<td>${val.getAt('dates')}</td>
					<td>${val.getAt('basicSalary')}</td>
					<td>${val.getAt('taxAmount')}</td>
					<td>${val.getAt('iTax')}</td>
					<td>${val.getAt('cit')}</td>
					<td>${val.getAt('pf')}</td>
					<td>${val.getAt('bonus')}</td>
					<td>${val.getAt('dashianBonus')}</td>
					<td>${val.getAt('food')}</td>
					<td><g:link controller="payRollDetail" action="edit" id="${val.getAt('id')}"><img src="${resource(dir: "images/skin",file:"database_edit.png")}"/></g:link></td>
					<td><a href="#" title="Pie Chart" onclick="charts('${[['\\\'Basic Salary\\\'',val.getAt('basicSalary')],
                            ['\\\'Income Tax\\\'',val.getAt('iTax')],
                            ['\\\'Social Security Tax\\\'',val.getAt('taxAmount')],
                            ['\\\'CIT\\\'',val.getAt('cit')],
                            ['\\\'Provident Fund\\\'',val.getAt('pf')],
                            ['\\\'Bonus\\\'',val.getAt('bonus')],
                            ['\\\'Food Deduction\\\'',val.getAt('food')],
                            ['\\\'Dashain Bonus\\\'',val.getAt('dashianBonus')]]}')">
						<img class="pie-chart" src="${resource(dir: "images/skin",file:"pirChart.png")}"/></a></td>
				</tr>
			</g:if>
			<g:else>
				<tr>
					<td></td>
					<td>${val.getAt('name')}</td>
					<td></td>
					<td></td>
					<td>${val.getAt('iTax')}</td>
					<td>${val.getAt('basicSalary')}</td>
					<td>${val.getAt('taxAmount')}</td>
					<td>${val.getAt('cit')}</td>
					<td>${val.getAt('pf')}</td>
					<td>${val.getAt('bonus')}</td>
					<td>${val.getAt('dashianBonus')}</td>
					<td>${val.getAt('food')}</td>
					<td></td>
					<td></td>

				</tr>
			</g:else>
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
			"bFilter": false,
			"bSort": false
		});
	});
	function chartsNow(){
		$("#highchartPopUp").modal('show');
		$('#container').highcharts({
			chart: {
				type: 'column'
			},
			title: {
				text: 'Salary Report',
				x: -20 //center
			},
			subtitle: {
				text: 'Deerwalk Salary System',
				x: -20
			},
			xAxis: {
				/*categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
				 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']*/
				categories: ${month}
			},
			yAxis: {
				title: {
					text: 'Total Income Tax'
				},
				plotLines: [{
					value: 0,
					width: 1,
					color: '#808080'
				}]
			},
			tooltip: {
				valuePrefix: 'Rs.'
			},
			legend: {
				layout: 'vertical',
				align: 'right',
				verticalAlign: 'middle',
				borderWidth: 0
			},
			series: [
				<g:each in="${tempList}" var="temp">
				{   name:'${temp.key}',
					data:${temp.value}
				},
				</g:each>
			]
		});
	}
	function charts(dataNow) {
		var dataNow = dataNow.replace(/\'/g,'"')
		$("#highchartPopUp1").modal('show')
		$('#container1').highcharts({
			chart: {
				plotBackgroundColor: null,
				plotBorderWidth: null,
				plotShadow: false
			},
			title: {
				text: 'Monthly Salary Report'
			},
			tooltip: {
				pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			},
			plotOptions: {
				pie: {
					allowPointSelect: true,
					cursor: 'pointer',
					dataLabels: {
						enabled: true,
						color: '#000000',
						connectorColor: '#000000',
						format: '<b>{point.name}</b>: {point.percentage:.1f} %'
					}
				}
			},
			series: [{
				type: 'pie',
				name: 'Browser share',
				data: $.parseJSON(dataNow)
			}]
		});
	}
</script>
</body>
</html>
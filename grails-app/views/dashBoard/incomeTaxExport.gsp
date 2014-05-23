<%--
  Created by IntelliJ IDEA.
  User: sagurung
  Date: 9/20/13
  Time: 2:44 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.deerwalk.dss.Month" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="reportLayout">
    <title>Income Tax Generator</title>
    <r:require module="jquery"/>
</head>
<body>
<div id="dateFormOfReport" style="display: hidden">
    <g:form name="incomeTaxExport" action="incomeTaxExport" method="post">
        <g:set var="today" value="${Calendar.instance}"/>
        <g:select name="month" from="${Month.values()}" noSelection="['':'--Select--']" id="month" optionKey="${key}" optionValue="value" value="${params.month}"/>
        <g:select name="year" from="${yearList}" id="year"   value="${params.year?:today.get(Calendar.YEAR)}"/>
        <input type="submit" style="display: none;"/>
        <button class="btn" type="submit">Go!</button>
    </g:form>
</div>

%{--<input type="button" class='btn' value='HighChart' onclick="chartsNow()"></button>--}%
<div id="highchartPopUp1" class="modal hide">
    <div class="modal-header" style="height:30px">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    </div>
    <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</div>

<div class="content">
    <div class="generateData">
        <div class="generateIcon">
            <g:form action="incomeTaxExport">
                <g:hiddenField name="format" value="excel"/>
                <g:hiddenField name="year" value="${params.year}"/>
                <g:hiddenField name="month" value="${params.month}"/>
                <g:submitButton name="submit" value="" class="excel_btn excel" title="Export to Excel">excel</g:submitButton>
            </g:form>
        </div>
    </div>
    <div style="clear:both;"></div>
    <table cellpadding="0" cellspacing="0" width="100%" class="mainTable" id="incomeTax">
        <thead>
        <tr>
        <th>SNo.</th>
        <th>Employee Id</th>
        <th>Full Name</th>
        <th>Issued Date</th>
        <th>Amount</th>
        <th>Income Tax</th>
        <th>Comments</th>
        </tr>
        </thead>
        <tbody>
            <g:each in="${list}" var="info">
                <tr>
                    <td>${info.getAt('sno')}</td>
                    <td style="text-align: right">${info.getAt('employeeId')}</td>
                    <td>${info.getAt('fullName')}</td>
                    <td>${info.getAt('date')}</td>
                    <td style="text-align: right">${info.getAt('amount')}</td>
                    <td style="text-align: right">${info.getAt('incomeTax')}</td>
                    <td>${info.getAt('comment')}</td>
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
        } );
        $('#incomeTax').dataTable({
            "sDom": "<'row-fluid'<'span12'l>r>t<'row-fluid'<'span6'i><'span6'p>>",
            "bFilter": false
        });

    });
    function chartsNow(){
        $("#highchartPopUp1").modal('show')

        var chart2 = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                defaultSeriesType: 'column'
            },
            title: {
                text: 'Monthly Income Tax'
            },
            xAxis: {
                categories: ['January', 'February', 'March']
            },
            yAxis: {
                title: {
                    text: 'Total Income Tax'
                },
                stackLabels: {
                    enabled: true,
                    style: {
                        fontWeight: 'bold',
                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                    }
                }
            },
            legend: {
                align: 'right',
                x: -70,
                verticalAlign: 'top',
                y: 20,
                floating: true,
                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.x +'</b><br/>'+
                            this.series.name +': '+ this.y +'<br/>'+
                            'Total: '+ this.point.stackTotal;
                }
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    dataLabels: {
                        enabled: true,
                        color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
                    }
                }
            },
            series: [{
                data:${basicSalary}
            },{
                data:${highchart}
            }]

        });
    }
</script>


</body>
</html>
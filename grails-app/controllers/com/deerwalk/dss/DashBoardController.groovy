package com.deerwalk.dss

import com.alutam.ziputils.ZipEncryptOutputStream
import grails.converters.JSON
import grails.plugins.springsecurity.Secured
import groovy.sql.Sql
import net.lingala.zip4j.model.ZipParameters
import org.codehaus.groovy.grails.commons.ConfigurationHolder

import javax.servlet.ServletOutputStream
import org.codehaus.groovy.grails.web.json.JSONArray
import org.hibernate.Query
import java.text.DecimalFormat
import java.text.SimpleDateFormat
import java.util.zip.ZipEntry
import java.util.zip.ZipFile
import java.util.zip.ZipOutputStream

@Secured(['ROLE_USER'])
class DashBoardController {
	def exportService
	def springSecurityService
	@Secured(['ROLE_USER','ROLE_ADMIN'])
	def index() {
		def roles=springSecurityService.getPrincipal().getAuthorities()
		if (roles.any { it.authority == "ROLE_ADMIN" }) {
			redirect(controller: "dssUser",action: "index");
			return;
		}
		if (params.email){
			[params:params]
		}
	}
	@Secured(['ROLE_USER'])
	def socialSecurityExport={
		def data=[]
		def columns=['sn':'SN','panNumber':'Pan Number','name':'Name','dates':'Date','basicSalary':'Basic Salary','taxAmount':'Tax Deduction','extra':'Extra']
		def getYear = PayRoll.executeQuery("select distinct a.year from PayRoll a");
		def paryRoll=null
		if (params.month && params.year){
			paryRoll=PayRoll.findAllByMonthAndYear(params.month,params.year)
		}else if(params.month){
			paryRoll=PayRoll.findAllByMonth(params.month)
		}else if (params.year){
			paryRoll=PayRoll.findAllByYear(params.year)
		}

		def payRollDetails= PayRollDetail.findAllByPayRollInList(paryRoll)
		Map temp=new HashMap()
		int snCount = 1
		payRollDetails.each{
			temp = [:]
			temp['sn']=snCount++
			temp['taxAmount']=it.socialSecurityTax
			def employeeFirstName=it.employee.employeeFirstName
			def employeeLastName=it.employee.employeeLastName
			temp['name']=employeeFirstName +" "+(it.employee.employeeMiddleName?it.employee.employeeMiddleName:'')+ " "+employeeLastName
			temp['panNumber']=it.employee.panNumber
			temp['basicSalary']=it.basicSalary
			def year=it.payRoll.year
			def month=Month.valueOf(it.payRoll.month).getValue();
			temp['dates']=year+" "+month
			temp['extra']='--'
			data.add(temp)
		}
		if (params.format){
			def date = String.format('%tm/%<td/%<tY', new Date());
			response.contentType = ConfigurationHolder.config.grails.mime.types['excel']
			response.setHeader("Content-disposition", "attachment; filename=SocialSecurity-${date}.xls")
			response.setHeader("Cache-Control", "")
			response.setHeader("Pragma","")
			exportService.export('excel', response.outputStream, data, columns.keySet() as List, columns,  null, null)
			return;
		}
		def highchart
		def totalSocial=[]
		/*def test= PayRoll.executeQuery("select id from PayRoll where month='Jan'")
	//        def test= PayRoll.executeQuery("select id from PayRoll where year='2013'")
		  test?.each{
			highchart=PayRollDetail.executeQuery("select sum(socialSecurityTax) from PayRollDetail where payRoll=${it}")
			totalSocial.push(Math.ceil(highchart[0] * 2 ) / 2)
		  }*/
		[columns:columns.values() as List,data:data,yearList:getYear.sort{it}.reverse(),params:params, highchart: totalSocial]

	}
	@Secured(['ROLE_USER'])
	def providentFund() {
		// Columns to be displayed
		def columns = ['sn':'S.N','personalNumber':'Personal Number','designation':'Designation',
			'fundNumber':'Fund Identity Number','fullName':'Full Name',
			'totalFundDeduct':'Total Fund Deduction','compulsoryFundDeduct':'Compulsory Fund Deduction',
			'addFundDeduct':'Additional Deduction On Fund','remark':'Remarks'
		]
		def getYear = PayRoll.executeQuery("select distinct a.year from PayRoll a");
		def payRoll=null
		if (params.month && params.year){
			payRoll=PayRoll.findAllByMonthAndYear(params.month,params.year)
		}else if(params.month){
			payRoll=PayRoll.findAllByMonth(params.month)
		}else if (params.year){
			payRoll=PayRoll.findAllByYear(params.year)
		}
		def data = []
		Map row = new HashMap()
		Map rowTotal = new HashMap()
		def payRollInstance = PayRollDetail.findAllByPayRollInList(payRoll)
		int snCount = 1
		def fundDeductTotal = 0
		def compulsoryFundDeductTotal = 0
		def addFundDeductTotal = 0
		payRollInstance?.each{ //Iterating on PayRoll Detail instance
			row = [:] // Making row empty at first on each iteration
			row['sn'] = snCount++
			row['personalNumber'] = it?.employee?.uniqueEmployeeId
			row['designation'] = it?.employee?.designation
			row['fundNumber'] = it?.employee?.providentFundNumber
			row['fullName'] = (it?.employee?.employeeFirstName)+' '+(it.employee.employeeMiddleName?it.employee.employeeMiddleName:'')+' '+(it?.employee?.employeeLastName)
			fundDeductTotal+=it?.providentFund
			row['totalFundDeduct'] = it?.providentFund
			compulsoryFundDeductTotal+=((it?.providentFund)/2)
			row['compulsoryFundDeduct'] = (it?.providentFund)/2
			addFundDeductTotal+=((it?.providentFund)/2)
			row['addFundDeduct'] = (it?.providentFund)/2
			row['remark'] = '--'
			data.add(row) // adding row at the end on each iteration
		} // Iteration Ends
		// Total Calculation portion starts
		rowTotal = [:]
		rowTotal['fundDeductTotal'] = fundDeductTotal
		rowTotal['compulsoryFundDeductTotal'] = compulsoryFundDeductTotal
		rowTotal['addFundDeductTotal'] = addFundDeductTotal

		if (params.format){
			def date = String.format('%tm/%<td/%<tY', new Date());
			response.contentType = ConfigurationHolder.config.grails.mime.types['excel']
			response.setHeader("Content-disposition", "attachment; filename=ProvidentFund-${date}.xls")
			response.setHeader("Cache-Control", "")
			response.setHeader("Pragma","")
			exportService.export('excel', response.outputStream, data, columns.keySet() as List, columns,  null, null)
			return;
		}
		def highchart
		def totalPf=[]
		/*def test= PayRoll.executeQuery("select id from PayRoll where month='Jan'")
	//        def test= PayRoll.executeQuery("select id from PayRoll where year='2013'")
		  test?.each{
			highchart=PayRollDetail.executeQuery("select sum(providentFund) from PayRollDetail where payRoll=${it}")
			totalPf.push(Math.ceil(highchart[0] * 2 ) / 2)
		  }*/
		[columns: columns.values() as List,data: data,dataTotal:rowTotal,yearList:getYear.sort{it}.reverse(),params:params, highchart: totalPf]
	}
	@Secured(['ROLE_USER'])
	def salaryReport() {
		def columns = [
                'sn':'SNo.',
			'name':'Name of Employee',
			'maritalStatus':'Marital Status',
			'basicSalary':'Basic Salary',
			'accuredSalary':"Accured Salary",
			'performanceBonus':'Performance Bonus',
			'pfFromOffice':'PF from Company @ 10%',
			'grossSalary':'Gross Salary',
			'citPercent':'CIT %',
			'pfDeposited':"PF Deposited @ 20%",
			'citDeposited':"CIT Deposited",
			'totalTax':"TDS Deducted",
			'foodDeduction':'Food Deduction',
			'netPayable':'Net Salary Payable',
			'accountNumber':'Bank A/C Number'
		]

		def getYear = PayRoll.executeQuery("select distinct a.year from PayRoll a");
		def payRoll=null
		def employee = null
		def cal = Calendar.instance
		def currentYear = cal.get(Calendar.YEAR)
		if (params.month && params.year){
			payRoll=PayRoll.findAllByMonthAndYear(params.month,params.year)
		}else if(params.month){
			payRoll=PayRoll.findAllByMonth(params.month)
		}else if (params.year){
			payRoll=PayRoll.findAllByYear(params.year)
		}/*else{
			payRoll=PayRoll.findAllByYear(currentYear)
		}*/

		def payRollInstance = PayRollDetail.findAllByPayRollInList(payRoll)

		def data = []
		int snCount = 1
		Map row = new HashMap()
		payRollInstance?.each{
			row = [:]
			row['sn'] = snCount++
//			row['name'] = (it?.employee?.employeeFirstName)+' '+(it?.employee?.employeeMiddleName)+' '+(it?.employee?.employeeLastName)
			row['name'] = (it?.employee?.employeeFirstName)+' '+(it.employee.employeeMiddleName?it.employee.employeeMiddleName:'')+' '+(it?.employee?.employeeLastName)
			row['maritalStatus'] = it?.employee?.isMarried?"Married":"Single"
			row['basicSalary'] = it?.employee?.basicScaleAmount
			row['accuredSalary'] = it?.basicSalary
			row['performanceBonus'] = it?.bonus
			def pfFromOffice = 0
			if(it?.employee?.willGetPf){
				pfFromOffice = it?.basicSalary*0.1
			}
			row['pfFromOffice'] = pfFromOffice
			row['grossSalary'] = it?.basicSalary+pfFromOffice
			row['citPercent'] = it?.employee?.citPercentage
			row['pfDeposited'] = it?.providentFund
			row['citDeposited'] = it?.cit
			row['totalTax'] = (it?.socialSecurityTax+it?.incomeTax).round(2)
			row['foodDeduction'] = (it?.foodDeduction).round(2)
			def netPayable = it?.basicSalary + it?.bonus - (it?.providentFund + it?.cit + it?.socialSecurityTax + it?.incomeTax + it?.foodDeduction)
			row['netPayable'] = (netPayable).round(2)
			row['accountNumber'] = it?.employee?.bankAccountNumber
			data.add(row)
		}

		if (params.format){
			def date = String.format('%tm/%<td/%<tY', new Date());
			response.contentType = ConfigurationHolder.config.grails.mime.types['excel']
			response.setHeader("Content-disposition", "attachment; filename=Salary-${date}.xls")
			response.setHeader("Cache-Control", "")
			response.setHeader("Pragma","")
			exportService.export('excel', response.outputStream, data, columns.keySet() as List, columns,  null, null)
			return;
		}

		[columns: columns.values() as List,data: data,yearList: getYear.sort{it}.reverse(),params:params]
	}
	@Secured(['ROLE_USER'])
	def citGenerator() {
		def getYear = PayRoll.executeQuery("select distinct a.year from PayRoll a");
		def temp=[]
		def columns = [
			'sno':'SNo',
			'id':'Id',
			'designation':'Designation',
			'fullName':'Full Name',
			'cit':"CIT amount",
			'code':'Code',
			'comment':'Comment'
		]
		def payRoll
		if (params.month && params.year){
			payRoll=PayRoll.findAllByMonthAndYear(params.month,params.year)
		}else if(params.month){
			payRoll=PayRoll.findAllByMonth(params.month)
		}else if (params.year){
			payRoll=PayRoll.findAllByYear(params.year)
		}

		def payRollInstance = PayRollDetail.findAllByPayRollInList(payRoll)

		int count=1
		payRollInstance?.each{
			def empList = [:]
			empList['sno'] = count++
			empList['designation'] = it.employee?.designation
			empList['fullName'] = (it?.employee?.employeeFirstName)+' '+(it.employee.employeeMiddleName?it.employee.employeeMiddleName:'')+' '+(it?.employee?.employeeLastName)
			empList['id'] = it?.employee?.uniqueEmployeeId
			empList['citNumber'] =it.employee?.citNumber
			empList['comment']='--'
			double cit = it.cit
//			DecimalFormat f = new DecimalFormat("##.00");
//			empList['cit'] = f.format(cit)
			empList['cit'] = cit.round(2)
			temp.push(empList)
		}
		if (params.format){
			def date = String.format('%tm/%<td/%<tY', new Date());
			response.contentType = ConfigurationHolder.config.grails.mime.types['excel']
			response.setHeader("Content-disposition", "attachment; filename=CIT-${date}.xls")
			response.setHeader("Cache-Control", "")
			response.setHeader("Pragma","")
			exportService.export('excel', response.outputStream, temp, columns.keySet() as List, columns,  null, null)
			return;
		}

		def highchartCit
		def highchartBasicSalary
		def totalCit=[]
		def basicSalary=[]
		/*def test= PayRoll.executeQuery("select id from PayRoll where month='Jan'")
	//        def test= PayRoll.executeQuery("select id from PayRoll where year='2013'")
		  test?.each{
			highchartCit=PayRollDetail.executeQuery("select sum(cit) from PayRollDetail where payRoll=${it}")
			highchartBasicSalary=PayRollDetail.executeQuery("select sum(basicSalary) from PayRollDetail where payRoll=${it}")
			totalCit.push(Math.ceil(highchartCit[0] * 2 ) / 2)
			basicSalary.push(Math.ceil(highchartBasicSalary[0] * 2 ) / 2)
		  }*/
		[employeeList: temp, yearList:getYear.sort{it}.reverse(), highchart:totalCit, basicSalary:basicSalary ]
	}
	@Secured(['ROLE_USER'])
	def incomeTaxExport(){
		def getYear = PayRoll.executeQuery("select distinct a.year from PayRoll a");
		def temp=[]
		int count=1
		def columns = [
			'sno':'SNo',
			'employeeId':'Employee Id',
			'fullName':'Full Name',
			'date':"Issued Date",
			'amount':'Basic Salary',
			'incomeTax':'Income Tax',
			'comment':'Comment'
		]
		def payRollList=null
		if (params.month && params.year){
			payRollList=PayRoll.findAllByMonthAndYear(params.month,params.year)
		}else if(params.month){
			payRollList=PayRoll.findAllByMonth(params.month)
		}else if (params.year){
			payRollList=PayRoll.findAllByYear(params.year)
		}
		def payRollDetails= PayRollDetail.findAllByPayRollInList(payRollList)
		payRollDetails.each{
			double amount =it.basicSalary
			DecimalFormat f = new DecimalFormat("##.00");
			def empList = [:]
			empList['sno'] = count++
			empList['employeeId'] = it.employee.uniqueEmployeeId
			empList['fullName'] = it.employee
			empList['date'] = params.month+" "+params.year
			empList['amount'] = f.format(amount)
			empList['comment']='--'
			empList['incomeTax'] = f.format(it.incomeTax)
			temp.push(empList)
		}
		if (params.format){
			def date = String.format('%tm/%<td/%<tY', new Date());
			response.contentType = ConfigurationHolder.config.grails.mime.types['excel']
			response.setHeader("Content-disposition", "attachment; filename=IncomeTax-${date}.xls")
			response.setHeader("Cache-Control", "")
			response.setHeader("Pragma","")
			exportService.export('excel', response.outputStream, temp, columns.keySet() as List, columns,  null, null)
			return;
		}
		def highchartIncomeTax
		def highchartBasicSalary
		def totalIncomeTax=[]
		def basicSalary=[]
		/*def test= PayRoll.executeQuery("select id from PayRoll where month='Jan' AND year='2013'")
	//        def test1=PayRollDetail.executeQuery("select id from PayRollDetail where payRoll=${test[0]}")
		  test?.each{
			highchartIncomeTax=PayRollDetail.executeQuery("select sum(cit) from PayRollDetail where payRoll=${it}")
			highchartBasicSalary=PayRollDetail.executeQuery("select sum(basicSalary) from PayRollDetail where payRoll=${it}")
			totalIncomeTax.push(Math.ceil(highchartIncomeTax[0] * 2 ) / 2)
			basicSalary.push(Math.ceil(highchartBasicSalary[0] * 2 ) / 2)
		  }*/
		[list:temp, yearList: getYear.sort{it}.reverse(), highchart: totalIncomeTax, basicSalary: basicSalary]
	}
	@Secured(['ROLE_USER'])
	def exportData(){
		def username=grailsApplication.config.dataSource.username
		def password=grailsApplication.config.dataSource.password
		String databaseName=grailsApplication.config.dataSource.dbName;
		def root = getServletContext().getRealPath("");
		Process p = null;
		def t=new SimpleDateFormat("yyyMMMdd_hhmmss").format(new Date()).toString()
		try {
			Runtime runtime = Runtime.getRuntime();
			String filename= root+"/DBackUP/"+"database"+t+".sql";
			String cmd="";
			if(password.length()==0){
				cmd="mysqldump -h localhost -u"+username+" -c --add-drop-table --add-locks --quick --lock-tables "+databaseName+" > "+filename;
			}else{
				cmd="mysqldump -h localhost -u"+username+" -p"+password+" -c --add-drop-table --add-locks --quick --lock-tables "+databaseName+" > "+filename;
			}
			println cmd
			String[] par=["bash","-c",cmd]
			p = runtime.exec(par);
			int processComplete = p.waitFor();
			if (processComplete == 0) {
				File file = new File( filename);
				int length   = 0;
				ServletOutputStream outStream = response.getOutputStream();
				String mimetype = getServletContext().getMimeType(filename);

				if (mimetype == null) {
					mimetype = "application/octet-stream";
				}
				response.setContentType(mimetype);
				response.setContentLength((int)file.length());

				response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

				byte[] byteBuffer = new byte[1024];
				DataInputStream input = new DataInputStream(new FileInputStream(file));

				while ((input != null) && ((length = input.read(byteBuffer)) != -1))
				{
					outStream.write(byteBuffer,0,length);
				}
				input.close();
				outStream.close();
			}else{
				render "Fail to backup database."
			}
		} catch (Exception e) {
			e.printStackTrace();
			render "Error occured!! Please try again"
		}
	}

	private ZipFile zippedFile(String filename){
		//String randomPassword=DssUtility.generatePassword()
		String randomPassword='abcdef'
		println randomPassword
		String zipFileName = filename + "zippedFile.zip";
		ZipFile zipFile = new ZipFile(zipFileName);

		zipFile.setFileNameCharset(InternalZipConstants.CHARSET_UTF8);

		ZipParameters parameters = new ZipParameters();
		parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE);

		// Set the compression level
		parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);
		//	parameters.setEncryptFiles(true);
		parameters.setEncryptionMethod(Zip4jConstants.ENC_METHOD_AES);
		parameters.setAesKeyStrength(Zip4jConstants.AES_STRENGTH_256);
		//	parameters.setPassword(randomPassword);
		zipFile.addFile(new File(filename),parameters)
		return zipFile
	}

	private void zipFile(filename){
		//String randomPassword=DssUtility.generatePassword()
		String randomPassword='abcdef'
		println randomPassword
		File file=new File(filename+"zipFile.zip")
		ZipEncryptOutputStream zeos = new ZipEncryptOutputStream(new FileOutputStream(file), randomPassword);
		// create the standard zip output stream, initialize it with our encrypting stream
		ZipOutputStream zos = new ZipOutputStream(zeos);

		ZipEntry ze = new ZipEntry(filename);
		zos.putNextEntry(ze);
		InputStream is = new FileInputStream(filename);
		int b;
		while ((b = is.read()) != -1) {
			zos.write(b);
		}
		zos.closeEntry();
		zos.close();
	}
    def employeeDetails(){
        def columns=['sn':'SN',
                'name':'Name',
                'month':'Month',
                'dates':'Year',
                'basicSalary':'Basic Salary',
                'taxAmount':'Social Security Tax',
                'iTax':'Income Tax',
                'cit':'CIT Amount',
                'pf':'PF Amount',
                'bonus':'Bonus',
                'dashianBonus':'Dashain Bonus',
                'food':'Food Deduction'
        ]
        def getYear = PayRoll.executeQuery("select distinct a.year from PayRoll a");
        def getEmployee=params.id
        Employee emp=Employee.findById(getEmployee)
        def currentYear
        def payRollList=null
        if (params.year){
            payRollList=PayRoll.findAllByYear(params.year)
        }else{
            Calendar cal=Calendar.getInstance();
            currentYear=cal.get(Calendar.YEAR)
            payRollList=PayRoll.findAllByYear(currentYear)
        }
        def payRollDetails= PayRollDetail.findAllByPayRollInListAndEmployee(payRollList,emp)
        Map temp=new HashMap()
        def data=[]
        int snCount = 1
        def totalTaxAmount=0
        def totalIncomeTaxAmount=0
        def totalBasicSalary=0
        def totalCit=0
        def totalPf=0
        def totalFoodAmt=0
        def totalBonus=0
        def totalDashainBonus=0
        def tempList=[:]
        tempList['Social Security Tax']=[]
        tempList['Income Tax']=[]
        tempList['Basic Salary']=[]
        tempList['CIT']=[]
        tempList['Provident Fund']=[]
        tempList['Food Deduction']=[]
        tempList['Bonus']=[]
        tempList['Dashain Bonus']=[]
        def months=[]
        payRollDetails.each{
            temp = [:]
            temp['sn']=snCount++
            temp['taxAmount']=it.socialSecurityTax
            totalTaxAmount=totalTaxAmount+it.socialSecurityTax
            def employeeFirstName=it.employee.employeeFirstName
            def employeeLastName=it.employee.employeeLastName
            temp['name']=employeeFirstName +" "+(it.employee.employeeMiddleName?it.employee.employeeMiddleName:'')+ " "+employeeLastName
            temp['iTax']=it.incomeTax
            totalIncomeTaxAmount=totalIncomeTaxAmount+it.incomeTax
            temp['basicSalary']=it.basicSalary
            totalBasicSalary=totalBasicSalary+it.basicSalary
            temp['dates']=it.payRoll.year
            temp['month']=Month.valueOf(it.payRoll.month).getValue();
            temp['cit']=it.cit
            totalCit=totalCit+it.cit
            temp['pf']=it.providentFund
            totalPf=totalPf+it.providentFund
            temp['food']=it.foodDeduction
            totalFoodAmt=totalFoodAmt+it.foodDeduction
            temp['bonus']=it.bonus
            totalBonus=totalBonus+it.bonus
            temp['dashianBonus']=it.dashainBonus
            totalDashainBonus=totalDashainBonus+it.dashainBonus
            tempList['Social Security Tax'].add(it.socialSecurityTax)
            tempList['Income Tax'].add(it.incomeTax)
            tempList['Basic Salary'].add(it.basicSalary)
            tempList['CIT'].add(it.cit)
            tempList['Provident Fund'].add(it.providentFund)
            tempList['Food Deduction'].add(it.foodDeduction)
            tempList['Bonus'].add(it.bonus)
            tempList['Dashain Bonus'].add(it.dashainBonus)
            months.add("'"+Month.valueOf(it.payRoll.month).value+"'")
	        temp['id'] = it.id
            data.add(temp)
        }
        Map totalRow=[:]
        totalRow=['sn':'','name':'Total','month':'','dates':'','iTax':totalIncomeTaxAmount.round(2),'basicSalary':totalBasicSalary.round(2),'taxAmount':totalTaxAmount.round(2),'cit':totalCit.round(2),'pf':totalPf.round(2),'bonus':totalBonus.round(2),'dashianBonus':totalDashainBonus.round(2),'food':totalFoodAmt.round(2)]
        data.add(totalRow)
        if (params.format){
            def date = String.format('%tm/%<td/%<tY', new Date());
            response.contentType = ConfigurationHolder.config.grails.mime.types['excel']
            response.setHeader("Content-disposition", "attachment; filename=EmployeeDetails-${date}.xls")
            response.setHeader("Cache-Control", "")
            response.setHeader("Pragma","")
            exportService.export('excel', response.outputStream, data, columns.keySet() as List, columns,  null, null)
            return;
        }
        [getEmployee:getEmployee,currentYear:currentYear,columns:columns.values() as List,data:data,yearList:getYear.sort{it}.reverse(),params:params,tempList:tempList, month:months]

    }
}

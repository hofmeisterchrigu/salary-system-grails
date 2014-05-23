dataSource {
	pooled = true
	driverClassName = "com.mysql.jdbc.Driver"
	username = "root"
	password = "root"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
	        dbCreate = "update"//"update" // one of 'create', 'create-drop','update'
	        dbName="DeerwalkSalarySystem"
	        url = "jdbc:mysql://localhost/"+dbName+"?zeroDateTimeBehavior=convertToNull"
	        pooled = true
	        username="root"
	        password="root"
	        loggingSql=false
	        properties {
		        maxActive = 50
		        maxIdle = 25
		        minIdle = 1
		        initialSize = 1
		        minEvictableIdleTimeMillis = 60000
		        timeBetweenEvictionRunsMillis = 60000
		        numTestsPerEvictionRun = 3
		        maxWait = 10000

		        testOnBorrow = true
		        testWhileIdle = true
		        testOnReturn = false

		        validationQuery = "SELECT 1"
	        }
        }
    }
    test {
        dataSource {
	        dbCreate = "update"//"update" // one of 'create', 'create-drop','update'
	        dbName="DeerwalkSalarySystem"
	        url = "jdbc:mysql://localhost/"+dbName+"?zeroDateTimeBehavior=convertToNull"
	        pooled = true
	        username="root"
	        password="root"
	        loggingSql=false
	        properties {
		        maxActive = 50
		        maxIdle = 25
		        minIdle = 1
		        initialSize = 1
		        minEvictableIdleTimeMillis = 60000
		        timeBetweenEvictionRunsMillis = 60000
		        numTestsPerEvictionRun = 3
		        maxWait = 10000

		        testOnBorrow = true
		        testWhileIdle = true
		        testOnReturn = false

		        validationQuery = "SELECT 1"
	        }
        }
    }
    production {
        dataSource {
	        dbCreate = "update"//"update" // one of 'create', 'create-drop','update'
	        dbName="DeerwalkSalarySystem"
	        url = "jdbc:mysql://localhost/"+dbName+"?zeroDateTimeBehavior=convertToNull"
	        pooled = true
	        username="root"
	        password="root"
	        loggingSql=false
	        properties {
		        maxActive = 50
		        maxIdle = 25
		        minIdle = 1
		        initialSize = 1
		        minEvictableIdleTimeMillis = 60000
		        timeBetweenEvictionRunsMillis = 60000
		        numTestsPerEvictionRun = 3
		        maxWait = 10000

		        testOnBorrow = true
		        testWhileIdle = true
		        testOnReturn = false

		        validationQuery = "SELECT 1"
	        }
            }
        }
    }


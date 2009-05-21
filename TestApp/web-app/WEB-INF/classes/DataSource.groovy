dataSource {
	pooled = true
	//driverClassName = "org.hsqldb.jdbcDriver"
	//username = "sa"
	//password = ""
	driverClassName = "com.mysql.jdbc.Driver"
	username = "muench"
	password = "Ying1475"
}
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='com.opensymphony.oscache.hibernate.OSCacheProvider'
}
// environment specific settings
environments {
	development {
		dataSource {
			dbCreate = "create-drop" // one of 'create', 'create-drop','update'
			//url = "jdbc:hsqldb:mem:devDB"
			url = "jdbc:mysql://localhost/billtrack_dev"
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			//url = "jdbc:hsqldb:mem:testDb"
			url = "jdbc:mysql://localhost/billtrack_test"
		}
	}
	production {
		dataSource {
			dbCreate = "update"
			//url = "jdbc:hsqldb:file:prodDb;shutdown=true"
			url = "jdbc:mysql://localhost/billtrack_prod"
		}
	}
}
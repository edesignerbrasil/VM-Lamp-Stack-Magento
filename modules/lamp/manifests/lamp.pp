class lamp::lamp {

	exec { "apt-update":
		command => "/usr/bin/apt-get update"
	}

	include apache2::apache2
	include mysql::server
	include php5::php5	
	include magento::magento

}
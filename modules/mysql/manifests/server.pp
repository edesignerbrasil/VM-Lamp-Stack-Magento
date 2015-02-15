class mysql::server {
	
	package { "mysql-server":
		ensure => installed,
		require => Exec["apt-update"],
	}

	service { "mysql":
		ensure => running,
		enable => true,
		hasstatus => true,
		hasrestart => true,
		require => Package["mysql-server"],
	}

	exec { "loja-schema":
	unless => "mysql -u root loja_schema",
	command => "mysqladmin -uroot create loja_schema",
	path => "/usr/bin/",
	require => Service["mysql"],
	}

	exec { "remove-anonymous-user":
		command => "mysql -u root -e \"DELETE FROM mysql.user WHERE user=''; FLUSH PRIVILEGES\"",
		onlyif => "mysql -u ' '",
		path => "/usr/bin",
		require => Service["mysql"],
	}

	exec { "loja-user":
		unless => "mysql -u loja -p lojasecret loja_schema",
		command => "mysql -u root -e \"GRANT ALL PRIVILEGES ON loja_schema.* TO 'loja'@'%' IDENTIFIED BY 'lojasecret';\"",
		path => "/usr/bin/",
		require => Exec["loja-schema"],
}


}
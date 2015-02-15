class php5::php5 {

	package { "libapache2-mod-php5": ensure => present,  
				require => Package["apache2", "mysql-server"],}
    package { "php5": ensure => present,
    	require => Package["apache2", "mysql-server"], }
    package { "php5-cli": ensure => present,
    	require => Package["apache2", "mysql-server"], }
    package { "php5-dev": ensure => present,
    	require => Package["apache2", "mysql-server"], }
    package { "php5-mysql": ensure => present, 
    	require => Package["apache2", "mysql-server"], }
    package { "php-pear": ensure => present, 
    	require => Package["apache2", "mysql-server"], }
    package { "php5-mhash": ensure => present, 
    	require => Package["apache2", "mysql-server"],}
    package { "php5-mcrypt": ensure => present, 
    	require => Package["apache2", "mysql-server"],}
    package { "php5-curl": ensure => present , 
    	require => Package["apache2", "mysql-server"],}
    package { "php5-gd": ensure => present, 
    	require => Package["apache2", "mysql-server"],}
      
    exec { "pear upgrade":
        command => "/usr/bin/pear upgrade",
		require => Package["php-pear"],
    }
}
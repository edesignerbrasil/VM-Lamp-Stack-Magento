class apache2::apache2 {

	package { "apache2":
		ensure => installed,
		require => Exec["apt-update"],
	}

	service { "apache2":
		ensure => running,
		enable => true,
		hasstatus => true,
		hasrestart => true,
		require => Package["apache2"],
	}

	file { "/etc/apache2/sites-available/default":
		ensure	=> present,
		mode => 0644,
		owner => root,
		group => root,				
		require => Package["apache2"],		
		notify => Service["apache2"],
		source => "puppet:///modules/apache2/default",
	}

	exec { "enable-mod_rewrite":
        require => Package["apache2"],
        before => Service["apache2"],
        command => "/usr/sbin/a2enmod rewrite"
    }
}
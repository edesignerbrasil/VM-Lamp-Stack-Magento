class magento::magento {
  
  file { "/var/www/magento":
    ensure => "present",
    owner => "root",
    group => "root",
    mode => "0644",
    source => "puppet:///modules/magento/magento-1.9.1.0.tar.gz", 
    require => Package["apache2", "mysql-server"],      
  }

  exec { "unzip-magento":   
    command => "tar -vzxf /var/www/magento",        
    path => "/bin/",
    require => File["/var/www/magento"],      
  }

  exec { "rename-dir-magento":
    command => "mv magento/ hf/",
    path => "/bin/",
    require => Exec["unzip-magento"],   
  }

  exec { "mv-hf":   
    command => 'mv hf/ /var/www/',
    path => "/bin/",
    require => Exec["rename-dir-magento"],  
    timeout => 0,
    logoutput => on_failure,    
    
  }

  # a fuller example, including permissions and ownership
  file { ["/var/www/hf"]:
    ensure  => "directory",
    owner   => "root",
    group   => "root",
    mode    => "0755",
    recurse => "true",
    require => Exec["mv-hf"],
  }

  file { "/var/www/hf/var/":
    ensure  => "directory",
    owner   => "root",
    group   => "root",
    mode    => "0777",
    recurse => "true",
    require => Exec["mv-hf"],
  }

  file { "/var/www/hf/media":
    ensure  => "directory",
    owner   => "root",
    group   => "root",
    mode    => "0777",
    recurse => "true",
    require => Exec["mv-hf"],
  }

  file { "/var/www/hf/media/*":
    ensure  => "file",
    owner   => "root",
    group   => "root",
    mode    => "0777",
    recurse => "true",
    require => Exec["mv-hf"],
  }
    # permission for media and var directories
  file { ["/var/www/hf/var/cache", "/var/www/hf/var/locks", "/var/www/hf/var/package", "/var/www/hf/var/session"]:
    ensure  => "directory",
    owner   => "root",
    group   => "root",
    mode    => "0667",
    recurse => "true",
    require => File["/var/www/hf/media", "/var/www/hf/var"],
  }

    # permission for media and var directories
  file { ["/var/www/hf/app/etc"]:
    ensure  => "directory",
    owner   => "root",
    group   => "root",
    mode    => "0777",
    recurse => "true",
    require => Exec["mv-hf"],
  }

  file { "/var/www/hf/app/etc/*":
    ensure  => "file",
    owner   => "root",
    group   => "root",
    mode    => "0777",
    recurse => "true",
    require => Exec["mv-hf"],
  }

}
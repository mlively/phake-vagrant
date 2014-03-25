class { 'apt':
  always_apt_update => false
}

apt::source { 'dotdeb':
  location => 'http://packages.dotdeb.org',
  release => 'squeeze',
  repos => 'all',
  key        => '89DF5277',
  key_server => 'keys.gnupg.net'
}

class { 'php': 
  version => latest,
  service_autorestart => false,
  require => Apt::Source['dotdeb']
}

php::module { "xdebug": }

class { 'composer':
  require => [ Class['php'], Package['libaugeas-ruby1.8'] ]
}

package { 'libaugeas-ruby1.8':
    ensure   => 'installed',
}

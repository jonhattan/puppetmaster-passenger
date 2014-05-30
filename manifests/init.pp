# http://docs.puppetlabs.com/guides/passenger.html

class puppetmaster_passenger inherits puppetmaster_passenger::params {
  # Install the Puppet Master Rack Application.
  file {'/usr/share/puppet/rack':
    ensure => directory,
  }
  file {'/usr/share/puppet/rack/puppetmasterd':
    ensure => directory,
  }
  file {'/usr/share/puppet/rack/puppetmasterd/public':
    ensure => directory,
  }
  file {'/usr/share/puppet/rack/puppetmasterd/tmp':
    ensure => directory,
  }
  file {'/usr/share/puppet/rack/puppetmasterd/config.ru':
    ensure => directory,
    owner => 'puppet',
    group => 'puppet',
    source => 'puppet:///modules/puppetmaster_passenger/config.ru',
  }

  # Install passenger and virtualhost.
  @apache::module {'passenger':
    package => $package,
    conf_content => template('puppetmaster_passenger/passenger.conf.erb'),
  }
  apache::conf {'puppetmasterd':
    directives => [
      'Listen 8140'
    ],
  }
  @apache::vhost { 'puppetmaster' :
    ports            => 8140,
    doc_root         => '/usr/share/puppet/rack/puppetmasterd/public/',
    # dir_options    => ['FollowSymLinks'],
    # allow_override => 'All',
    ensure_www       => absent,
    vhost_directives => [template('puppetmaster_passenger/puppetmaster.conf.erb')]
  }
}


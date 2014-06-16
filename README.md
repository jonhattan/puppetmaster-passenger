Puppetmaster Passenger
======================

Configures Apache to run puppetmaster via passenger by following the official
guide at http://docs.puppetlabs.com/guides/passenger.html

Use this module instead of apt/rpm puppetmaster-passenger package to have
fine-grained control on the passenger settings, or vhost configuration.

This module is coupled to:

 * https://github.com/NITEMAN/puppet-apache

And we use it in conjunction with:

 * https://forge.puppetlabs.com/puppetlabs/puppetdb
 * https://forge.puppetlabs.com/fsalum/puppetmaster

Example
=======

hieradata:

```yaml
classes:
- 'apache'
- 'puppetdb'
- 'puppetmaster'
- 'puppetmaster_passenger'

puppetdb::database           : "embedded"
puppetdb::ssl_listen_address : "127.0.0.1"

puppetdb::master::config::puppet_service_name : "apache2"
puppetdb::master::config::puppetdb_server     : "puppet"

puppetmaster::puppetmaster_service_ensure : 'stopped'
puppetmaster::puppetmaster_service_enable : false
puppetmaster::puppetmaster_report         : true
puppetmaster::puppetmaster_autosign       : false
puppetmaster::puppetmaster_reports        : 'store'
puppetmaster::puppetmaster_environmentpath : '$confdir/environments'

puppetmaster_passenger::params::passenger_max_pool_size : 12
```

node.pp:

```
hiera_include('classes','')
```

License
=======
BSD


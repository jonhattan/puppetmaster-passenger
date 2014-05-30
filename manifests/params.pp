class puppetmaster_passenger::params (
  $passenger_high_performance   = 'On',
  $passenger_max_pool_size      = 12,
  $passenger_max_requests       = 1000,
  $passenger_pool_idle_time     = 600,
  $passenger_stat_throttle_rate = 120,
  $rails_auto_detect            = 'On',
) {
  case $::operatingsystem {
    ubuntu, debian: {
      $package = 'libapache2-mod-passenger'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}


# Internal: management of the redis service

class redis::service(
  $ensure      = $redis::params::ensure,

  $servicename = $redis::params::servicename,
  $enable      = $redis::params::enable,
) inherits redis::params {

  $real_ensure = $ensure ? {
    true    => running,
    default => stopped,
  }

  service { $servicename:
    ensure => $real_ensure,
    enable => $enable,
  }

  if $::operatingsystem == 'Darwin' {

    service { 'com.boxen.redis':
      ensure => stopped,
      enable => false,
    }

    ->
    Service[$servicename]
  }

}

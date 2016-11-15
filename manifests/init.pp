# == Class: tune2fs
#
class tune2fs inherits tune2fs::params {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if($::eyp_tune2fs_check_tune2fs==undef)
  {
    fail('tune2fs not found')
  }

  exec { 'which tune2fs eyp-tune2fs':
    command => 'which tune2fs',
    unless  => 'which tune2fs',
  }


}

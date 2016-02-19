# == Class: tune2fs
#
class tune2fs inherits tune2fs::params {

  if($::eyp_tune2fs_check_tune2fs==undef)
  {
    fail('tune2fs not found')
  }


}

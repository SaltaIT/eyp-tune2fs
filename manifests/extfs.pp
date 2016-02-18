define tune2fs::extfs($dev=$name, $max_mount_count='-1') {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  exec { "max_mount_count ${dev}":
    command => "tune2fs -c ${max_mount_count} ${dev}",
    unless  => "tune2fs -l ${dev} | grep 'Maximum mount count' | awk '{ print $NF }' | grep '${max_mount_count}'",
  }

}

tune2fs = Facter::Util::Resolution.exec('bash -c \'which tune2fs 2>/dev/null\'').to_s

unless tune2fs.nil? or tune2fs.empty?
  Facter.add('eyp_tune2fs_check_tune2fs') do
      setcode do
        tune2fs
      end
  end
end

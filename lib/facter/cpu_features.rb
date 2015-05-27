require 'facter'
Facter.add(:cpu_features) do
  confine :kernel => 'FreeBSD'
  setcode do
    features = []
    needle   = 'Features'
    path     = '/var/run/dmesg.boot'
    cmd      = '/usr/bin/grep'

    if File.exist?(path) && File.exist?(cmd)
      grep = Facter::Core::Execution.exec("#{cmd} #{needle} #{path}")
      grep.each_line do |line|
        next unless line =~ /\sFeatures[0-9]*=0x(?:[0-9a-f]+)<([^>]+)>/
        features += Regexp.last_match(1).split(',')
      end
    end

    features.sort
  end
end

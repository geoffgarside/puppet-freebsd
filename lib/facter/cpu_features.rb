require 'facter'
Facter.add(:cpu_features) do
  confine :kernel => 'FreeBSD'
  setcode do
    features = []

    Facter::Core::Execution.exec('/usr/bin/grep Features /var/run/dmesg.boot').each_line do |line|
      next unless line =~ /\sFeatures[0-9]*=0x(?:[0-9a-f]+)<([^>]+)>/
      features += $1.split(',')
    end

    features.sort
  end
end

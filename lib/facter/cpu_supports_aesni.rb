require 'facter'
Facter.add(:cpu_supports_aesni) do
  confine :kernel => 'FreeBSD'
  setcode do
    Facter.value(:cpu_features).include?('AESNI')
  end
end

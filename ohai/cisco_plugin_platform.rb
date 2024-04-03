Ohai.plugin(:Platform) do
  provides 'os', 'platform', 'platform_version', 'platform_family'
  collect_data do
    os 'Cisco IOS'
    platform 'cisco'
    platform_family 'cisco'
    platform_version '15.1'
  end
end

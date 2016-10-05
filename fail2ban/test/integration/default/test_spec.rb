control 'fail2ban' do
describe package('fail2ban') do
  it { should be_installed }
end

 describe service( 'fail2ban') do
 it { should be_enabled }
 it { should be_installed }
 it { should be_running }
 end

['/etc/fail2ban/filter.d/filter.conf', '/etc/fail2ban/fail2ban.conf', '/etc/fail2ban/jail.local'].each do |file|
describe file("#{file}") do
# it { should be_owned_by 'root' }
# it { should be_grouped_into 'root' }
# its('mode') { should eq 00644 }
  end
end
end
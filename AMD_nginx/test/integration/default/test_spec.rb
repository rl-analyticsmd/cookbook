describe command('ps ax | grep nginx') do
  its('exit_status') { should eq 0 }
end

describe runit_service('nginx') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
  its('type') { should be 'upstart' }
end


control 'nginx' do
describe package('nginx') do
  it { should be_installed }
end

['/etc/nginx/wildcard.crt', '/etc/nginx/wildcard.key'].each do |file|
describe file("#{file}") do
end
end

# describe file('/etc/nginx/wildcard.crt') do
#      it { should exist }
#   end

#  describe file('/etc/nginx/wildcard.key') do
#      it { should exist }
#   end

#  describe service('nginx') do
#   #it  { should be_installed }
#   it { should be_enabled }
#   it { should be_running }
# end
end

# control '01' do
#   # impact 0.7
#   # title 'Verify nginx service'
#   # desc 'Ensures nginx service is up and running'
#   describe service( 'nginx') do
#     # it { should be_enabled }
#     # it { should be_installed }
#     it { should be_running }
#   end
# end

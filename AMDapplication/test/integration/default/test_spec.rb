control 'AMDapplication' do

describe package('python') do
  it { should be_installed }
end

['/AMD', '/AMD/logs', '/AMD/medengine'].each do |dir|
describe directory("#{dir}") do
     it { should exist }
  end
end

# describe directory('/AMD/logs') do
#      it { should exist }
#   end

#  describe directory('/AMD/medengine') do
#      it { should exist }
#   end

['requirements.txt', 'local.py', '/amd_deploy.sh'].each do |file|
describe file("#{file}") do
  end
end

['virtualenv', 'setuptools', 'pandas'].each do |pkg|
describe pip("#{pkg}") do
  end
end


['bower', 'phantomjs', 'requirejs','coffeeify'].each do |pkg|
describe npm("#{pkg}") do
  end
end
# describe pip('virtualenv') do
#         it { should be_installed }
#       end


# describe pip('setuptools') do
#         it { should be_installed }
#       end


# describe pip('pandas') do
#         it { should be_installed }
#       end


# describe npm('bower') do
#         it { should be_installed }
#       end


# describe npm('phantomjs') do
#         it { should be_installed }
#       end

# describe npm('requirejs') do
#         it { should be_installed }
#       end



# describe file('/AMD/medengine/requirements.txt') do
#      it { should exist }
#   end

# describe file('/AMD/medengine/config/deployType/local.py') do
#      it { should exist }
#   end

# describe file('/AMD/medengine/amd_deploy.sh') do
#      it { should exist }
#       its('mode') { should eq 755}
#   end


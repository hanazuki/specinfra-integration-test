require 'tempfile'
require 'pry'
require 'specinfra/core'

host = ENV['TARGET_HOST']

ssh_config = Tempfile.new('ssh_config') << Bundler.with_clean_env { `vagrant ssh-config` }
ssh_config.flush

ssh_options = Net::SSH::Config.for(host, [ssh_config.path])
$backend = Specinfra::Backend::Ssh.new(
  request_pty: false,
  host: ssh_options[:host_name],
  ssh_options: ssh_options,
)

puts $backend.os_info

class RSpec::Core::ExampleGroup
  def backend; $backend end
end


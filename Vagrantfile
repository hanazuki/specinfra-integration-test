require_relative 'lib/boxes'

Vagrant.configure(2) do |config|
  BOXES.each do |box|
    config.vm.define box.gsub(/\W/, '-') do |config|
      config.vm.box = box
      config.vm.provision :shell, inline: <<EOF
apt-get update && apt-get install -y --no-install-recommends ntp
EOF
    end
  end
end

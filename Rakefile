require 'bundler/setup'
require 'rspec/core/rake_task'
require_relative 'lib/boxes'

task :default => 'spec'

task :spec => 'spec:all'
namespace 'spec' do
  task :all => BOXES.map {|box| box.gsub('/', ':') }

  BOXES.each do |box|
    host = box.gsub(/\W/, '-')

    desc "Run tests on #{box} ..."
    RSpec::Core::RakeTask.new(box.gsub('/', ':')) do |t|
      puts "Running tests on #{box} ..."
      Bundler.with_clean_env do
        sh %W{vagrant up #{host}}.shelljoin
      end
      ENV['TARGET_HOST'] = host
      t.pattern = "spec/*_spec.rb"
    end
  end
end

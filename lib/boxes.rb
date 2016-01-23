require 'pathname'
require 'yaml'

BOXES = YAML.load_file(Pathname.new(__dir__).dirname + 'boxes.yaml').freeze

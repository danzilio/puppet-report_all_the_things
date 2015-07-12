require 'puppet'

def fixture_path
  File.expand_path(File.join(__FILE__, '..', 'fixtures'))
end

RSpec.configure do |c|
  c.color = true
  c.formatter = 'documentation'
end

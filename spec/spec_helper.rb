require 'puppet'

RSpec.configure do |c|
  c.before(:all) { @fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures')) }
  c.color = true
  c.formatter = 'documentation'
end

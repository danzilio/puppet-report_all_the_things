require 'rake'
require 'rspec/core/rake_task'

# These two gems aren't always present, for instance
# on Travis with --without development
begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
end

RSpec::Core::RakeTask.new(:spec)

desc "Run metadata-json-lint"
task :metadata do
  out = %x{bundle exec metadata-json-lint metadata.json}
  $? != 0 ? (raise out) : (puts "Metadata OK!")
end

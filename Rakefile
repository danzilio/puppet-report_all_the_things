require 'rake'
require 'rspec/core/rake_task'
require 'metadata-json-lint/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'

# These two gems aren't always present, for instance
# on Travis with --without development
begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
end

RSpec::Core::RakeTask.new(:spec)


task :test => [
  :metadata_lint,
  :spec,
]

namespace :strings do
  doc_dir = File.dirname(__FILE__) + '/doc'
  git_uri = `git config --get remote.origin.url`.strip
  vendor_mods = File.dirname(__FILE__) + '/.modules'

  desc "Checkout the gh-pages branch for doc generation."
  task :checkout do
    unless Dir.exist?(doc_dir)
      Dir.mkdir(doc_dir)
      Dir.chdir(doc_dir) do
        system 'git init'
        system "git remote add origin #{git_uri}"
        system 'git pull'
        system 'git checkout -b gh-pages'
      end
    end
  end

  desc "Generate documentation with the puppet strings command."
  task :generate do
    Dir.mkdir(vendor_mods) unless Dir.exist?(vendor_mods)
    system "bundle exec puppet module install puppetlabs/strings --modulepath #{vendor_mods}"
    system "bundle exec puppet strings --modulepath #{vendor_mods}"
  end

  desc "Push new docs to GitHub."
  task :push do
    Dir.chdir(doc_dir) do
      system 'git add .'
      system "git commit -m 'Updating docs for latest build.'"
      system 'git push origin gh-pages'
    end
  end

  desc "Run checkout, generate, and push tasks."
  task :update => [
    :checkout,
    :generate,
    :push,
  ]
end

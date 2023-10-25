# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

# rubocop:disable Lint/SuppressedException
begin
  require "fileutils"
  require "yard"
  require "yard/rake/yardoc_task"

  YARD::Rake::YardocTask.new do |t|
    # rubocop:disable Style/IfUnlessModifier
    if ENV["YARD_CACHE"] == "true"
      t.options = t.options + ["--use-cache"]
    end
    # rubocop:enable Style/IfUnlessModifier
  end

  desc "Generate Yard and Hugo Site"
  task :docsite => :yard do
    FileUtils.cp_r "./doc", "./hugo/static/", preserve: false
    build_command = "hugo"
    if ENV["NVM_VERSION"]
      nvm_v = ENV["NVM_VERSION"]
      build_command = "nvm use #{nvm_v} && " + build_command
    end
    hugo_result = system("bash -lc '#{build_command}'", chdir: "./hugo")
    exit(-1) unless hugo_result
  end

  desc "Serve the hugo site locally"
  task :docserver => :yard do
    FileUtils.cp_r "./doc", "./hugo/static/", preserve: false
    build_command = "hugo serve"
    system("bash -lc '#{build_command}'", chdir: "./hugo")
  end
rescue LoadError
end
# rubocop:enable Lint/SuppressedException
# frozen_string_literal: true

require_relative 'lib/aca_entities/version'

Gem::Specification.new do |spec|
  spec.name = 'aca_entities'
  spec.version = AcaEntities::VERSION
  spec.authors = ['IdeaCrew']
  spec.email = ['info@ideacrew.com']

  spec.summary = 'Domain model for Affordable Care Act (ACA) data entities'
  spec.homepage = 'https://github.com/ideacrew/aca_entities'
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.6')

  # spec.metadata['allowed_push_host'] = 'TODO: Set to 'http://mygemserver.com''

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ideacrew/aca_entities'
  spec.metadata['changelog_uri'] = 'https://github.com/ideacrew/aca_entities/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files =
    Dir.chdir(File.expand_path(__dir__)) do
      `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'deep_merge'
  spec.add_dependency 'dry-container', '~> 0.11'
  spec.add_dependency 'dry-monads', '~> 1.6'
  spec.add_dependency 'dry-struct', '~> 1.6'
  spec.add_dependency 'dry-transformer', '~> 1.0'
  spec.add_dependency 'dry-validation', '~> 1.10'
  spec.add_dependency 'iso_country_codes'
  spec.add_dependency 'nokogiri-happymapper'
  spec.add_dependency 'oj', '~> 3.11'
  spec.add_dependency 'rbnacl', '~> 7.1'
  spec.add_development_dependency 'pry-byebug'
  spec.add_dependency 'json-schema'
end

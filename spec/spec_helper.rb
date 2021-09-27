# frozen_string_literal: true

require 'bundler/setup'
require 'aca_entities'
# require 'pry'

# Load spec dependencies and configs
Dir[File.join('.', 'spec', 'support', 'config', '**', '*.rb')].sort.each do |f|
  require f
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

AcaEntities::Configuration::Encryption.configure do |config|
  config.encrypted_key = ENV['SYMMETRIC_ENCRYPTION_ENCRYPTED_KEY'] || "1234567890ABCDEF"
  config.encrypted_iv = ENV['SYMMETRIC_ENCRYPTION_ENCRYPTED_IV'] || "1234567890ABCDEF"
  config.private_rsa_key = ENV['SYMMETRIC_ENCRYPTION_PRIVATE_KEY'] || "1234567890ABCDEF"
  config.app_env = "test"
end

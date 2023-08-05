# frozen_string_literal: true

require 'bundler/setup'
require 'aca_entities'

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
  config.secret_key = "C639A572E14D5075C526FDDD43E4ECF6B095EA17783D32EF3D2710AF9F359DD4"
  config.iv = "1234567890ABCDEFGHIJKLMN"
end
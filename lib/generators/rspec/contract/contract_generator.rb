# frozen_string_literal: true

require 'generators/rspec'

module Rspec
  module Generators
    # Generate a Domain Contract rspec file
    class ContractGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      class_option :contract_specs, type: :boolean, default: true

      def create_contract_spec
        return unless options[:contract_specs]
        template 'contract_spec.rb', File.join('spec/domain/contracts', class_path, "#{file_name}_contract_spec.rb")
      end
    end
  end
end

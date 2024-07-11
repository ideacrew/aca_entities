# frozen_string_literal: true

module Rspec
  module Generators
    # Generate a Domain Operation rspec file
    class OperationGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      desc 'Create Domain Operation rspec file'

      class_option :operation_specs, type: :boolean, default: true

      def copy_operation_spec_file
        return unless options[:operation_specs]
        template 'operation_spec.rb', File.join('spec/operations', class_path, "#{file_name}_spec.rb")
      end
    end
  end
end

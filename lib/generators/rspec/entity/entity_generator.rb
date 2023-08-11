# frozen_string_literal: true

require 'generators/rspec'

module Rspec
  module Generators
    # Generate a Domain Entity rspec file
    class EntityGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      desc 'Create Domain Entity rspec file'

      class_option :entity_specs, type: :boolean, default: true

      def create_entity_spec
        return unless options[:entity_specs]
        template 'entity_spec.rb', File.join('spec/domain', class_path, "#{file_name}_spec.rb")
      end
    end
  end
end

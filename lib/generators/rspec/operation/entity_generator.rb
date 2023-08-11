# frozen_string_literal: true

require 'generators/rspec'

module Rspec
  module Generators
    # Generate a Domain Entity rspec file
    class EntityGenerator < Base
      desc 'Create Domain Entity rspec file'

      def create_entity_spec
        template 'entity_spec.rb', File.join('spec/domain}', class_path, "#{file_name}_spec.rb")
      end
    end
  end
end

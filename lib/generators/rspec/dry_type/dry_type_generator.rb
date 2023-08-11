# frozen_string_literal: true

require 'generators/rspec'

module Rspec
  module Generators
    # Generate a Domain Types rspec file
    class DryTypeGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Create Domain Types rspec file'

      class_option :install_specs, type: :boolean, default: true

      def create_dry_types_spec_file
        return unless options[:install_specs]
        @app_name = Rails.application.class.name.chomp('::Application').underscore
        template 'dry_types_spec.rb', File.join("spec/domain/#{@app_name}", 'types_spec.rb')
      end
    end
  end
end
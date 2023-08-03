# frozen_string_literal: true

require 'yaml'
require 'erb'

module AcaEntities
  module Operations
    module Yaml
      # Transform a YAML-formatted String into a Hash object
      class Deserialize
        send(:include, Dry::Monads[:result, :do])

        # @param [Hash] params the params to read file
        # @options params [String] yaml String of YAML-structured values
        # @return [Hash] contents in haah form wrapped in Dry::Monads::Result
        def call(params)
          values = yield transform(params)
          Success(values)
        end

        private

        def transform(params)
          # Using YAML.load instead of YAML.safe_load to support multiple versions of ruby(2.x & 3.x)

          # rubocop:disable Security/YAMLLoad
          result = YAML.load(ERB.new(params[:yaml]).result)
          # rubocop:enable Security/YAMLLoad

          Success(result || {})
        rescue Psych::SyntaxError => e
          raise "YAML syntax error occurred while parsing #{params}. " \
                "Error: #{e.message}"
        end
      end
    end
  end
end

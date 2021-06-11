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
          result = YAML.safe_load(ERB.new(params[:yaml]).result, [Symbol])
          Success(result || {})
        rescue Psych::SyntaxError => e
          raise "YAML syntax error occurred while parsing #{params}. " \
                  "Error: #{e.message}"
        end
      end
    end
  end
end

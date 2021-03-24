# frozen_string_literal: true

require 'yaml'
require 'erb'

module AcaEntities
  module Operations
    module Yaml
      # Transform a YAML-formatted String into a Hash object
      class Deserialize
        send(:include, Dry::Monads[:result, :do])

        # @param [String] params YAML String to be transformed deserialized
        # @return [Dry::Monad] parsed values
        def call(params)
          values = yield transform(params)
          Success(values)
        end

        private

        def transform(params)
          result = YAML.load(ERB.new(params).result)
          Success(result || {})
        rescue Psych::SyntaxError => e
          raise "YAML syntax error occurred while parsing #{params}. " \
                  "Error: #{e.message}"
        end
      end
    end
  end
end

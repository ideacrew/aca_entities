# frozen_string_literal: true

module AcaEntities
  module Maps
    module GeoJson

      # Schema and validation rules for the {Maps::GeoJson::Query} operation
      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :geometry_column_name required
      # @option opts [String] :column_names required
      # @option opts [String] :table_name required
      # @option opts [String] :filter optional
      # @return [Dry::Monads::Result] result
      class QueryContract < Dry::Validation::Contract

        params do
          required(:geometry_column_name).filled(:string)
          required(:column_names).filled(:array)
          required(:table_name).filled(:string)
          optional(:filter).maybe(:string)
          optional(:query_method).maybe(:string)
        end

        rule(:column_names).each do
          key.failure(text: "invalid column name", error: result.errors.to_h) if key? && value && !value.is_a?(String)
        end
      end
    end
  end
end

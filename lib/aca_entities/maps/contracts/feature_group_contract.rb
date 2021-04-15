# frozen_string_literal: true

module AcaEntities
  module Maps

    # Schema and validation rules for the {Maps::FeatureGroup} entity
    # @!method call(opts)
    # @param [Hash] opts the parameters to validate using this contract
    # @option opts [Symbol] :key required
    # @option opts [String] :title optional
    # @option opts [String] :feature_collection optional
    # @option opts [String] :style_set optional
    # @option opts [String] :id_property_name optional
    # @option opts [String] :geometry_property_name optional
    # @option opts [String] :info_window_property_name optional
    # @return [Dry::Monads::Result] result
    class FeatureGroupContract < Dry::Validation::Contract
      params do
        required(:key).filled(:symbol)
        optional(:title).maybe(:string)
        optional(:feature_collection).maybe(:hash)
        optional(:style_set).array(:hash)

        optional(:id_property_name).maybe(:string)
        optional(:geometry_property_name).maybe(:string)
        optional(:info_window_property_name).maybe(:string)
      end

    end
  end
end

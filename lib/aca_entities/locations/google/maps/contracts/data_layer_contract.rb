# frozen_string_literal: true

module AcaEntities
  module Locations
    module Google
      module Maps
        # Schema and validation rules for the {AcaEntities::Locations::Google::Maps::DataLayer} entity
        class DataLayerContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :type required
          # @option opts [Hash] :fetures required
          # @return [Dry::Monads::Result] result
          json do
            required(:type).filled(:string)
            required(:features).array(:hash)
          end

          rule(:features) do
            if key? && AcaEntities::Locations::GeoJson::Feature
              value.each do |feature|
                puts feature.inspect
                result = Google::Maps::CreateFeatureContract.new.call(feature)
                key.failure(text: "Can't parse feature", errors: result.errors.to_h) unless result.errors.empty?
              end
            end
          end
        end
      end
    end
  end
end

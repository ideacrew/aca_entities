# frozen_string_literal: true

module AcaEntities
  module Google
    module Maps
      # contract for google maps CreateDataLayer
      class CreateDataLayerContract < Dry::Validation::Contract
        json do
          required(:type).filled(:string)
          required(:features).array(:hash)
        end

        rule(:features) do
          if key? && Maps::GeoJson::Feature
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
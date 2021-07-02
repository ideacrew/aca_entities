# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for TribalAugmentation.
      class TribalAugmentationContract < Dry::Validation::Contract

        params do
          optional(:recognized_tribe_indicator).maybe(:bool)
          optional(:american_indian_or_alaska_native_indicator).maybe(:bool)
          optional(:person_tribe_name).maybe(:string)        
          optional(:location_state_us_postal_service_code).maybe(:string)        
        end
      end
    end
  end
end

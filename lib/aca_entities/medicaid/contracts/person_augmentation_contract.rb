# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PersonAugmentation.
      class PersonAugmentationContract < Dry::Validation::Contract

        params do
          optional(:us_veteran_indicator).maybe(:bool)
          optional(:married_indicator).maybe(:bool)
          optional(:preferred_languages).maybe(:array)        
          optional(:contacts).maybe(:array)        
          optional(:persons).maybe(:array)        
        end
      end
    end
  end
end

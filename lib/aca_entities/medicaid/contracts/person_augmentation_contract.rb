# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PersonAugmentation.
      class PersonAugmentationContract < Dry::Validation::Contract

        params do
          optional(:us_veteran_indicator).maybe(:bool)
          optional(:us_naturalized_citizen_indicator).maybe(:bool)
          optional(:married_indicator).maybe(:bool)
          optional(:pregnancy_status).maybe(:hash)
          optional(:preferred_languages).maybe(:array)
          optional(:incomes).maybe(:array)
          optional(:expenses).maybe(:array)
          optional(:employments).maybe(:array)
          optional(:contacts).maybe(:array)
          optional(:persons).maybe(:array)
          optional(:person_identifications).maybe(:array)
        end
      end
    end
  end
end

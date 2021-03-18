# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for ChipPregnancyCategoryBasis
      class ChipPregnancyCategoryBasisContract < Dry::Validation::Contract

        params do
          required(:category_code).maybe(:string)
          optional(:category_indicator).maybe(:bool)
          optional(:category_determination_date).maybe(:date_time)
          optional(:ineligibility_reason).maybe(:string)
        end
      end
    end
  end
end

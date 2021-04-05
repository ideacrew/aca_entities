# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for ChipPregnancyCategoryBasis
      class ChipResidencyBasisContract < Dry::Validation::Contract

        params do
          required(:status_code).filled(:string)
          optional(:status_indicator).maybe(:bool)
          optional(:status_determination_date).maybe(:date_time)
          optional(:ineligibility_reason).maybe(:string)
        end
      end
    end
  end
end

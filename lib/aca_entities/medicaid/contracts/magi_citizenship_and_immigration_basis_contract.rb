# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for MagiCitizenshipAndImmigrationBasis
      class MagiCitizenshipAndImmigrationBasisContract < Dry::Validation::Contract

        params do
          required(:status_code).filled(:string)
          optional(:status_indicator).maybe(:bool)
          optional(:determination_date).maybe(:date_time)
          optional(:inconsistency_reason).maybe(:string)
          optional(:ineligibility_reason).maybe(:string)
        end
      end
    end
  end
end

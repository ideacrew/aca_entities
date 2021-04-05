# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for MagiIncomeBasis
      class MagiIncomeBasisContract < Dry::Validation::Contract

        params do
          required(:medicaid_status_code).filled(:string)
          optional(:medicaid_status_indicator).maybe(:bool)
          optional(:medicaid_inconsistency_reason).maybe(:string)
          optional(:medicaid_ineligibility_reason).maybe(:string)
          optional(:medicaid_status_determination_date).maybe(:date_time)
          optional(:income_verified_data_source).maybe(:string)
          optional(:annual_income_verification_status).maybe(:bool)
          optional(:annual_income_inconsistency_reason).maybe(:string)
          optional(:annual_income_determination_date).maybe(:date_time)
          optional(:annual_income_verification_source).maybe(:string)
          optional(:income_eligible_under_rpc).maybe(:bool)
          optional(:applicable_medicaid_standard).maybe(:integer)
        end
      end
    end
  end
end

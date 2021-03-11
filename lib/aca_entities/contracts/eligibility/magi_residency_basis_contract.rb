# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Eligibility
      # contract for MagiResidencyBasis
      class MagiResidencyBasisContract < Dry::Validation::Contract

        params do
          required(:status_code).filled(:string)
          optional(:status_indicator).maybe(:bool)
          optional(:ineligibility_reason).maybe(:string)
          optional(:determination_date).maybe(:date_time)
          optional(:pend_reason).maybe(:string)
          optional(:student_residency_rule_applies).maybe(:bool)
          optional(:medicaid_correct_state).maybe(:bool)
        end
      end
    end
  end
end

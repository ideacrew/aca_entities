# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for FosterCare.
      class FosterCareContract < Dry::Validation::Contract
        include ::AcaEntities::AppHelper

        params do
          required(:age_of_applicant).filled(:integer)
          optional(:is_former_foster_care).maybe(:bool)
          optional(:age_left_foster_care).maybe(:integer)
          optional(:foster_care_us_state).maybe(Types::UsStateAbbreviationKind)
          optional(:had_medicaid_during_foster_care).maybe(:bool)
        end

        rule(:is_former_foster_care) do
          if Types::FosterCareRange.cover?(values[:age_of_applicant]) && check_if_blank?(value)
            key.failure(text: "must be filled if age of applicant is within #{Types::FosterCareRange}.")
          end
        end

        rule(:age_left_foster_care) do
          if Types::FosterCareRange.cover?(values[:age_of_applicant]) && check_if_blank?(value) && values[:is_former_foster_care]
            key.failure(text: "must be filled if age of applicant is within #{Types::FosterCareRange}.")
          end
        end

        rule(:foster_care_us_state) do
          if Types::FosterCareRange.cover?(values[:age_of_applicant]) && check_if_blank?(value) && values[:is_former_foster_care]
            key.failure(text: "must be filled if age of applicant is within #{Types::FosterCareRange}.")
          end
        end

        rule(:had_medicaid_during_foster_care) do
          if Types::FosterCareRange.cover?(values[:age_of_applicant]) && check_if_blank?(value) && values[:is_former_foster_care]
            key.failure(text: "must be filled if age of applicant is within #{Types::FosterCareRange}.")
          end
        end
      end
    end
  end
end

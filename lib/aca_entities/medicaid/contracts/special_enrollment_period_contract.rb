# frozen_string_literal: true

# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for SpecialEnrollmentPeriod
      class SpecialEnrollmentPeriodContract < Dry::Validation::Contract

        params do
          optional(:married_with_in_last_60_days_code).maybe(:string)
          optional(:date_married).maybe(:date)
          optional(:will_loss_coverage_in_next_60_days_code).maybe(:string)
          optional(:adopted_in_last_60_days_code).maybe(:string)
          optional(:date_of_adoption).maybe(:date)
          optional(:eligible_immigration_status_in_last_60_days_code).maybe(:string)
          optional(:move_with_in_last_60_days_code).maybe(:string)
          optional(:moved_from_zip_code).maybe(:string)
          optional(:previous_county_name).maybe(:string)
          optional(:date_moved).maybe(:date)
          optional(:incarceration_release_with_in_last_60_days_code).maybe(:string)
          optional(:date_released_from_incarceration).maybe(:date)
          optional(:date_gained_eligible_immigration_status).maybe(:date)
        end
      end
    end
  end
end

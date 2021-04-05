# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for CoveragePeriod.
      class CoveragePeriodContract < Dry::Validation::Contract

        params do
          optional(:start_date).maybe(:date)
          optional(:start_reason_text).maybe(:string)
          optional(:end_date).maybe(:date)
          optional(:end_reason_text).maybe(:string)
        end
      end
    end
  end
end

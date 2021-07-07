# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for StatusValidDateRange.
      class StatusValidDateRangeContract < Dry::Validation::Contract

        params do
          # optional(:start_date).maybe(:date)
          optional(:end_date).maybe(:hash)      
        end
      end
    end
  end
end

# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for SsaWorkQuarter.
      class SsaWorkQuarterContract < Dry::Validation::Contract

        params do
          optional(:work_year_date).maybe(:date)
          optional(:quarters_earned).maybe(:integer)
        end
      end
    end
  end
end

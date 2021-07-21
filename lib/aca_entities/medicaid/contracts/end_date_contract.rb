# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # End date information contract
      class EndDateContract < Dry::Validation::Contract
        params do
          optional(:date).maybe(:date)
          optional(:date_time).maybe(:date_time)
          optional(:year).maybe(:string)
          optional(:year_month).maybe(:string)
        end
      end
    end
  end
end
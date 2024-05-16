# frozen_string_literal: true

# Encapsulates an address
module AcaEntities
  module Time
    module Contracts
      class MonthsOfYearContract < Contract
        params do
          optional(:id).maybe(:string)

          optional(:month_1).value(:hash)
          optional(:month_2).value(:hash)
          optional(:month_3).value(:hash)
          optional(:month_4).value(:hash)
          optional(:month_5).value(:hash)
          optional(:month_6).value(:hash)
          optional(:month_7).value(:hash)
          optional(:month_8).value(:hash)
          optional(:month_9).value(:hash)
          optional(:month_10).value(:hash)
          optional(:month_11).value(:hash)
          optional(:month_12).value(:hash)

          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

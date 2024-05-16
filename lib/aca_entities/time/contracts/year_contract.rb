# frozen_string_literal: true

# Encapsulates an address
module AcaEntities
  module Time
    module Contracts
      class YearContract < Contract
        params do
          optional(:id).maybe(:string)

          required(:name).value(:integer)
          required(:title).value(:string)
          required(:topic).value(:string)
          optional(:months).value(AcaEntities::Time::Contracts::MonthsOfYear.params)
          optional(:quarters).value(AcaEntities::Time::Contracts::QuartersOfYear.params)

          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

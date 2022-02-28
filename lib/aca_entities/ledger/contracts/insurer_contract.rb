# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Insurer}
      class InsurerContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:hios_id).filled(:string)
          optional(:name).maybe(:string)
          optional(:description).maybe(:string)
          optional(:user_fee_reports).array(UserFeeReportContract.params)

          # optional(:billing_periods)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

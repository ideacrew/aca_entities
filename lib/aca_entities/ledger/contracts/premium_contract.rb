# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Premium}
      class PremiumContract < Contract
        params do
          optional(:id).filled(:string)
          optional(:product).filled(ProductContract.params)
          optional(:rating_area).filled(:string)
          optional(:member_age_on_effective_date).filled(:integer)
          optional(:amount).filled(:date)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Premium}
      class PremiumContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:product).filled(ProductContract.params)
          required(:rating_area_id).filled(:string)
          required(:member_age_on_effective_date).filled(:integer)
          required(:amount).filled(:float)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Member}
      class MemberContract < Contract
        params do
          optional(:id).value(:string)
          optional(:hbx_id).filled(:string)
          optional(:issuer_assigned_id).filled(:string)
          optional(:person_name).filled(AcaEntities::People::PersonName)
          optional(:is_tobacco_user).filled(:bool)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

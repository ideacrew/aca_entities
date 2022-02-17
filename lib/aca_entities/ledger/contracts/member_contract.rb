# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Member}
      class MemberContract < Contract
        params do
          optional(:id).value(:string)
          required(:hbx_id).filled(:string)
          optional(:insurer_assigned_id).maybe(:string)
          required(:person_name).filled(AcaEntities::Contracts::People::PersonNameContract.params)
          optional(:is_tobacco_user).maybe(:bool)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

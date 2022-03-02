# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Member}
      class MemberContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:hbx_id).filled(:string)
          optional(:insurer_assigned_id).maybe(:string)
          required(:subscriber_hbx_id).filled(:string)
          optional(:insurer_assigned_subscriber_id).maybe(:string)
          required(:person_name).filled(AcaEntities::Contracts::People::PersonNameContract.params)
          optional(:ssn).maybe(:string)
          optional(:dob).maybe(:date)
          optional(:gender).maybe(AcaEntities::Types::BinaryGenderKind)
          optional(:tax_household_id).maybe(:integer)
          optional(:relationship_code).maybe(:string)
          optional(:is_subscriber).maybe(:bool)
          optional(:is_tobacco_user).maybe(:bool)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

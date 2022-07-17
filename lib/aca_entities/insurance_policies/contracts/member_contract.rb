# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for {AcaEntities::InsurancePolicies::Member}
      class MemberContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:member_id).filled(:string)
          optional(:insurer_assigned_id).maybe(:string)
          required(:person_name).filled(AcaEntities::Contracts::People::PersonNameContract.params)
          optional(:encrypted_ssn).maybe(:string)
          required(:dob).filled(:date)
          required(:gender).maybe(AcaEntities::Types::BinaryGenderKind)

          # TODO: Add relationship attrib
          # required(:relationship).maybe(AcaEntities::Contracts::People::PersonRelationshipContract.params)
          optional(:tax_household_id).maybe(AcaEntities::Types::StringOrNil)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

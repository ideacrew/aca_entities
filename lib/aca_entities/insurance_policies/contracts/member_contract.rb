# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for {AcaEntities::InsurancePolicies::Member}
      class MemberContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:hbx_id).filled(:string)
          optional(:insurer_assigned_id).maybe(:string)
          required(:person_name).filled(AcaEntities::Contracts::People::PersonNameContract.params)
          optional(:ssn).maybe(:string, size?: 9)
          required(:dob).filled(:date)
          optional(:gender).maybe(AcaEntities::Types::BinaryGenderKind)
          optional(:relationship).maybe(:AcaEntities::Contracts::People::PersonRelationshipContract.params)
          optional(:tax_household_id).maybe(AcaEntities::Types::StringOrNil)
          optional(:is_tobacco_user).maybe(AcaEntities::Types::BoolOrNil)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

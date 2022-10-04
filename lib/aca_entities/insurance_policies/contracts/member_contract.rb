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
          optional(:relationship_code).maybe(:string)
          optional(:addresses).array(AcaEntities::Locations::Contracts::SiteAddressContract.params)
          optional(:emails).array(AcaEntities::Contracts::Contacts::EmailContactContract.params)
          optional(:phones).array(AcaEntities::Contracts::Contacts::PhoneContactContract.params)
          optional(:irs_group_id).maybe(AcaEntities::Types::StringOrNil)
          optional(:tax_household_id).maybe(AcaEntities::Types::StringOrNil)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end

        rule(:relationship_code) do
          # TODO: when relationship is present, if this Member's relationship is 'self' then:
          #   at least one site address must be present for service/rating area determination
        end
      end
    end
  end
end

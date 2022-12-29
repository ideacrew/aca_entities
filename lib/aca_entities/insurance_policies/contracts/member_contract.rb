# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for {AcaEntities::InsurancePolicies::Member}
      class MemberContract < Contract
        params do
          optional(:id).maybe(:string)
          optional(:member_id).maybe(:string)
          required(:hbx_id).filled(:string)
          optional(:insurer_assigned_id).maybe(:string)
          required(:person_name).filled(AcaEntities::Contracts::People::PersonNameContract.params)
          optional(:encrypted_ssn).maybe(:string)
          optional(:dob).filled(:date)
          optional(:gender).maybe(AcaEntities::Types::BinaryGenderKind)
          optional(:relationship_code).maybe(:string)
          optional(:addresses).array(AcaEntities::Locations::Contracts::SiteAddressContract.params)
          optional(:emails).array(AcaEntities::Contracts::Contacts::EmailContactContract.params)
          optional(:phones).array(AcaEntities::Contracts::Contacts::PhoneContactContract.params)

          # optional(:irs_group_id).maybe(AcaEntities::Types::StringOrNil)
          # optional(:tax_household_id).maybe(AcaEntities::Types::StringOrNil)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end

        # site address must be present for contract holders to support service/rating area determination
        # rule(:is_contract_holder) do
        #   # TODO: site address required when member is contract holder
        # end
      end
    end
  end
end

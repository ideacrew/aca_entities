# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Application}
      class ApplicationContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :family_reference required
        # @option opts [Integer] :assistance_year required
        # @option opts [Date] :aptc_effective_date required
        # @option opts [Integer] :years_to_renew optional
        # @option opts [Integer] :renewal_consent_through_year optional
        # @option opts [Boolean] :is_ridp_verified optional
        # @option opts [Boolean] :is_renewal_authorized optional
        # @option opts [AcaEntities::MagiMedicaid::ApplicantContract] :applicants required
        # @option opts [AcaEntities::MagiMedicaid::RelationshipContract] :relationships optional
        # @option opts [AcaEntities::MagiMedicaid::TaxHouseholdContract] :tax_households optional
        # @option opts [String] :us_state required
        # @option opts [String] :hbx_id required
        # @option opts [Date] :oe_start_on required
        # @option opts [Date] :oe_start_on required
        # @option opts [AcaEntities::MagiMedicaid::NoticeOptionsContract] :notice_options required
        # @option opts [AcaEntities::MagiMedicaid::Mitc::Contracts::HouseholdContract] :mitc_households optional
        # @option opts [AcaEntities::MagiMedicaid::Mitc::Contracts::TaxReturnContract] :mitc_tax_returns optional
        # @return [Dry::Monads::Result]
        params do
          required(:family_reference).hash(::AcaEntities::Contracts::Families::FamilyReferenceContract.params)
          required(:assistance_year).filled(:integer)
          optional(:aptc_effective_date).maybe(:date)
          optional(:years_to_renew).maybe(:integer)
          optional(:renewal_consent_through_year).maybe(:integer)
          optional(:is_ridp_verified).maybe(:bool)
          optional(:is_renewal_authorized).maybe(:bool)
          required(:applicants).array(ApplicantContract.params)
          optional(:relationships).array(RelationshipContract.params)
          optional(:tax_households).array(TaxHouseholdContract.params)

          required(:us_state).filled(Types::UsStateAbbreviationKind)
          required(:hbx_id).filled(:string)

          optional(:oe_start_on).maybe(:date)

          optional(:notice_options).maybe(NoticeOptionsContract.params)

          # Set of attributes specific to MitC which helps to not have much logic in IapTo MitC Transform.
          optional(:mitc_households).array(AcaEntities::MagiMedicaid::Mitc::Contracts::HouseholdContract.params)
          optional(:mitc_tax_returns).array(AcaEntities::MagiMedicaid::Mitc::Contracts::TaxReturnContract.params)
        end
      end
    end
  end
end

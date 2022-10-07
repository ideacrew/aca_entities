# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::TaxHouseholdMember}
      class TaxHouseholdMemberContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :product_eligibility_determination optional
        # @option opts [Hash] :applicant_reference required
        # @return [Dry::Monads::Result]
        params do
          optional(:product_eligibility_determination).maybe(ProductEligibilityDeterminationContract.params)
          required(:applicant_reference).maybe(ApplicantReferenceContract.params)
          optional(:is_subscriber).value(:bool?)
          optional(:tax_filer_status).maybe(::AcaEntities::MagiMedicaid::Types::TaxFilerKind)
        end
      end
    end
  end
end

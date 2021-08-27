# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH VerifyNonEsiMECRequestContract
        class IndividualRequestContract < Dry::Validation::Contract
          params do
            required(:Applicant).filled(AcaEntities::Fdsh::NonEsi::H31::ApplicantContract.params)
            required(:LocationStateUSPostalServiceCode).filled(AcaEntities::Types::UsStateAbbreviationKind)
            required(:InsurancePolicy).filled(AcaEntities::Fdsh::NonEsi::H31::InsurancePolicyContract.params)
            optional(:Organization).maybe(AcaEntities::Fdsh::NonEsi::H31::OrganizationContract.params)
          end
        end
      end
    end
  end
end
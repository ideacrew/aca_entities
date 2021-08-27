# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) VerificationRequest
        class IndividualRequest < Dry::Struct
          attribute :Applicant,  Fdsh::NonEsi::H31::Applicant.meta(omittable: false)
          attribute :LocationStateUSPostalServiceCode, AcaEntities::Types::UsStateAbbreviationKind.meta(omittable: false)
          attribute :InsurancePolicy, Fdsh::NonEsi::H31::InsurancePolicy.meta(omittable: false)
          attribute :Organization, Fdsh::NonEsi::H31::Organization.optional.meta(omittable: true)
        end
      end
    end
  end
end
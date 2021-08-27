# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) MECCoverage
        class MECCoverage < Dry::Struct
          attribute :LocationStateUSPostalServiceCode, AcaEntities::Types::UsStateAbbreviationKind.optional.meta(omittable: true)
          attribute :MECVerificationCode, Types::String.meta(omittable: false)
          attribute :Insurances, Types::Array.of(AcaEntities::Fdsh::NonEsi::H31::Insurance).meta(omittable: false)
        end
      end
    end
  end
end
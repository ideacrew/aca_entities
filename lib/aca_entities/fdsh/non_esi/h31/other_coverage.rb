# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) IndividualResponse
        class OtherCoverage < Dry::Struct
          attribute :OrganizationCode, AcaEntities::Fdsh::Types::TDSOrganizationCode.meta(omittable: false)
          attribute :ResponseMetadata, Fdsh::NonEsi::H31::ResponseMetadata.meta(omittable: false)
          attribute :MECCoverage, Fdsh::NonEsi::H31::MECCoverage.optional.meta(omittable: false)
        end
      end
    end
  end
end
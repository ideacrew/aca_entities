# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) OtherCoverage response
        class OtherCoverage < Dry::Struct
          attribute :OrganizationCode, AcaEntities::Fdsh::Types::TDSOrganizationCode.meta(omittable: false)
          attribute :ResponseMetadata, AcaEntities::Fdsh::NonEsi::H31::ResponseMetadata.meta(omittable: false)
          attribute :MECCoverage, AcaEntities::Fdsh::NonEsi::H31::MECCoverage.optional.meta(omittable: false)
        end
      end
    end
  end
end
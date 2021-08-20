# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) MECCoverage
        class Insurance < Dry::Struct
          attribute :InsuranceEffectiveDate, AcaEntities::Fdsh::NonEsi::H31::InsuranceDate.meta(omittable: true)
          attribute :InsuranceEndDate, AcaEntities::Fdsh::NonEsi::H31::InsuranceDate.meta(omittable: true)
        end
      end
    end
  end
end
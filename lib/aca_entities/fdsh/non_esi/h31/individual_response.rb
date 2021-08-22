# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) IndividualResponse
        class IndividualResponse < Dry::Struct
          attribute :Applicant,  AcaEntities::Fdsh::NonEsi::H31::Applicant.meta(omittable: false)
          attribute :PartialResponseIndicator, Types::Bool.meta(omittable: false)
          attribute :OtherCoverages, Types::Array.of(AcaEntities::Fdsh::NonEsi::H31::OtherCoverage).meta(omittable: false)
        end
      end
    end
  end
end
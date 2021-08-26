# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) IndividualResponseSet
        class IndividualResponseSet < Dry::Struct
          attribute :IndividualResponses,  Types::Array.of(AcaEntities::Fdsh::NonEsi::H31::IndividualResponse).meta(omittable: false)
        end
      end
    end
  end
end
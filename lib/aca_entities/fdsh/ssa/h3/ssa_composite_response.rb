# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class SSACompositeResponse < Dry::Struct

          attribute :SSACompositeIndividualResponses,  Types::Array.of(Fdsh::Ssa::H3::SSACompositeIndividualResponse).meta(omittable: true)
          attribute :ResponseMetadata,  AcaEntities::Fdsh::Ssa::H3::ResponseMetadata.meta(omittable: false)
        end
      end
    end
  end
end
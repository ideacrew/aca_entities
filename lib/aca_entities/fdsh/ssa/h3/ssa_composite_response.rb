# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class SSACompositeResponse < Dry::Struct

          attribute :SSACompositeIndividualResponses,  Types::Array.of(Fdsh::Ssa::H3::SSACompositeIndividualResponse).optional.meta(omittable: true)
          attribute :ResponseMetadata,  AcaEntities::Fdsh::Ssa::H3::ResponseMetadata.optional.meta(omittable: true)
        end
      end
    end
  end
end
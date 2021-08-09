# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class SSACompositeIndividualResponse < Dry::Struct

          attribute :ResponseMetadata,  AcaEntities::Fdsh::Ssa::H3::ResponseMetadata.meta(omittable: false)
          attribute :PersonSSNIdentification, Types::String.meta(omittable: false)
          attribute :SSAResponse, AcaEntities::Fdsh::Ssa::H3::SSAResponse.optional.meta(omittable: true)

        end
      end
    end
  end
end
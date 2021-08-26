# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Request
        class SSACompositeRequest < Dry::Struct

          attribute :SSACompositeIndividualRequests,  Types::Array.of(Fdsh::Ssa::H3::SSACompositeIndividualRequest).meta(omittable: false)
        end
      end
    end
  end
end
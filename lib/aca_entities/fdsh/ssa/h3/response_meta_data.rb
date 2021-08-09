# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class ResponseMetadata < Dry::Struct

          attribute :ResponseCode,              Types::String.meta(omittable: false)
          attribute :ResponseDescriptionText,   Types::String.meta(omittable: false)
          attribute :TDSResponseDescriptionText,   Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end
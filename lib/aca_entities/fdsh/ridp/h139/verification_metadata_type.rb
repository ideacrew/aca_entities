# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for VerificationMetadataType
        class VerificationMetadataType < Dry::Struct

          attribute :verification_id,    Types::String.meta(omittable: false)
        end
      end
    end
  end
end
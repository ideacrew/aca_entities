# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Response
          # Entity for IndividualRequest
          class SSAVerificationSupplement < Dry::Struct
            attribute :DeathConfirmationCode, Types::String.optional.meta(omittable: true)
          end
        end
      end
    end
  end
end
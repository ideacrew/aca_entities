# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationRequest
        class Date < Dry::Struct
          attribute :Date, Types::Date.meta(omittable: false)
        end
      end
    end
  end
end
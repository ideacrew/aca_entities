# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for VerificationStatus
      class VerificationStatus < Dry::Struct
        attribute :status_code, Types::String.meta(omittable: false)
      end
    end
  end
end
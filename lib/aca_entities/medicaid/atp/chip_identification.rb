# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # CHIP Identification
      class ChipIdentification < Dry::Struct
        attribute :identification_id, Types::String.meta(omittable: false)
      end
    end
  end
end
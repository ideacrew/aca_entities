# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Medicaid Identification
      class MedicaidIdentification < Dry::Struct
        attribute :identification_id, Types::String.meta(omittable: false)
      end
    end
  end
end
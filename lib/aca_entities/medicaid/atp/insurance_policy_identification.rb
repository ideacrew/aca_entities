# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp Insurance Policy identification
      class InsurancePolicyIdentification < Dry::Struct
        attribute :identification_id, Types::String.meta(omittable: false)
      end
    end
  end
end
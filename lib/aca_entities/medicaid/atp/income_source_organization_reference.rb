# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp IncomeSourceOrganizationReference
      class IncomeSourceOrganizationReference < Dry::Struct
        
        attribute :ref, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
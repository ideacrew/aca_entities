# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp ContactMailingAddress
      class ContactMailingAddress < Dry::Struct
        
        attribute :address, StructuredAddress.optional.meta(omittable: true)
      end
    end
  end
end
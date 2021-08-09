# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp ContactTelephoneNumber
      class ContactTelephoneNumber < Dry::Struct

        attribute :telephone, FullTelephone.optional.meta(omittable: true)
      end
    end
  end
end
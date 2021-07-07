# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp ContactInformation
      class ContactInformation < Dry::Struct

        attribute :contact_email_id, Types::String.optional.meta(omittable: true)
        attribute :mailing_address, StructuredAddress.optional.meta(omittable: true)
        attribute :telephone_number, FullTelephone.optional.meta(omittable: true)
      end
    end
  end
end
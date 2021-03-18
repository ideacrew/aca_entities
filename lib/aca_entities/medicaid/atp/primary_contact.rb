# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PrimaryContact
      class PrimaryContact < Dry::Struct

        attribute :person_name, PersonName.meta(omittable: false)
        attribute :identifying_information, IdentifyingInformation.optional.meta(omittable: true)
        attribute :addresses, Types::Array.of(Address)
        attribute :phones, Types::Array.of(Phone)
        attribute :preference, Types::Array.of(Preference)
      end
    end
  end
end

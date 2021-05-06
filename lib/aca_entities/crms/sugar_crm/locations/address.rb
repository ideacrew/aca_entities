# frozen_string_literal: true

module AcaEntities
  module Crms
    module SugarCrm
      module Locations
        # entity for sugar_crm Address
        class Address < Dry::Struct

          attribute :street,      Types::Strict::String.meta(omittable: true)
          attribute :street_2,    Types::Strict::String.meta(omittable: true)
          attribute :street_3,    Types::Strict::String.meta(omittable: true)
          attribute :street_4,    Types::Strict::String.meta(omittable: true)
          attribute :city,        Types::Strict::String.meta(omittable: true)
          attribute :state,       Types::Strict::String.meta(omittable: true)
          attribute :postalcode,  Types::Strict::String.meta(omittable: true)
          attribute :country,     Types::Strict::String.meta(omittable: true)
        end
      end
    end
  end
end
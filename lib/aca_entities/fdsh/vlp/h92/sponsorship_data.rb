# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp SponsorshipData
        class SponsorshipData < Dry::Struct

          attribute :LastName,          Types::Strict::String.meta(omittable: false)
          attribute :FirstName,         Types::Strict::String.meta(omittable: false)
          attribute :MiddleName,        Types::String.optional.meta(omittable: true)
          attribute :Addr1,             Types::String.optional.meta(omittable: true)
          attribute :Addr2,             Types::String.optional.meta(omittable: true)
          attribute :City,              Types::String.optional.meta(omittable: true)
          attribute :StateProvince,     Types::String.optional.meta(omittable: true)
          attribute :ZipPostalCode,     Types::String.optional.meta(omittable: true)
          attribute :SSN,               Types::String.optional.meta(omittable: true)
          attribute :CountryCode,       Types::String.optional.meta(omittable: true)
          attribute :CountryName,       Types::String.optional.meta(omittable: true)

        end
      end
    end
  end
end
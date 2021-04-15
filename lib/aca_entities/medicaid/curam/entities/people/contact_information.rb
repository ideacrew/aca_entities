# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module People
        class ContactInformation < Dry::Struct

          attribute :addresses, Types::Array.of(Curam::Addresses::Address).meta(omittable: false)
          attribute :phones,    Types::Array.of(Curam::Phones::Phone).meta(omittable: false)
          attribute :emails,    Types::Array.of(Curam::Emails::Email).optional.meta(omittable: true)
        end
      end
    end
  end
end

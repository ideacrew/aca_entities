# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp SponsorshipDataType
          class SponsorshipDataType < Dry::Struct

            attribute :firstName,     Types::Strict::String.meta(omittable: false)
            attribute :lastName,      Types::Strict::String.meta(omittable: false)
            attribute :middleName,    Types::Strict::String.meta(omittable: true)
            attribute :addr1,         Types::Strict::String.meta(omittable: true)
            attribute :addr2,         Types::Strict::String.meta(omittable: true)
            attribute :city,          Types::Strict::String.meta(omittable: true)
            attribute :stateCode,     Types::Strict::String.meta(omittable: true)
            attribute :zipCode,       Types::Strict::String.meta(omittable: true)

          end
        end
      end
    end
  end
end
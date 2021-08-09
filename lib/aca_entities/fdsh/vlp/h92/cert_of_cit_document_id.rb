# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp CertOfCitDocumentId
        class CertOfCitDocumentId < Dry::Struct
          attribute :AlienNumber,         Types::Strict::String.meta(omittable: false)
          attribute :CitizenshipNumber,   Types::Strict::String.meta(omittable: false)
        end
      end
    end
  end
end
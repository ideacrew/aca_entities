# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp CertOfCitDocumentId23Type
          class CertOfCitDocumentId23Type < Dry::Struct
            attribute :alienNumber,         Types::Strict::String.meta(omittable: false)
            attribute :citizenshipNumber,   Types::Strict::String.meta(omittable: false)
          end
        end
      end
    end
  end
end
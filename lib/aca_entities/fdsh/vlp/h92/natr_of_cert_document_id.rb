# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp NatrOfCertDocumentId
        class NatrOfCertDocumentId < Dry::Struct

          attribute :AlienNumber,                Types::String.optional.meta(omittable: true)
          attribute :NaturalizationNumber,       Types::Strict::String.meta(omittable: false)
        end
      end
    end
  end
end
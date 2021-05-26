# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp NatrOfCertDocumentID20Type
          class NatrOfCertDocumentID20Type < Dry::Struct

            attribute :alienNumber,                Types::Strict::String.meta(omittable: true)
            attribute :naturalizationNumber,       Types::Strict::String.meta(omittable: false)
          end
        end
      end
    end
  end
end
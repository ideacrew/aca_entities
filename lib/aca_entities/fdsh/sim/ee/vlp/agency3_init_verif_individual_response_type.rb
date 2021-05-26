# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Agency3InitVerifIndividualResponseType
          class Agency3InitVerifIndividualResponseType < Dry::Struct

            attribute :responseMetadata,                        Fdsh::Sim::Ee::Vlp::ResponseMetadataType.meta(omittable: false)
            attribute :lawfulPresenceVerifiedCode,              Types::Strict::String.meta(omittable: false)
            attribute :agency3InitVerifIndividualResponseSet,   Fdsh::Sim::Ee::Vlp::Agency3InitVerifIndividualResponseSetType.meta(omittable: false)
          end
        end
      end
    end
  end
end
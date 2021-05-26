# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Agency3InitVerifResponseSetType
          class Agency3InitVerifResponseSetType < Dry::Struct

            attribute :agency3InitVerifIndividualResponse,  Types::Array.of(Fdsh::Sim::Ee::Vlp::Agency3InitVerifIndividualResponseType).meta(omittable: false)
          end
        end
      end
    end
  end
end
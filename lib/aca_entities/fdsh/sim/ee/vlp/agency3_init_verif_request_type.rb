# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Agency3InitVerifRequestType
          class Agency3InitVerifRequestType < Dry::Struct

            attribute :agency3InitVerifRequestSet,  Types::Array.of(Fdsh::Sim::Ee::Vlp::Agency3InitVerifRequestSetType).meta(omittable: false)
          end
        end
      end
    end
  end
end
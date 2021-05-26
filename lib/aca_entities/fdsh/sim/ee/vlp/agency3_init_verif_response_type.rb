# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Agency3InitVerifResponseType
          class Agency3InitVerifResponseType < Dry::Struct

            attribute :responseMetadata,  Fdsh::Sim::Ee::Vlp::ResponseMetadataType.meta(omittable: false)
            attribute :agency3InitVerifResponseSet,  Fdsh::Sim::Ee::Vlp::Agency3InitVerifResponseSetType.meta(omittable: false)
          end
        end
      end
    end
  end
end
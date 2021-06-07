# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Agency3InitVerifResponseType
          class Agency3InitVerifResponseTypeContract < Dry::Validation::Contract

            params do
              required(:responseMetadata).filled(Fdsh::Sim::Ee::Vlp::ResponseMetadataTypeContract.params)
              required(:agency3InitVerifResponseSet).filled(Fdsh::Sim::Ee::Vlp::Agency3InitVerifResponseSetTypeContract.params)
            end
          end
        end
      end
    end
  end
end
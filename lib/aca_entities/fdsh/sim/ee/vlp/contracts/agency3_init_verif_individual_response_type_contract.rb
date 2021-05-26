# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Agency3InitVerifIndividualResponseType
          class Agency3InitVerifIndividualResponseTypeContract < Dry::Validation::Contract

            required(:responseMetadata).filled(Fdsh::Sim::Ee::Vlp::ResponseMetadataTypeContract.params)
            required(:lawfulPresenceVerifiedCode).filled(:string)
            required(:agency3InitVerifIndividualResponseSet).filled(Fdsh::Sim::Ee::Vlp::Agency3InitVerifIndividualResponseSetTypeContract.params)
          end
        end
      end
    end
  end
end
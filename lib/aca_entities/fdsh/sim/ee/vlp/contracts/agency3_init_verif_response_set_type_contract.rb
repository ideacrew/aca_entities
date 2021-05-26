# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Agency3InitVerifResponseSetType
          class Agency3InitVerifResponseSetTypeContract < Dry::Validation::Contract

            params do
              required(:agency3InitVerifIndividualResponse).array(Fdsh::Sim::Ee::Vlp::Agency3InitVerifIndividualResponseTypeContract.Params)
            end
          end
        end
      end
    end
  end
end
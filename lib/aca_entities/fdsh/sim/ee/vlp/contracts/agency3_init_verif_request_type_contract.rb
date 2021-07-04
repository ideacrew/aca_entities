# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Agency3InitVerifRequestType
          class Agency3InitVerifRequestTypeContract < Dry::Validation::Contract

            params do
              required(:agency3InitVerifRequestSet).array(Fdsh::Sim::Ee::Vlp::Agency3InitVerifRequestSetTypeContract.params)
            end
          end
        end
      end
    end
  end
end
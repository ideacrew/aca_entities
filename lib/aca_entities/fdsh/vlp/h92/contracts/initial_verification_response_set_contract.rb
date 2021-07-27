# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp InitialVerificationResponseSet
        class InitialVerificationResponseSetContract < Dry::Validation::Contract

          params do
            required(:InitialVerificationIndividualResponses).array(Fdsh::Vlp::H92::InitialVerificationIndividualResponseContract.params)
          end
        end
      end
    end
  end
end
# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp InitialVerificationRequest
        class InitialVerificationRequestContract < Dry::Validation::Contract

          params do
            required(:InitialVerificationRequestSets).array(Fdsh::Vlp::H92::InitialVerificationRequestSetContract.params)
          end
        end
      end
    end
  end
end
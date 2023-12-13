# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx1424
        module Contracts
          # Contract for Fdsh Vlp ResponseMetadata
          class CloseCaseResponseSetContract < Dry::Validation::Contract
            params do
              required(:WebServSftwrVer).filled(:string)
            end
          end
        end
      end
    end
  end
end
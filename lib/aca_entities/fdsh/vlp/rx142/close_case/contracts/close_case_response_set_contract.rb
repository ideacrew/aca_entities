# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
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
end
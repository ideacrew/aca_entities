# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Response
          module Contracts

            # Contract for PVC IndividualResponseContract
            class SSAVerificationSupplementContract < Dry::Validation::Contract
              params do
                required(:DeathConfirmationCode).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
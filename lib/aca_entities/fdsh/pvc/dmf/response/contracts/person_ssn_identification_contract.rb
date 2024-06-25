# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Response
          module Contracts

            # Contract for PVC IndividualResponseContract
            class PersonSSNIdentificationContract < Dry::Validation::Contract
              params do
                required(:SSNIdentification).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
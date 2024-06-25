# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Response
          module Contracts

            # Contract for PVC IndividualResponseContract
            class PersonBirthDateContract < Dry::Validation::Contract
              params do
                required(:Date).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
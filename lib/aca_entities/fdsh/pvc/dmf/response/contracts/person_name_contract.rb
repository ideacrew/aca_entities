# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Response
          module Contracts

            # Contract for PVC IndividualResponseContract
            class PersonNameContract < Dry::Validation::Contract
              params do
                required(:PersonGivenName).filled(:string)
                optional(:PersonMiddleName).maybe(:string)
                required(:PersonSurName).filled(:string)
                optional(:PersonNameSuffixText).maybe(:string)

              end
            end
          end
        end
      end
    end
  end
end
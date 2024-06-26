# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          module Contracts
            # FDSH schema and validation rules for {AcaEntities::Fdsh::Person::PersonName}
            class CloseCaseRequestContract < Dry::Validation::Contract
              # @return [Dry::Monads::Result]
              params do
                required(:CaseNumber).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module AcaEntities
    module Medicaid
      module Ios
        module Contracts
          # Contract for RecordType
          class RecordTypeContract < Dry::Validation::Contract
  
            params do
              optional(:DeveloperName).maybe(:string)
            end
          end
        end
      end
    end
  end
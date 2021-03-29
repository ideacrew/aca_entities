# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for IdentifyingInformation.
      class IdentifyingInformationContract < Dry::Validation::Contract

        params do
          required(:has_ssn).filled(:bool)
          optional(:encrypted_ssn).maybe(:string)
        end
      end
    end
  end
end
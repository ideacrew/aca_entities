# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Email.
      class EmailContract < Dry::Validation::Contract

        params do
          required(:kind).filled(:string)
          required(:address).filled(:string)
        end
      end
    end
  end
end
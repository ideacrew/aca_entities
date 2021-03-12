# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for CurrentIncomeEmployer.
    class CurrentIncomeEmployerContract < Dry::Validation::Contract

      params do
        optional(:street_1).maybe(:string)
        optional(:street_2).maybe(:string)
        optional(:city).maybe(:string)
        optional(:state_code).maybe(Types::UsStateAbbreviationKind)
        optional(:zip_code).maybe(:string)
      end
    end
  end
end

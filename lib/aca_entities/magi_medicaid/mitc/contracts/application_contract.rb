# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::Application}
        class ApplicationContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :name required
          # @option opts [String] :state required
          # @option opts [Integer] :application_year optional
          # @option opts [Array] :people required
          # @option opts [Array] :physical_households required
          # @option opts [Array] :tax_returns required
          # @return [Dry::Monads::Result]
          params do
            required(:name).filled(:string)
            required(:state).filled(Types::UsStateAbbreviationKind)
            optional(:application_year).maybe(:integer)
            required(:people).array(PersonContract.params)
            required(:physical_households).array(HouseholdContract.params)
            required(:tax_returns).array(TaxReturnContract.params)
          end
        end
      end
    end
  end
end

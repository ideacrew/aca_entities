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

          rule(:people) do
            if key? && value
              people_array = value.inject([]) do |hash_array, person_hash|
                if person_hash.is_a?(Hash)
                  result = PersonContract.new.call(person_hash)
                  if result&.failure?
                    key.failure(text: 'invalid person.', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid person. Expected a hash.')
                end
                hash_array
              end
              values.merge!(people: people_array)
            end
          end
        end
      end
    end
  end
end

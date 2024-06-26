# frozen_string_literal: true

module AcaEntities
  module Contracts
    module People
      # Schema and validation rules for {AcaEntities::People::AliveStatus}
      class AliveStatusContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_deceased optional
        # @option opts [Date] :date_of_death optional
        # @return [Dry::Monads::Result]
        params do
          # @!attribute [r] is_deceased
          #   @return [Types::Bool, nil] the deceased status of a person
          #   @note This attribute is optional and can be omitted.
          optional(:is_deceased).maybe(:bool)

          # @!attribute [r] date_of_death
          #   @return [Types::Date, nil] the date of death of a person
          #   @note This attribute is optional and can be omitted.
          optional(:date_of_death).maybe(:date)
        end
      end
    end
  end
end

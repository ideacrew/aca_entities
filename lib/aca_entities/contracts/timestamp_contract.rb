# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Schema and validation rules for {AcaEntities::TimeStamp}
    class TimeStampContract < Dry::Validation::Contract
      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [Date] :submitted_at optional
      # @option opts [Date] :created_at optional
      # @option opts [Date] :modified_at optional
      # @return [Dry::Monads::Result]
      params do
        optional(:submitted_at).value(:date?)
        optional(:created_at).value(:date?)
        optional(:modified_at).value(:date?)
      end
    end
  end
end

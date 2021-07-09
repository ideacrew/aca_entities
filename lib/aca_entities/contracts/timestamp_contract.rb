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
        optional(:submitted_at).maybe(:date_time)
        optional(:created_at).value(:date_time)
        optional(:modified_at).maybe(:date_time)
      end
    end
  end
end

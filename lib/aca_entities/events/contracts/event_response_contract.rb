# frozen_string_literal: true

module AcaEntities
  module Events
    module Contracts
      # Schema and validation rules for {AcaEntities::Events::EventResponse}
      class EventResponseContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :received_at optional
        # @option opts [Date] :body optional
        # @return [Dry::Monads::Result]
        params do
          optional(:received_at).value(:date_time)
          optional(:body).maybe(:string)
        end
      end
    end
  end
end

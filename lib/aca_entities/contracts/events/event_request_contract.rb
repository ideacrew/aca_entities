# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Events
      # Schema and validation rules for {AcaEntities::Events::EventRequest}
      class EventRequestContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :requested_at optional
        # @option opts [Date] :body optional
        # @return [Dry::Monads::Result]
        params do
          optional(:requested_at).value(:date)
          optional(:body).maybe(:string)
        end
      end
    end
  end
end
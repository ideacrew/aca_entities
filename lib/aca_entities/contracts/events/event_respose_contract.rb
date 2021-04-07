# frozen_string_literal: true

require 'dry-struct'

module AcaEntities
  module Contracts
    module Events
      # Schema and validation rules for {AcaEntities::Events::EventResponse}
      class EventResponseContract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :requested_at optional
        # @option opts [Date] :body optional
        # @return [Dry::Monads::Result]
        params do
          optional(:requested_at).maybe(:date)
          optional(:body).maybe(:string)
        end
      end
    end
  end
end
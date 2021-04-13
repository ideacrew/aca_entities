# frozen_string_literal: true

module AcaEntities
  module Contracts
    module QualifyingLifeEvents
      # Schema and validation rules for {AcaEntities::QualifyingLifeEvents::QualifyingLifeEventKindReference}
      class QualifyingLifeEventKindReferenceContract < ::Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :start_on required
        # @option opts [Date] :end_on required
        # @option opts [String] :title required
        # @option opts [String] :reason required
        # @option opts [String] :market_kind required
        # @return [Dry::Monads::Result]
        params do
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          required(:title).filled(:string)
          required(:reason).filled(:string)
          required(:market_kind).filled(:string)
        end
      end
    end
  end
end

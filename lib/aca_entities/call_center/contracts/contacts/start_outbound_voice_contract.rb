# frozen_string_literal: true

module AcaEntities
  module CallCenter
    module Contracts
      module Contacts

        # Schema and validation rules for the {CallCenter::Operations::Contacts::StartOutboundVoice} operation
        class StartOutboundVoiceContract < Dry::Validation::Contract

          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :instance_id (required)
          # @option opts [String] :contact_flow_id (required)
          # @option opts [String] :destination_phone_number (required)
          # @option opts [String] :client_token
          # @option opts [String] :source_phone_number
          # @option opts [String] :queue_id
          # @option opts [Hash] :attributes
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:instance_id).filled(:string)
            required(:contact_flow_id).filled(:string)
            required(:destination_phone_number).filled(CallCenter::Types::PhoneNumber)

            optional(:client_token).maybe(:string)
            optional(:source_phone_number).maybe(CallCenter::Types::PhoneNumber)
            optional(:queue_id).maybe(:string)
            optional(:attributes).maybe(:hash)
          end

        end
      end
    end
  end
end

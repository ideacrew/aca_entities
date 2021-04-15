# frozen_string_literal: true

module AcaEntities
  module CallCenter
    module Contracts
      module Users

        # Schema and validation rules for the {CallCenter::UserSummary} domain model
        class UserPhoneConfigContract < Dry::Validation::Contract

          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :phone_type (required)
          # @option opts [Boolean] :auto_accept
          # @option opts [Integer] :after_contact_work_time_limit
          # @option opts [CallCenter::Types::PhoneNumber] :desk_phone_number
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:phone_type).filled(:string)
            optional(:auto_accept).maybe(:bool)
            optional(:after_contact_work_time_limit).filled(:integer)
            optional(:desk_phone_number).maybe(CallCenter::Types::PhoneNumber)
          end

        end
      end
    end
  end
end

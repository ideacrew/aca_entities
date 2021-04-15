# frozen_string_literal: true

module AcaEntities
  module CallCenter
    module Contracts
      module Users

        # Schema and validation rules for the {CallCenter::UserSummary} domain model
        class UserIdentityInfoContract < Dry::Validation::Contract

          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :first_name required
          # @option opts [String] :last_name required
          # @option opts [CallCenter::Types::Email] :email required
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:first_name).maybe(:string)
            optional(:last_name).maybe(:string)
            optional(:email).maybe(CallCenter::Types::Email)
          end

        end
      end
    end
  end
end
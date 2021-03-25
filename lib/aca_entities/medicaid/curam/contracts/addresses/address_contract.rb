# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Addresses
        # Schema and validation rules for {Curam::Addresses::Address} domain object
        class AddressContract < Curam::ApplicationContract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :type (required)
          # @option opts [String] :line_1 (required)
          # @option opts [String] :line_2 (optional)
          # @option opts [String] :city (required)
          # @option opts [Curam::TypesUsStateKind] :state (required)
          # @option opts [String] :zip (required)
          # @return [Dry::Monads::Result] Success or Failure
          params do
            required(:type).filled(Curam::TypesAddressKind)
            required(:line_1).filled(:string)
            optional(:line_2).maybe(:string)
            required(:city).filled(:string)
            required(:state).filled(Curam::TypesUsStateKind)
            required(:zip).filled(:string)
          end
        end
      end
    end
  end
end

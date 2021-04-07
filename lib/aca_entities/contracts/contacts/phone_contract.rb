# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Contacts
      # Schema and validation rules for {AcaEntities::Contacts::Phone}
      class PhoneContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :kind required
        # @option opts [String] :country_code optional
        # @option opts [String] :area_code required
        # @option opts [String] :number required
        # @option opts [String] :extension optional
        # @option opts [String] :primary optional
        # @option opts [String] :full_phone_number optional
        # @return [Dry::Monads::Result]
        params do
          required(:kind).filled(
              AcaEntities::Types::PhoneKinds
          )
          optional(:country_code).maybe(:string)
          required(:area_code).filled(:string)
          required(:number).filled(:string)
          optional(:extension).maybe(:string)
          optional(:primary).maybe(:bool)
          optional(:full_phone_number).maybe(:string)
        end
      end
    end
  end
end

# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Locations
      # Schema and validation rules for {AcaEntities::Locations::Address}
      class AddressContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :has_fixed_address optional
        # @option opts [Hash] :kind optional
        # @option opts [Boolean] :address_1 required
        # @option opts [Date] :address_2 optional
        # @option opts [Date] :address_3 optional
        # @option opts [Date] :city required
        # @option opts [Date] :county optional
        # @option opts [Date] :county_code optional
        # @option opts [Date] :state required
        # @option opts [Date] :zip required
        # @option opts [Date] :country_name optional
        # @option opts [Date] :validation_status optional
        # @option opts [Date] :start_on optional
        # @option opts [Date] :end_on optional
        # @option opts [Date] :lives_outside_state_temporarily optional
        # @return [Dry::Monads::Result]
        params do
          optional(:has_fixed_address).filled(:bool)
          required(:kind).filled(
            AcaEntities::Types::AddressKinds
          )
          required(:address_1).filled(:string)
          optional(:address_2).maybe(:string)
          optional(:address_3).maybe(:string)
          required(:city).filled(:string)
          optional(:county).maybe(:string)
          optional(:county_code).maybe(:string)
          required(:state).filled(:string)
          required(:zip).filled do
            str? & format?(Types::ZipCodeRegex)
          end
          optional(:country_name).maybe(:string)
          optional(:validation_status).maybe(Types::AddressValidationStatusCode)
          optional(:start_on).maybe(:date)
          optional(:end_on).maybe(:date)
          optional(:lives_outside_state_temporarily).maybe(:bool)
        end
      end
    end
  end
end

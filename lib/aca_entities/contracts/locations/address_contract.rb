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
          optional(:kind).maybe(
            AcaEntities::Types::AddressKinds
          )
          required(:address_1).maybe(:string)
          optional(:address_2).maybe(:string)
          optional(:address_3).maybe(:string)
          required(:city).maybe(:string)
          optional(:county).maybe(:string)
          optional(:county_code).maybe(:string)
          required(:state).maybe(:string)
          required(:zip).maybe(:string)
          optional(:country_name).maybe(:string)
          optional(:validation_status).maybe(Types::AddressValidationStatusCode)
          optional(:start_on).maybe(:date)
          optional(:end_on).maybe(:date)
          optional(:lives_outside_state_temporarily).maybe(:bool)
        end

        rule(:has_fixed_address) do
          if value
            address_kind = values[:kind]
            key.failure(text: 'Kind cannot be blank') if address_kind.to_s.empty?
            key.failure(text: 'Address1 cannot be blank') if values[:address_1].to_s.empty?
            key.failure(text: 'City cannot be blank') if values[:city].to_s.empty?
            key.failure(text: 'State cannot be blank') if values[:state].to_s.empty?
            key.failure(text: 'Zip cannot be blank') if values[:zip].to_s.empty?
            if !values[:zip].to_s.empty? && !/\A\d{5}(-\d{4})?\z/.match?(values[:zip])
              key.failure(text: 'Zip should be in the form: 12345 or 12345-1234')
            end
          end
        end
      end
    end
  end
end

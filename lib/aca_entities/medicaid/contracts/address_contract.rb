# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for Address.
      class AddressContract < Dry::Validation::Contract

        params do
          required(:fixed_address_indicator).filled(:bool)
          optional(:address_type_code).maybe(:string)
          optional(:street_name_1).maybe(:string)
          optional(:street_name_2).maybe(:string)
          optional(:city_name).maybe(:string)
          optional(:county_name).maybe(:string)
          optional(:county_code).maybe(:string)
          optional(:state_code).maybe(:string)
          optional(:zip_code).maybe(:string)
          optional(:lives_outside_state_temporarily).maybe(:bool)

          optional(:address_validation_status).maybe(MagiMedicaid::Types::AddressValidationStatusCode)
        end

        rule(:fixed_address_indicator) do
          if value
            address_kind = values[:address_type_code]
            key.failure(text: 'Address Type Code cannot be blank') if address_kind.to_s.empty?
            key.failure(text: 'Street Name1 cannot be blank') if values[:street_name_1].to_s.empty?
            key.failure(text: 'City cannot be blank') if values[:city_name].to_s.empty?
            key.failure(text: 'State cannot be blank') if values[:state_code].to_s.empty?
            key.failure(text: 'Zip cannot be blank') if values[:zip_code].to_s.empty?
            if !values[:zip].to_s.empty? && !/\A\d{5}(-\d{4})?\z/.match?(values[:zip])
              key.failure(text: 'ZipCode should be in the form: 12345 or 12345-1234')
            end
          end
        end
      end
    end
  end
end

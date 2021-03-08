# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for Address.
    class AddressContract < Dry::Validation::Contract

      params do
        required(:has_fixed_address).filled(:bool)
        optional(:kind).maybe(:string)
        optional(:address_1).maybe(:string)
        optional(:address_2).maybe(:string)
        optional(:address_3).maybe(:string)
        optional(:city).maybe(:string)
        optional(:county).maybe(:string)
        optional(:county_code).maybe(:string)
        optional(:state).maybe(:string)
        optional(:zip).maybe(:string)
        optional(:country_name).maybe(:string)
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

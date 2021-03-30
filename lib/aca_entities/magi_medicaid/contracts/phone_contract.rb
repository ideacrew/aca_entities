# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Phone.
      class PhoneContract < Dry::Validation::Contract

        params do
          required(:kind).maybe(Types::PhoneKind)
          optional(:country_code).maybe(:string)
          required(:area_code).filled(:string)
          required(:number).filled(:string)
          optional(:extension).maybe(:string)
          required(:primary).filled(:bool)
          optional(:full_phone_number).maybe(:string)
        end

        rule(:area_code) do
          key.failure(text: 'should be of length 3 and allows numbers only') if key? && value && !value.match?(/^[0-9]{3}$/)
        end

        rule(:number) do
          key.failure(text: 'should be of length 7 and allows numbers only') if key? && value && !value.match?(/^[0-9]{7}$/)
        end

        rule(:full_phone_number) do
          key.failure(text: 'should be of length 10 and allows numbers only') if key? && value && !value.match?(/^[0-9]{10}$/)
        end
      end
    end
  end
end
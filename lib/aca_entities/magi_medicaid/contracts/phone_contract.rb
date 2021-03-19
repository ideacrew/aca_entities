# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Phone.
      class PhoneContract < Dry::Validation::Contract

        params do
          required(:kind).maybe(:string)
          optional(:country_code).maybe(:string)
          optional(:area_code).maybe(:string)
          optional(:number).maybe(:string)
          optional(:extension).maybe(:string)
          optional(:primary).filled(:bool)
          required(:full_phone_number).maybe(:string)
        end
      end
    end
  end
end
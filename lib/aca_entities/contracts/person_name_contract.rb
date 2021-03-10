# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for PersonName.
    class PersonNameContract < Dry::Validation::Contract

      params do
        required(:first_name).filled(:string)
        optional(:middle_name).maybe(:string)
        required(:last_name).filled(:string)
        optional(:name_sfx).maybe(:string)
        optional(:name_pfx).maybe(:string)
      end
    end
  end
end

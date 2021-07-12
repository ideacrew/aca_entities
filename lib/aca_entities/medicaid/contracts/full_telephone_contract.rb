# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for FullTelephone.
      class FullTelephoneContract < Dry::Validation::Contract

        params do
          optional(:telephone_number_full_id).maybe(:string)
          optional(:telephone_suffix_id).maybe(:string)
        end
      end
    end
  end
end

# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PersonPregnancyStatus.
      class PersonPregnancyStatusContract < Dry::Validation::Contract

        params do

          optional(:status_indicator).maybe(:bool)
          optional(:status_valid_date_range).maybe(:hash)
          optional(:expected_baby_quantity).maybe(:integer)
        end
      end
    end
  end
end

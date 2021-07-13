# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PersonAgeMeasureContract.
      class PersonAgeMeasureContract < Dry::Validation::Contract

        params do
          optional(:measure_point_value).maybe(:integer)
        end
      end
    end
  end
end

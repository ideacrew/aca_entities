# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH InsuranceContract
        class InsuranceContract < Dry::Validation::Contract
          params do
            optional(:InsuranceEffectiveDate).filled(:date)
            optional(:InsuranceEndDate).filled(:date)
          end
        end
      end
    end
  end
end
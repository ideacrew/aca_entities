# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH InsuranceContract
        class InsuranceContract < Dry::Validation::Contract
          params do
            optional(:InsuranceEffectiveDate).maybe(:date)
            optional(:InsuranceEndDate).maybe(:date)
          end
        end
      end
    end
  end
end
# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH InsuranceContract
        class InsuranceDateContract < Dry::Validation::Contract
          params do
            required(:Date).filled(:date)
          end
        end
      end
    end
  end
end
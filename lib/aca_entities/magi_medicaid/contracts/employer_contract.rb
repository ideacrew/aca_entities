# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Employer.
      class EmployerContract < Dry::Validation::Contract
        params do
          required(:employer_name).filled(:string)
          required(:employer_id).filled(:string)
        end

        rule(:employer_id) do
          key.failure(text: 'should be of length 9 and allows numbers only') if key? && value && !value.match?(/^[0-9]{9}$/)
        end
      end
    end
  end
end

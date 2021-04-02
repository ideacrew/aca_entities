# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for VerificationHeader.
      class VerificationHeaderContract < Dry::Validation::Contract

        params do
          required(:verification_date).filled(:date)
          required(:verified_by).filled(:string)
          optional(:medicaid_chip_state).maybe(:string)
          optional(:medicaid_chip_county).maybe(:string)
          optional(:verification_type).maybe(:string)
          optional(:verification_source).maybe(:string)
          required(:verification_status).filled(MagiMedicaid::Types::VerificationStatusCode)
          optional(:verification_code).maybe(:string)
          optional(:response_code).maybe(:string)
        end

        rule(:verification_source) do
          verification_codes = ['DHS-G845VerificationCode', 'DHS-SAVEVerificationCode']
          if key && value && verification_codes.include?(values[:verification_status]) && value != 'DHS'
            key.failure(text: 'invalid input for verification source code')
          end
        end
      end
    end
  end
end

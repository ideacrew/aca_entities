# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'bigdecimal'

module AcaEntities
  module Operations
    module MagiMedicaid
      # Create a {CreateFederalPovertyLevel} instance
      class CreateFederalPovertyLevel
        send(:include, Dry::Monads[:result, :do])
        send(:include, Dry::Monads[:try])

        # @param [Hash] opts The options to create the CreateFederalPovertyLevel instance
        # @option opts [String] :state_code The two character abbreviation for the US state
        # @option opts [Integer] :medicaid_year The Medicaid year
        # @option opts [Integer] :household_size The number of individuals in household
        # @option opts [Integer] :annual_poverty_guideline
        # @option opts [Integer] :annual_per_person_amount
        # @example
        #   { state_code: 'ME', medicaid_year: 2021, household_size: 1, annual_poverty_guideline: 12_880, annual_per_person_amount: 4_540 }
        # @return [Dry::Monads::Result]
        def call(params)
          fpl_params = yield validate(params)
          fpl_hash = yield build_fpl_hash(fpl_params)
          values = yield validate_fpl_hash(fpl_hash)
          federal_poverty_level = yield create(values)

          Success(federal_poverty_level)
        end

        private

        def validate(params)
          result =
            AcaEntities::MagiMedicaid::Contracts::CreateFederalPovertyLevelContract
            .new.call(params)
          result.success? ? Success(result) : Failure(result)
        end

        def build_fpl_hash(fpl_params)
          fpl = fpl_params.to_h
          months_in_year = BigDecimal('12')

          fpl_hash =
            Hash(
              state_code: fpl[:state_code],
              medicaid_year: fpl[:medicaid_year],
              household_size: fpl[:household_size],
              annual_poverty_guideline:
                BigDecimal(fpl[:annual_poverty_guideline].to_s),
              annual_per_person_amount:
                BigDecimal(fpl[:annual_per_person_amount].to_s),
              monthly_poverty_guideline:
                BigDecimal(fpl[:annual_poverty_guideline].to_s).div(
                  months_in_year,
                  2
                ),
              monthly_per_person_amount:
                BigDecimal(fpl[:annual_per_person_amount].to_s).div(
                  months_in_year,
                  2
                ),
              aptc_effective_start_on: Date.new(fpl[:medicaid_year], 11, 1),
              aptc_effective_end_on: Date.new(fpl[:medicaid_year] + 1, 10, 31)
            )
          Success(fpl_hash)
        end

        def validate_fpl_hash(fpl_hash)
          result =
            AcaEntities::MagiMedicaid::Contracts::FederalPovertyLevelContract
            .new.call(fpl_hash)
          result.success? ? Success(result) : Failure(result)
        end

        def create(values)
          Try() do
            AcaEntities::MagiMedicaid::FederalPovertyLevel.new(values.to_h)
          end.to_result
        end
      end
    end
  end
end

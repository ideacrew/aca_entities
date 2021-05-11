# frozen_string_literal: true

module AcaEntities
  module Operations
    module Families
      # Open and read contents of a file
      class BuildFamily
        send(:include, Dry::Monads[:result, :do])
        send(:include, Dry::Monads[:try])

        # @param [Hash] record The record is a transformed hash
        # @example
        #   { state_code: 'ME', medicaid_year: 2021, household_size: 1, annual_poverty_guideline: 12_880, annual_per_person_amount: 4_540 }
        # @return [Dry::Monads::Result]
        def call(*args)
          fpl_params = yield transform(args.first[:input]) unless args.first[:record]
          valid_params = yield validate(args.first[:record] || fpl_params[:family])
          family_hash = yield build_family_hash(valid_params)

          Success(family_hash)
        end

        private

        def transform(input)
          result = []
          AcaEntities::Operations::TransformExamples::McrTo::CvInput.call(input) do |payload|
            result << payload
          end

          Success(result.first)
        end

        def validate(record)
          result = AcaEntities::Contracts::Families::FamilyContract.new.call(record)

          result.success? ? Success(result) : Failure(result)
        end

        def build_family_hash(valid_params)
          family_hash = AcaEntities::Families::Family.new(valid_params.to_h)

          Success(family_hash)
        rescue StandardError => _e
          Failure(family_hash.errors.messages)
        end

        # def create(values)
        #   Try() do
        #     AcaEntities::MagiMedicaid::FederalPovertyLevel.new(values.to_h)
        #   end.to_result
        # end
      end
    end
  end
end

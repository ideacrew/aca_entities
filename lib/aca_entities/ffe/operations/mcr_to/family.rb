# frozen_string_literal: true

module AcaEntities
  module Ffe
    module Operations
      module McrTo
        # Open and read contents of a file
        class Family
          send(:include, Dry::Monads[:result, :do])
          send(:include, Dry::Monads[:try])

          # @param [Hash] record The record is a transformed hash
          # @example
          #   { state_code: 'ME', medicaid_year: 2021, household_size: 1, annual_poverty_guideline: 12_880, annual_per_person_amount: 4_540 }
          # @return [Dry::Monads::Result]
          def call(*args)
            valid_params = yield validate(args.first[:record])
            _family_hash = yield build_family_hash(valid_params)
            Success(args.first[:record])
          end

          private

          def validate(record)
            result = AcaEntities::Contracts::Families::FamilyContract.new.call(record)
            unless result.success?
              puts result.errors.messages
              # binding.pry

            end
            result.success? ? Success(result) : Failure(result)
          end

          def build_family_hash(valid_params)
            # binding.pry
            result = Try do
              AcaEntities::Families::Family.new(valid_params.to_h)
            end.to_result
            unless result.success?
              # binding.pry
            end
            result
          end
        end
      end
    end
  end
end

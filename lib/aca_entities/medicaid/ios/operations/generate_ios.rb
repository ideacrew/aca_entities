# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

require 'aca_entities/medicaid/mec_check'

module AcaEntities
  module Medicaid
    module Ios
      # Operation to create valid IOS payload from a CV3 application
      module Operations
        # Operation to create valid IOS payload from a CV3 application
        class GenerateIos
          include Dry::Monads[:result, :do, :try]

          def call(cv3_payload)
            clean_payload = yield prep_data(cv3_payload)
            # after clean the data how to validate it is as expected? do we need a 2nd level of contracts?
            ios_payload = yield to_ios(clean_payload)
            validated_payload = yield validate_ios_payload(ios_payload)
            Success(validated_payload)
          end

          private

          def prep_data(cv3_payload)
            # payload = JSON.parse(cv3_payload, symbolize_names: true)
            # call the to do operation to make the data easier to transform
          end

          def to_ios(payload)
            result = ::AcaEntities::Medicaid::Ios::Transformers::Cv3ToIos.transform(payload)
            Success(result)
          rescue StandardError => e
            Failure("to_ios transformer #{e}")
          end
        end

        def validate_ios_payload(_payload)
          result = Try do
            AcaEntities::Medicaid::Ios::Contracts::SSPDCRequestContract.new.call(payloads)
          end.to_result

          if result.success?
            result
          else
            Failure("SSPDCRequestContract -> #{result.failure.errors.to_h}")
          end
        end

      end
    end
  end
end
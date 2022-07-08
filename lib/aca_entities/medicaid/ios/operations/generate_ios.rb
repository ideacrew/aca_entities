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
            # FinancialAssistance::Operations::Transfers::MedicaidGateway::AccountTransferOut in Enroll
            # sends a single hash for magi_medicaid_applications (no need to convert array into hash)
            payload = JSON.parse(cv3_payload, symbolize_names: true)
            # call the to do operation to make the data easier to transform
            family_members_hash = payload[:family][:family_members].each_with_object({}) do |family_member, member_hash|
              member_hash[family_member[:hbx_id]] = family_member
            end
            payload[:family][:family_members_hash] = family_members_hash

            primary_applicant = payload[:family][:magi_medicaid_applications][:applicants].detect {|applicant| applicant[:is_primary_applicant]}
            payload[:family][:magi_medicaid_applications][:primary_applicant] = primary_applicant
            Success(payload) # TODO: add Failure ?
          end

          def to_ios(payload)
            result = ::AcaEntities::Medicaid::Ios::Transformers::Cv3ToIos.transform(payload)
            Success(result)
          rescue StandardError => e
            Failure("to_ios transformer #{e}")
          end
        end

        def validate_ios_payload(payload)
          result = Try do
            AcaEntities::Medicaid::Ios::Contracts::SspdcRequestContract.new.call(payload)
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
# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module MagiMedicaid
    module Operations
      module Mitc
        # DO NOT USE this operation, this class has some mocked attributes.
        # This class takes MagiMedicaidApplication params as input and returns the MitcRequestPayload.
        class GenerateRequestPayload
          include Dry::Monads[:result, :do]
          include AcaEntities::AppHelper

          # @param [Hash] opts The options to generate Mitc MagiMedicaid Determination Request Payload
          # @option opts [Hash] :params AcaEntities::MagiMedicaid::Contracts::ApplicationContract
          # @return [Dry::Monads::Result]
          def call(params)
            # 1. Validate the params against MagiMedicaidApplicationContract
            # 2. Transform MagiMedicaid Validated params To MitC Contract params
            # 3. Validate the MitC params against MitcApplication Contract
            # 4. Transform Keys of MitcApplication to match RequestDeterminationPayload
            magi_medicaid_app_params   = yield validate_magi_medicaid_application(params)
            mitc_app_params            = yield transform_magi_medicaid_to_mitc(magi_medicaid_app_params)
            validated_mitc_app         = yield validate_mitc_application(mitc_app_params)
            request_determination_json = yield transform_mitc_keys(validated_mitc_app)

            Success(request_determination_json)
          end

          private

          # Validates the params against Iap's ApplicationContract
          def validate_magi_medicaid_application(params)
            result = ::AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(params)

            if result.success?
              Success(result.to_h)
            else
              Failure(result)
            end
          end

          # Transform Iap Validated params To MitC Contract params
          def transform_magi_medicaid_to_mitc(params)
            ::AcaEntities::MagiMedicaid::Transformers::IapTo::Mitc.call(params.to_json) { |record| @transform_result = record }
            # Success(@transform_result)

            # This is dummy method, needs to be removed.
            new_params = add_addtional_params(@transform_result)
            Success(new_params)
          end

          # TODO: Dummy Method. Needs to be removed once below attributes are mapped.
          # Currently, mocking these to get through the MitC's ApplicationContract.
          def add_addtional_params(transform_result)
            transform_result[:people].each do |mitc_person|
              mitc_person.merge!({ has_forty_title_ii_work_quarters: 'N',
                                   is_amerasian: 'N' })
            end
            transform_result
          end

          # Validate the MitC params against MitcApplication Contract
          def validate_mitc_application(params)
            result = ::AcaEntities::MagiMedicaid::Mitc::Contracts::ApplicationContract.new.call(params)

            if result.success?
              Success(result.to_h)
            else
              Failure(result)
            end
          end

          # Transform Keys of MitcApplication to match RequestDeterminationPayload
          def transform_mitc_keys(params)
            ::AcaEntities::MagiMedicaid::Mitc::Transformers::MitcTo::Request.call(params.to_json) { |record| @key_transform_result = record }
            Success(@key_transform_result.to_json)
          end
        end
      end
    end
  end
end

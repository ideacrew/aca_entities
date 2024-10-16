# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module MagiMedicaid
    module Operations
      module Mitc
        # DO NOT USE this operation, the AcaEntities::MagiMedicaid::Transformers::IapTo::Mitc has some mocked attributes
        # This class takes AcaEntities::MagiMedicaid::Application as input and returns the MitcRequestPayload hash.
        class GenerateRequestPayload
          include Dry::Monads[:result, :do]
          include AcaEntities::AppHelper

          # @param [Hash] opts The options to generate Mitc MagiMedicaid Determination Request Payload
          # @option opts [AcaEntities::MagiMedicaid::Application] :mm_application
          # @return [Dry::Monads::Result]
          def call(magi_medicaid_application)
            # 1. Validate input object
            # 2. Transform MagiMedicaid::Application To MitC Contract params
            # 3. Validate the MitC params against MitcApplication Contract
            # 4. Transform Keys of MitcApplication to match RequestDeterminationPayload keys
            mm_application             = yield validate_mm_application(magi_medicaid_application)
            mitc_app_params            = yield transform_magi_medicaid_to_mitc(mm_application)
            validated_mitc_app         = yield validate_mitc_application(mitc_app_params)
            request_determination_json = yield transform_mitc_keys(validated_mitc_app)

            Success(request_determination_json)
          end

          private

          # Validate input object
          def validate_mm_application(magi_medicaid_application)
            if magi_medicaid_application.is_a?(::AcaEntities::MagiMedicaid::Application)
              Success(magi_medicaid_application)
            else
              Failure("Invalid Application, given value is not a ::AcaEntities::MagiMedicaid::Application, input_value:#{magi_medicaid_application}")
            end
          end

          # Transform Iap Validated params To MitC Contract params
          def transform_magi_medicaid_to_mitc(mm_application)
            mm_application_hash = mm_application.to_h

            # Store in-state home address so transform can access it when determing residency
            mm_application_hash[:applicants].each do |applicant|
              us_state = mm_application_hash[:us_state]&.downcase
              home_address = applicant[:addresses].detect {|address| address[:kind] == 'home' && address[:state]&.downcase == us_state} || {}
              applicant[:has_in_state_home_address] = home_address.present?
            end

            ::AcaEntities::MagiMedicaid::Transformers::IapTo::Mitc.call(mm_application_hash.to_json) { |record| @transform_result = record }
            Success(@transform_result)
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

          # Transform Keys of MitcApplication to match RequestDeterminationPayload keys
          def transform_mitc_keys(params)
            ::AcaEntities::MagiMedicaid::Mitc::Transformers::MitcTo::Request.call(params.to_json) { |record| @key_transform_result = record }

            Success(@key_transform_result)
          end
        end
      end
    end
  end
end

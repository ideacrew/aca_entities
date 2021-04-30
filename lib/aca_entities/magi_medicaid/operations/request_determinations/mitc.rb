# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module MagiMedicaid
    module Operations
      module RequestDeterminations
        # DO NOT USE this operation, this class has some mocked attributes.
        class Mitc
          include Dry::Monads[:result, :do]
          include AcaEntities::AppHelper

          def call(params)
            # 1. Validate the params against IapApplication
            # 2. Transform IapToMitc
            # 3. Validate the params against MitcApplication
            # 4. Transform Keys to match RequestDetermination
            iap_app_params = yield validate_iap_application(params)
            mitc_app_params = yield transform_iap_to_mitc(iap_app_params)
            validated_mitc_app = yield validate_mitc_application(mitc_app_params)
            request_determination_json = yield transform_mitc_keys(validated_mitc_app)

            Success(request_determination_json)
          end

          private

          # Validates the params against Iap's ApplicationContract
          def validate_iap_application(params)
            result = ::AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(params)

            if result.success?
              Success(result.to_h)
            else
              Failure(result)
            end
          end

          # 2. Transform IapToMitc
          def transform_iap_to_mitc(params)
            ::AcaEntities::MagiMedicaid::Transformers::IapTo::Mitc.call(params.to_json) { |record| @transform_result = record }
            # Success(@transform_result)

            # This is dummy method, needs to be removed.
            new_params = add_addtional_params(@transform_result)
            Success(new_params)
          end

          # TODO: Dummy Method. Needs to be removed once below attributes are mapped.
          # Currently, mocking these to get through the MitC's ApplicationContract.
          def add_addtional_params(transform_result)
            transform_result.merge!({ name: 'IAP Application' })

            transform_result[:people].each do |mitc_person|
              mitc_person.merge!({ is_claimed_as_dependent_by_non_applicant: 'N',
                                   has_forty_title_ii_work_quarters: 'N',
                                   is_amerasian: 'N' })
            end
            transform_result
          end

          # 3. Validate the params against MitcApplication
          def validate_mitc_application(params)
            result = ::AcaEntities::MagiMedicaid::Mitc::Contracts::ApplicationContract.new.call(params)

            if result.success?
              Success(result.to_h)
            else
              Failure(result)
            end
          end

          # 4. Transform Keys to match RequestDetermination
          def transform_mitc_keys(params)
            ::AcaEntities::MagiMedicaid::Mitc::Transformers::MitcTo::Request.call(params.to_json) { |record| @key_transform_result = record }
            Success(@key_transform_result.to_json)
          end
        end
      end
    end
  end
end


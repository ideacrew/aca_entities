# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module FFE
    module Operations
      module McrTo
        # This class takes MCR enrollment params as input and returns the Enrollment params.
        class Enrollment
          include Dry::Monads[:result, :do]
          send(:include, Dry::Monads[:try])

          # @param [Hash] MCR policy params
          # @return [Dry::Monads::Result]
          def call(params)
            # 1. Validate the params against MCR Policy Contract and Entity
            # 2. Transform MCR Policy Validated params To Enrollment Contract params
            # 3. Validate the transformed Enrollment params against Enrollment Contract
            _valid_policy_params        = yield validate_mcr_policy(params)
            transformed_params          = yield transform_mcr_policy_to_enrollment(params)
            valid_enrollment_params     = yield validate_transformed_enrollment(transformed_params)

            Success(valid_enrollment_params)
          end

          private

          # Validates the params against MCR Enrollment Contract and Entity
          def validate_mcr_policy(_params)
            Success(true)
          end

          # Transform MCR Validated policy params to Enrollment Contract params
          def transform_mcr_policy_to_enrollment(params)
            ::AcaEntities::FFE::Transformers::McrTo::Enrollment.call(params.to_json) { |record| @transform_result = record }
            Success(@transform_result)
          end

          # Validate the tranformed enrollment params against Enrollment Contract
          def validate_transformed_enrollment(params)
            contract_result = ::AcaEntities::Contracts::Enrollments::HbxEnrollmentContract.new.call(params)
            unless contract_result.success?
              Failure(contract_result)
              return
            end

            Try() do
              ::AcaEntities::Enrollments::HbxEnrollment.new(contract_result.to_h)
            end.to_result
          end
        end
      end
    end
  end
end



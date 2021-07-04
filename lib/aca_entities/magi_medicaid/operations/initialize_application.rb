# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module MagiMedicaid
    module Operations
      # This class takes MagiMedicaidApplication params as input and returns the MagiMedicaidApplication entity
      class InitializeApplication
        include Dry::Monads[:result, :do]

        # @param [Hash] opts The options to initialize MagiMedicaidApplicationEntity
        # @option opts [Hash] :params AcaEntities::MagiMedicaid::Contracts::ApplicationContract
        # @return [Dry::Monads::Result]
        def call(params)
          application_params = yield validate_application_params(params)
          application        = yield initialize_application(application_params)

          Success(application)
        end

        private

        def validate_application_params(params)
          result = ::AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(params)

          if result.success?
            Success(result.to_h)
          else
            Failure(result)
          end
        end

        def initialize_application(application_params)
          Success(::AcaEntities::MagiMedicaid::Application.new(application_params))
        end
      end
    end
  end
end

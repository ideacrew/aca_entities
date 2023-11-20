# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module Rj9t
        module Operations
          # convert application to income mec json request
          class IfsvVerificationJsonResponse
            include Dry::Monads[:result, :do, :try]

            def call(params)
              validated_params = yield validate_params(params)
              validated_params[:response_payload] = yield validate_response_payload(validated_params[:response_payload])

              Success(validated_params)
            end

            private

            def validate_params(params)
              return Failure("No application payload found") if params[:application_hash].blank?
              return Failure("No response payload found") if params[:response_payload].blank?
              Success(params)
            end

            def validate_response_payload(payload)
              schema_path = Pathname.pwd.join("lib/aca_entities/fdsh/ifsv/rj9t/schemas/IFSV-Response-schema.json")
              schema_data = JSON.parse(File.read(schema_path))

              result = begin
                JSON::Validator.fully_validate(schema_data, JSON.parse(payload.to_json))
              rescue JSON::Schema::ValidationError => e
                e.message
              end
              payload = JSON.parse(payload.to_json, symbolize_names: true)
              result.empty? ? Success(payload) : Failure(result.to_s)
            end
          end
        end
      end
    end
  end
end
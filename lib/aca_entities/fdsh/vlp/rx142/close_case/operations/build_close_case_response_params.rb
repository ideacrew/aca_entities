# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          module Operations
            # FDSH constructs params based on serialized vlpcc response
            class BuildCloseCaseResponseParams
              include Dry::Monads[:result, :do, :try]

              def call(payload)
                construct_params(payload)
              end

              def construct_params(parsed_xml)
                {
                  ResponseMetadata: construct_response_metadata(parsed_xml&.ResponseMetadata),
                  ArrayOfErrorResponseMetadata: construct_array_error_response_metadata(parsed_xml&.ArrayOfErrorResponseMetadata),
                  CloseCaseResponseSet: get_close_case_response_set(parsed_xml&.CloseCaseResponseSet)
                }.compact
              end

              def get_close_case_response_set(close_case_response)
                return nil unless close_case_response

                { WebServSftwrVer: close_case_response&.WebServSftwrVer }
              end

              def construct_array_error_response_metadata(error_data_array)
                return nil unless error_data_array

                error_data_array.ErrorResponseMetadata.collect do |error_data|
                  {
                    ErrorResponseCode: error_data&.ErrorResponseCode,
                    ErrorResponseDescriptionText: error_data&.ErrorResponseDescriptionText,
                    ErrorTDSResponseDescriptionText: error_data&.ErrorTDSResponseDescriptionText
                  }.compact
                end
              end

              def construct_response_metadata(metadata)
                {
                  ResponseCode: metadata&.ResponseCode,
                  ResponseDescriptionText: metadata&.ResponseDescriptionText,
                  TDSResponseDescriptionText: metadata&.TDSResponseDescriptionText
                }.compact
              end
            end
          end
        end
      end
    end
  end
end
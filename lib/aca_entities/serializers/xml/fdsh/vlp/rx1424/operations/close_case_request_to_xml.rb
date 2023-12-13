# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module Rx1424
            module Operations
              # Turns a primary request to XML and schema validate it.
              class CloseCaseRequestToXml
                send(:include, Dry::Monads[:result, :do, :try])

                # Transforms a primary request object to a request XML.
                # @param [::AcaEntities::Fdsh::Ridp::H139::PrimaryRequest] the primary request
                def call(close_case_request)
                  request_xml = yield convert_to_xml(close_case_request)
                  _validation_result = yield validate_xml(request_xml)
                  Success(request_xml)
                end

                def convert_to_xml(close_case_request)
                  encode_result = Try do
                    ::AcaEntities::Serializers::Xml::Fdsh::Vlp::Rx1424::CloseCaseRequest.domain_to_mapper(close_case_request).to_xml
                  end

                  encode_result.or do |e|
                    Failure(e)
                  end
                end

                def validate_xml(xml)
                  ValidateVlpRx1424PayloadXml.new.call(xml)
                end
              end
            end
          end
        end
      end
    end
  end
end
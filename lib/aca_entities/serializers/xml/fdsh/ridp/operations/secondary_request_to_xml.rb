# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          module Operations
            # Turns a secondary request to XML and schema validate it.
            class SecondaryRequestToXml
              send(:include, Dry::Monads[:result, :do, :try])

              # Transforms a secondary request object to a request XML.
              # @param [::AcaEntities::Fdsh::Ridp::H139::SecondaryRequest] the primary request
              def call(secondary_request)
                request_xml = yield convert_to_xml(secondary_request)
                _validation_result = yield validate_xml(request_xml)
                Success(request_xml)
              end

              def convert_to_xml(secondary_request)
                encode_result = Try do
                  ::AcaEntities::Serializers::Xml::Fdsh::Ridp::Request.domain_to_mapper(secondary_request, 'secondary_request').to_xml
                end

                encode_result.or do |e|
                  Failure(e)
                end
              end

              def validate_xml(xml)
                ValidateRidpPayloadXml.new.call(xml)
              end
            end
          end
        end
      end
    end
  end
end
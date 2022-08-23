# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module H43
            module Operations
              # RRV Request to payload xml
              class PvcRequestToXml
                send(:include, Dry::Monads[:result, :do, :try])

                # Transforms a pvc request object to a request XML.
                def call(medicare_request)
                  request_xml = yield convert_to_xml(medicare_request)
                  _validation_result = yield validate_xml(request_xml)
                  Success(request_xml)
                end

                def convert_to_xml(medicare_request)
                  encode_result = Try do
                    ::AcaEntities::Serializers::Xml::Fdsh::Pvc::H43::BatchHandlingServiceRequest.domain_to_mapper(medicare_request).to_xml
                  end

                  encode_result.or do |e|
                    Failure(e)
                  end
                end

                def validate_xml(xml)
                  ValidatePvcManifestRequestPayloadXml.new.call(xml)
                end
              end
            end
          end
        end
      end
    end
  end
end
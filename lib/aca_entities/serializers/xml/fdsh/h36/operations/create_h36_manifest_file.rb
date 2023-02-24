# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          module Operations
            # RRV Request to payload xml
            class CreateH36ManifestXml
              send(:include, Dry::Monads[:result, :do, :try])

              # Transforms a rrv request object to a request XML.
              def call(request)
                request_xml = yield convert_to_xml(request)
                # _validation_result = yield validate_xml(request_xml)
                Success(request_xml)
              end

              def convert_to_xml(request)
                encode_result = Try do
                  ::AcaEntities::Serializers::Xml::Fdsh::H36::BatchHandlingServiceRequest.domain_to_mapper(request).to_xml
                end

                encode_result.or do |e|
                  Failure(e)
                end
              end

              # def validate_xml(xml)
              #   ValidateRrvManifestRequestPayloadXml.new.call(xml)
              # end
            end
          end
        end
      end
    end
  end
end
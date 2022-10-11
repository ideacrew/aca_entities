# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Medicare
            module Operations
              # PVC Request to payload xml
              class MedicareRequestToXml
                send(:include, Dry::Monads[:result, :do, :try])

                # Transforms a primary request object to a request XML.
                # @param [::AcaEntities::Fdsh::Ssa::H3::SsaCompositeRequest] the primary request
                def call(medicare_request)
                  request_xml = yield convert_to_xml(medicare_request)
                  _validation_result = yield validate_xml(request_xml)
                  Success(request_xml)
                end

                def convert_to_xml(non_esi_request)
                  encode_result = Try do
                    ::AcaEntities::Serializers::Xml::Fdsh::Pvc::Medicare::EesDshBatchRequestData.domain_to_mapper(non_esi_request).to_xml
                  end

                  encode_result.or do |e|
                    Failure(e)
                  end
                end

                def validate_xml(xml)
                  ValidateMedicareRequestPayloadXml.new.call(xml)
                end
              end
            end
          end
        end
      end
    end
  end
end
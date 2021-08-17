# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            module Operations
              # Turns a primary request to XML and schema validate it.
              class EsiRequestToXml
                send(:include, Dry::Monads[:result, :do, :try])

                # Transforms a primary request object to a request XML.
                # @param [::AcaEntities::Fdsh::Ssa::H3::SsaCompositeRequest] the primary request
                def call(esi_request)
                  request_xml = yield convert_to_xml(esi_request)
                  _validation_result = yield validate_xml(request_xml)
                  Success(request_xml)
                end

                def convert_to_xml(esi_request)
                  encode_result = Try do
                    ::AcaEntities::Serializers::Xml::Fdsh::Esi::H14::EsiMecRequest.domain_to_mapper(esi_request).to_xml
                  end

                  encode_result.or do |e|
                    Failure(e)
                  end
                end

                def validate_xml(xml)
                  ValidateEsiPayloadXml.new.call(xml)
                end
              end
            end
          end
        end
      end
    end
  end
end
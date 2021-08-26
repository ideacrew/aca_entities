# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            module Operations
              # Turns a primary request to XML and schema validate it.
              class SsaRequestToXml
                send(:include, Dry::Monads[:result, :do, :try])

                # Transforms a primary request object to a request XML.
                # @param [::AcaEntities::Fdsh::Ssa::H3::SsaCompositeRequest] the primary request
                def call(initial_request)
                  request_xml = yield convert_to_xml(initial_request)
                  _validation_result = yield validate_xml(request_xml)
                  Success(request_xml)
                end

                def convert_to_xml(initial_request)
                  encode_result = Try do
                    ::AcaEntities::Serializers::Xml::Fdsh::Ssa::H3::SSACompositeRequest.domain_to_mapper(initial_request).to_xml
                  end

                  encode_result.or do |e|
                    Failure(e)
                  end
                end

                def validate_xml(xml)
                  ValidateSsaH3PayloadXml.new.call(xml)
                end
              end
            end
          end
        end
      end
    end
  end
end
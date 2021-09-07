# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            module Operations
              # Turns a primary request to XML and schema validate it.
              class IfsvRequestToXml
                send(:include, Dry::Monads[:result, :do, :try])

                # Transforms a primary request object to a request XML.
                # @param [::AcaEntities::Fdsh::Ifsv::H9t::Api::Request] the primary request
                def call(ifsv_request)
                  request_xml = yield convert_to_xml(ifsv_request)
                  _validation_result = yield validate_xml(request_xml)
                  Success(request_xml)
                end

                def convert_to_xml(esi_request)
                  encode_result = Try do
                    ::AcaEntities::Serializers::Xml::Fdsh::Ifsv::H9t::Request.domain_to_mapper(esi_request).to_xml
                  end

                  encode_result.or do |e|
                    Failure(e)
                  end
                end

                def validate_xml(xml)
                  ValidateIfsvPayloadXml.new.call(xml)
                end
              end
            end
          end
        end
      end
    end
  end
end
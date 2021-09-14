# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Medicare
            module Operations
              # RRV Request to payload xml
              class IfsvRequestToXml
                send(:include, Dry::Monads[:result, :do, :try])

                # Transforms a primary request object to a request XML.
                # @param [::AcaEntities::Fdsh::Ssa::H3::SsaCompositeRequest] the primary request
                def call(ifsv_request)
                  request_xml = yield convert_to_xml(ifsv_request)
                  _validation_result = yield validate_xml(request_xml)
                  Success(request_xml)
                end

                def convert_to_xml(request)
                  encode_result = Try do
                    AcaEntities::Serializers::Xml::Fdsh::Rrv::Ifsv::VerifyHouseholdIncomeAndFamilySizeBulkRequest.domain_to_mapper(request).to_xml
                  end

                  encode_result.or do |e|
                    Failure(e)
                  end
                end

                def validate_xml(xml)
                  ValidateIfsvRequestPayloadXml.new.call(xml)
                end
              end
            end
          end
        end
      end
    end
  end
end
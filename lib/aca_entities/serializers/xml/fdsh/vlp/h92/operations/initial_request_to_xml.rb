# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            module Operations
              # Turns a primary request to XML and schema validate it.
              class InitialRequestToXml
                send(:include, Dry::Monads[:result, :do, :try])

                # Transforms a primary request object to a request XML.
                # @param [::AcaEntities::Fdsh::Ridp::H139::PrimaryRequest] the primary request
                def call(initial_request)
                  request_xml = yield convert_to_xml(initial_request)
                  _validation_result = yield validate_xml(request_xml)
                  Success(request_xml)
                end

                def convert_to_xml(initial_request)
                  encode_result = Try do
                    ::AcaEntities::Serializers::Xml::Fdsh::Vlp::H92::InitialVerificationRequest.domain_to_mapper(initial_request).to_xml
                  end

                  encode_result.or do |e|
                    Failure(e)
                  end
                end

                def validate_xml(xml)
                  ValidateVlpH92PayloadXml.new.call(xml)
                end
              end
            end
          end
        end
      end
    end
  end
end
# lib/aca_entities/fdsh/pvc/dmf/request/individual_request.rb

require 'dry/monads'
require 'dry/monads/do'
require 'nokogiri'

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Operations
          class GenerateAndValidateXml
            include Dry::Monads[:result, :do, :try]

            def call(payload)
              entity = yield generate_and_validate_request_payload(payload)
              xml_string = yield generate_xml(entity)
              validation_result = yield validate_xml(xml_string)
              Success(xml_string)
            end

            private

            def generate_and_validate_request_payload(payload)
              Try do
               AcaEntities::Fdsh::Pvc::Dmf::Request::IndividualRequests.new(payload)
              end.to_result
            end

            def generate_xml(entity)
              # Code to generate XML from xml_data
              serialized_obj = AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Request::IndividualRequests.domain_to_mapper(entity)
              generated_xml = serialized_obj.to_xml

              Success(generated_xml)
            end

            def validate_xml(xml_string)
              document = Nokogiri::XML(xml_string)
              xsd_path = File.open(Pathname.pwd.join("lib/aca_entities/fdsh/pvc/dmf/request/XMLschemas/constraint/XMLschemas/exchange/ExchangeModel.xsd"))
              schema_location = File.expand_path(xsd_path)
              schema = Nokogiri::XML::Schema(File.open(schema_location))
              result = schema.validate(document).each_with_object([]) do |error, collect|
                collect << error.message
              end

              if result.empty?
                Success(true)
              else
                Failure("validate_xml -> #{result}")
              end
            end
          end
        end
      end
    end
  end
end
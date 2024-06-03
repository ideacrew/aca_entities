# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'nokogiri'

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Operations
          # This class is responsible for generating and validating XML from a given payload.
          class GenerateAndValidateXml
            include Dry::Monads[:result, :do, :try]

            # Main method of the class. It generates and validates XML from a given payload.
            #
            # @param payload [Hash] The input data to generate XML.
            #
            # @return [Dry::Monads::Result] Returns a Success monad with the generated XML string if successful,
            #   otherwise returns a Failure monad with an error message.
            def call(payload)
              entity = yield build_request_payload_entity(payload)
              xml_string = yield generate_xml(entity)
              yield validate_xml(xml_string)
              Success(xml_string)
            end

            private

            # Builds and validates the request payload entity.
            #
            # @param payload [Hash] The input data to generate the request payload entity.
            #
            # @return [Dry::Monads::Result] Returns a Success monad with the entity if successful,
            #   otherwise returns a Failure monad with an error message.
            def build_request_payload_entity(payload)
              Try do
                AcaEntities::Fdsh::Pvc::Dmf::Request::IndividualRequests.new(payload)
              end.to_result
            end

            # Generates XML from the given entity.
            #
            # @param entity [Object] The entity to generate XML from.
            #
            # @return [Dry::Monads::Result] Returns a Success monad with the generated XML string if successful,
            #   otherwise returns a Failure monad with an error message.
            def generate_xml(entity)
              # Code to generate XML from xml_data
              Try do
                serialized_obj = AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Request::IndividualRequests.domain_to_mapper(entity)
                generated_xml = serialized_obj.to_xml
              end.to_result
            end

            # Validates the given XML string.
            #
            # @param xml_string [String] The XML string to validate.
            #
            # @return [Dry::Monads::Result] Returns a Success monad with true if the XML is valid,
            #   otherwise returns a Failure monad with an error message.
            def validate_xml(xml_string)
              document = Nokogiri::XML(xml_string)
              file_path = "lib/aca_entities/fdsh/pvc/dmf/request/XMLschemas/constraint/XMLschemas/exchange/ExchangeModel.xsd"
              xsd_path = File.open(Pathname.pwd.join(file_path))
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
# frozen_string_literal: true

# AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Operations::XMLValidator.new.call(xml_string, schema_file_path)

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Operations
              # PVC Request manifest to payload xml
              class XMLValidator
                send(:include, Dry::Monads[:result, :do, :try])

                def call(xml_string, schema_file_path)
                  xml_doc = yield parse_xml(xml_string)
                  schema = yield load_schema(schema_file_path)
                  validate_document(schema, xml_doc)
                end

                def parse_xml(xml)
                  parse_result = Try do
                    Nokogiri::XML(xml)
                  end

                  return Failure(:invalid_xml) if parse_result.success? && !parses_to_valid_document?(parse_result.value!)

                  parse_result.or do |e|
                    Failure(e)
                  end
                end

                def parses_to_valid_document?(parse_result_value)
                  return false if parse_result_value.nil?
                  return false unless parse_result_value.respond_to?(:root)
                  !parse_result_value.root.nil?
                end

                def load_schema(schema_file_path)
                  read_schema_result = Try do
                    schema_location = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "..", schema_file_path))
                    Nokogiri::XML::Schema(File.open(schema_location))
                  end

                  read_schema_result.or do |e|
                    Failure(e)
                  end
                end

                def validate_document(schema, xml_doc)
                  schema_validation = Try do
                    schema.validate(xml_doc)
                  end

                  capture_error = schema_validation.or do |e|
                    Failure(e)
                  end
                  capture_error.bind do |schema_results|
                    no_schema_errors?(schema_results) ? Success(:ok) : Failure(schema_results)
                  end
                end

                def no_schema_errors?(schema_results)
                  return true if schema_results.nil?
                  schema_results.empty?
                end
              end
            end
          end
        end
      end
    end
  end
end

# schema_file_path = "/fdsh/pvc/dmf/response/schemas/main/XMLschemas/constraint/XMLschemas/exchange/ExchangeModel.xsd"
# file_path = "/Users/vishal/Documents/Sprint 30 PVC_DMF XSDs 20140613/DMF/DMF Response/Samples/PVC_DMF_ResponseMax1.xml"
# AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Operations::ValidateXml.new.call(File.read(file_path), schema_file_path)
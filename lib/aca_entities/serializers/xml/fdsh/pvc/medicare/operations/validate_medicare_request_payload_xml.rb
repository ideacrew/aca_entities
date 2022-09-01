# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Medicare
            module Operations
              # Validate pvc medicare request with xsd
              class ValidateMedicareRequestPayloadXml
                send(:include, Dry::Monads[:result, :do, :try])

                SCHEMA_LOCATION = File.expand_path(
                  File.join(
                    File.dirname(__FILE__),
                    "..",
                    "..",
                    "..",
                    "..",
                    "..",
                    "..",
                    "fdsh",
                    "pvc",
                    "medicare",
                    "xsd",
                    "medicare_request.xsd"
                  )
                ).freeze

                def call(xml)
                  xml_doc = yield parse_xml(xml)
                  schema = yield load_schema
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

                def load_schema
                  read_schema_result = Try do
                    Nokogiri::XML::Schema(File.open(SCHEMA_LOCATION))
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
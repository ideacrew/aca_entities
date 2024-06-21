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
              class SanitizeXml
                send(:include, Dry::Monads[:result, :do, :try])

                def call(xml_string)
                  yield validate(xml_string)
                  remove_xml_node(xml_string)
                end

                private

                def validate(xml_string)
                  return Failure("Invalid XML file") unless xml_string.present?
                  Success(true)
                end

                def remove_xml_node(response_xml)
                  xml_doc = Nokogiri::XML(response_xml)
                  child_node = xml_doc.children.detect(&:element?)
                  Success(child_node.canonicalize)
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
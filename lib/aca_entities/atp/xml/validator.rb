# frozen_string_literal: true

require "nokogiri"

module AcaEntities
  module Atp
    module Xml
      # Validates ATP XML payloads using our schema.
      class Validator

        SCHEMA_LOCATION =
          File.expand_path(
            File.join(
              File.dirname(__FILE__),
              "./constraint/exchange/SBM.xsd"
            )
          ).freeze

        def initialize
          @schema = schema_instance
        end

        def validate(doc)
          @schema.validate(doc)
        end

        def valid?(doc)
          @schema.valid?(doc)
        end

        protected

        def schema_instance
          Nokogiri::XML::Schema(File.open(SCHEMA_LOCATION))
        end
      end
    end
  end
end

# frozen_string_literal: true

require "happymapper"
# response

require_relative 'response/checksum_augmentation'
require_relative 'response/document_binary'
require_relative 'response/response_metadata'
require_relative 'response/response_attachment'
require_relative 'response/service_specific_data'
require_relative 'response/transmission_metadata'
require_relative 'response/batch_metadata'
require_relative 'response/batch_handling_service_response'

require_relative 'checksum_augmentation'
require_relative 'document_binary'
require_relative 'request_attachment'
require_relative 'current_income_file_metadata'
require_relative 'medicare_file_metadata'
require_relative 'ssa_file_metadata'
require_relative 'irs_file_metadata'
require_relative 'service_specific_data'
require_relative 'transmission_metadata'
require_relative 'batch_metadata'
require_relative 'batch_handling_service_request'

# operations
require_relative 'operations/pvc_manifest_request_to_xml'
require_relative 'operations/validate_pvc_manifest_request_payload_xml'
require_relative 'operations/validate_pvc_manifest_response_payload_xml'

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for Pvc objects.
        module PvcManifest
        end
      end
    end
  end
end
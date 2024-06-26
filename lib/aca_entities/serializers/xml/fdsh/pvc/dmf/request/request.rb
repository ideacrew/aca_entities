# frozen_string_literal: true

require "happymapper"

require_relative 'person_birth_date'
require_relative 'person_name'
require_relative 'person_ssn_identification'
require_relative 'individual_request'
require_relative 'individual_requests'

# request
require_relative 'checksum_augmentation'
require_relative 'document_binary'
require_relative 'request_attachment'
require_relative 'dmf_file_metadata'
require_relative 'service_specific_data'
require_relative 'transmission_metadata'
require_relative 'batch_metadata'
require_relative 'batch_handling_service_request'

# operations
# require_relative 'operations/dmf_manifest_request_to_xml'
# require_relative 'operations/validate_dmf_manifest_request_payload_xml'

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            # XML serialization for Rrv Ifsv objects.
            module Request
            end
          end
        end
      end
    end
  end
end
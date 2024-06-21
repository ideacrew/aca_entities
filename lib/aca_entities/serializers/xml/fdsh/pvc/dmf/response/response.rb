# frozen_string_literal: true

require "happymapper"

# manifest
require_relative  'manifest/checksum_augmentation'
require_relative  'manifest/document_binary'
require_relative  'manifest/response_metadata'
require_relative  'manifest/response_attachment'
require_relative  'manifest/service_specific_data'
require_relative  'manifest/transmission_metadata'
require_relative  'manifest/batch_metadata'
require_relative  'manifest/batch_handling_service_response'

# record
require_relative 'record/ssa_verification_supplement'
require_relative 'record/person_death_date'
require_relative 'record/person_birth_date'
require_relative 'record/person_name'
require_relative 'record/person_ssn_identification'
require_relative 'record/person'
require_relative 'record/individual_response'
require_relative 'record/individual_responses'

# operations
# require_relative 'operations/validate_and_transform_response_xml'

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Response
            end
          end
        end
      end
    end
  end
end
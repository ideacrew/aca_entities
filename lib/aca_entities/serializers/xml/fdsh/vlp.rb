# frozen_string_literal: true

require "happymapper"

require_relative 'vlp/h92/passport_country'
require_relative 'vlp/h92/i327_document_id'
require_relative 'vlp/h92/i551_document_id'
require_relative 'vlp/h92/i571_document_id'
require_relative 'vlp/h92/i766_document_id'
require_relative 'vlp/h92/cert_of_cit_document_id'
require_relative 'vlp/h92/natr_of_cert_document_id'
require_relative 'vlp/h92/mac_read_i551_document_id'
require_relative 'vlp/h92/temp_i551_document_id'
require_relative 'vlp/h92/i94_document_id'
require_relative 'vlp/h92/i94_unexp_foreign_passport_document_id'
require_relative 'vlp/h92/unexp_foreign_passport_document_id'
require_relative 'vlp/h92/i20_document_id'
require_relative 'vlp/h92/ds2019_document_id'
require_relative 'vlp/h92/other_case1_document_id'
require_relative 'vlp/h92/other_case2_document_id'
require_relative 'vlp/h92/dhs_id'
require_relative 'vlp/h92/initial_verification_request_set'
require_relative 'vlp/h92/initial_verification_request'
require_relative 'vlp/h92/response_metadata'
require_relative 'vlp/h92/error_response_metadata'
require_relative 'vlp/h92/array_of_error_response_metadata'
require_relative 'vlp/h92/sponsorship_data'
require_relative 'vlp/h92/array_of_sponsorship_data'
require_relative 'vlp/h92/initial_verification_individual_response_set'
require_relative 'vlp/h92/initial_verification_individual_response'
require_relative 'vlp/h92/initial_verification_response_set'
require_relative 'vlp/h92/initial_verification_response'

# operations
require_relative "vlp/h92/operations/validate_vlp_h92_payload_xml"
require_relative "vlp/h92/operations/initial_request_to_xml"

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for Vlp objects.
        module Vlp
        end
      end
    end
  end
end
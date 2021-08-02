# frozen_string_literal: true

require "happymapper"

require_relative 'ssa/h3/person_name'
require_relative 'ssa/h3/person_birth_date'
require_relative 'ssa/h3/person'
require_relative 'ssa/h3/ssa_composite_individual_request'
require_relative 'ssa/h3/ssa_composite_request'

# operations
require_relative "vlp/h92/operations/validate_vlp_h92_payload_xml"
require_relative "vlp/h92/operations/initial_request_to_xml"

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for Ssa objects.
        module Ssa
        end
      end
    end
  end
end
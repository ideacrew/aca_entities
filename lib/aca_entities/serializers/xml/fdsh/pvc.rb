# frozen_string_literal: true

require "aca_entities/serializers/xml/fdsh/pvc/medicare/medicare"
require "aca_entities/serializers/xml/fdsh/pvc/h43/pvc_manifest"
require_relative 'pvc/dmf/request/person_birth_date'
require_relative 'pvc/dmf/request/person_name'
require_relative 'pvc/dmf/request/individual_request'
require_relative 'pvc/dmf/request/individual_requests'

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for Pvc objects.
        module Pvc
        end
      end
    end
  end
end
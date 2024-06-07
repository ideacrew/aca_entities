# frozen_string_literal: true

require "happymapper"

require_relative 'person_birth_date'
require_relative 'person_name'
require_relative 'person_ssn_identification'
require_relative 'individual_request'
require_relative 'individual_requests'

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
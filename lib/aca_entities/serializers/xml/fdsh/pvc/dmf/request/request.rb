# frozen_string_literal: true

require "happymapper"

require_relative 'individual_requests'
require_relative 'individual_request'
require_relative 'person_name'
require_relative 'person_birth_date'

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
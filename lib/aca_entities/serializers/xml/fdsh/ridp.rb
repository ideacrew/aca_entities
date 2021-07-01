# frozen_string_literal: true

require "happymapper"

require_relative "ridp/person_name"
require_relative "ridp/person"
require_relative "ridp/response_metadata"
require_relative "ridp/verification_question_set"
require_relative "ridp/verification_question"
require_relative "ridp/verification_answer"
require_relative "ridp/verification_answer_set"
require_relative "ridp/verification_response"
require_relative "ridp/contact_telephone_number"
require_relative "ridp/contact_information"
require_relative "ridp/location_street"
require_relative "ridp/structured_address"
require_relative "ridp/location_address"
require_relative "ridp/current_address"
require_relative "ridp/primary_request"
require_relative "ridp/primary_response"
require_relative "ridp/secondary_request"
require_relative "ridp/secondary_response"
require_relative "ridp/request"

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for Ridp objects.
        module Ridp
        end
      end
    end
  end
end
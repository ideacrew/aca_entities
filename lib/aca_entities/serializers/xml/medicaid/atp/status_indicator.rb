# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # True if the status holds; false otherwise.
          class StatusIndicator
            include HappyMapper

            tag 'StatusIndicator'
            namespace 'hix-core'

            def self.domain_to_mapper(_medicaid_eligibility)
              self.new
            end
          end
        end
      end
    end
  end
end
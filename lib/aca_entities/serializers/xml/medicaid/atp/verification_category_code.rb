# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A kind of verification status.
          class VerificationCategoryCode
            include HappyMapper

            tag 'VerificationCategoryCode'
            namespace 'hix-core'

            content :value, String

            def self.domain_to_mapper(status)
              mapper = self.new
              mapper.value = status
              mapper
            end
          end
        end
      end
    end
  end
end
# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A kind of verification status.
          class VerificationStatus
            include HappyMapper

            tag 'VerificationStatus'
            namespace 'hix-core'

            element :status_code, String, tag: 'VerificationStatusCode', namespace: "hix-core"

            def self.domain_to_mapper(status)
              mapper = self.new
              mapper.status_code = status.status_code
              mapper
            end

            def to_hash
              {
                status_code: status_code
              }
            end
          end
        end
      end
    end
  end
end
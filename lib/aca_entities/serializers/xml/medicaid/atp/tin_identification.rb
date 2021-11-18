# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An identification assigned by the Internal Revenue Service for tax purposes.
          class TinIdentification
            include HappyMapper

            tag 'TINIdentification'
            namespace 'hix-core'

            element :identification_id, String, tag: 'IdentificationID', namespace: 'nc'

            def self.domain_to_mapper(tin_id)
              mapper = self.new
              mapper.identification_id = tin_id&.identification_id
              mapper
            end

            def to_hash
              {
                identification_id: identification_id
              }
            end
          end
        end
      end
    end
  end
end
# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An identification for a member of a Medicaid program.
          class MedicaidIdentification
            include HappyMapper

            tag 'MedicaidIdentification'
            namespace 'hix-ee'

            element :identification_id, String, tag: 'IdentificationID', namespace: 'nc'

            def self.domain_to_mapper(chip_id)
              mapper = self.new
              mapper.identification_id = chip_id.identification_id
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
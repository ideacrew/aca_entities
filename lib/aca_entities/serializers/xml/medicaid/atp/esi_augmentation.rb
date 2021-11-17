# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Supplements An arrangement for an employer sponsored insurance.
          class EsiAugmentation
            include HappyMapper

            tag 'ESIAugmentation'
            namespace 'hix-ee'

            has_one :esi, Esi

            def self.domain_to_mapper(esi_augmentation)
              mapper = self.new
              mapper.esi = Esi.domain_to_mapper(esi_augmentation.esi) if esi_augmentation&.esi
              mapper
            end

            def to_hash
              {
                esi: esi&.to_hash
              }
            end
          end
        end
      end
    end
  end
end
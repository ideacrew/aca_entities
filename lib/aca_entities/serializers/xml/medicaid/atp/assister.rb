# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A certified assister (such as a navigator) who helps individuals complete an insurance application.
          class Assister
            include HappyMapper

            tag 'Assister'
            namespace 'hix-ee'

            has_one :role_played_by_person, RolePlayedByPerson

            def self.domain_to_mapper(_assister)
              self.new
            end

            def to_hash
              {
                role_played_by_person: role_played_by_person&.to_hash
              }
            end
          end
        end
      end
    end
  end
end
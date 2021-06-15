# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A certified assister (such as a navigator) who helps individuals complete an insurance application.
          class Assister
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'Assister'
            namespace 'hix-ee'

            has_one :role_played_by_person, RolePlayedByPerson

            def self.domain_to_mapper(_date_time)
              self.new
            end
          end
        end
      end
    end
  end
end
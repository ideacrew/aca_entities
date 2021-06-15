module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A human being.
          class RolePlayedByPerson
            include HappyMapper
          
            register_namespace 'xsi', "http://www.w3.org/2001/XMLSchema-instance"

            tag 'RolePlayedByPerson'
            namespace 'hix-core'

            #todo
            #Include Person
            
            def self.domain_to_mapper(_insurance_application)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end
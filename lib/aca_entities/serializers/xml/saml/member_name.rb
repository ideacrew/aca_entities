# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Saml
        class MemberName
          include HappyMapper

          tag 'MemberName'

          element :person_surname, String
          element :person_given_name, String
          element :person_full_name, String

          def self.domain_to_mapper(request)
            mapper = self.new
            mapper.person_surname = request.person_surname
            mapper.person_given_name = request.person_given_name
            mapper.person_full_name = request.person_full_name

            mapper
          end
        end
      end
    end
  end
end
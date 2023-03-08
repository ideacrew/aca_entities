# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module PayNow
        module CareFirst
          # Happymapper implementation for member_name
          class MemberName
            include HappyMapper

            tag "member_name"

            element :person_surname, String, tag: "person_surname"
            element :person_given_name, String, tag: "person_given_name"
            element :person_middle_name, String, tag: "person_middle_name"
            element :person_full_name, String, tag: "person_full_name"
            element :person_name_prefix_text, String, tag: "person_name_prefix_text"
            element :person_name_suffix_text, String, tag: "person_name_suffix_text"
            element :person_alternate_name, String, tag: "person_alternate_name"

            def self.domain_to_mapper(member_name)
              mapper = self.new
              mapper.person_surname = member_name.person_surname
              mapper.person_given_name = member_name.person_given_name
              mapper.person_middle_name = member_name.person_middle_name
              mapper.person_full_name = member_name.person_full_name
              mapper.person_name_prefix_text = member_name.person_name_prefix_text
              mapper.person_name_suffix_text = member_name.person_name_suffix_text
              mapper.person_alternate_name = member_name.person_alternate_name
              mapper
            end
          end
        end
      end
    end
  end
end

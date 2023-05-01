# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      # entity for MemberName
      class MemberName < Dry::Struct
        attribute :person_surname, Types::String.meta(omittable: false)
        attribute :person_given_name, Types::String.meta(omittable: false)
        attribute :person_middle_name, Types::String.optional.meta(omittable: true)
        attribute :person_full_name, Types::String.optional.meta(omittable: true)
        attribute :person_name_prefix_text, Types::String.optional.meta(omittable: true)
        attribute :person_name_suffix_text, Types::String.optional.meta(omittable: true)
        attribute :person_alternate_name, Types::String.optional.meta(omittable: true)
      end
    end
  end
end

# frozen_string_literal: true

module AcaEntities
  module People
    # An individual's name
    class PersonName < Dry::Struct
      include Comparable

      attribute :first_name, Types::String.meta(omittable: false)
      attribute? :middle_name, Types::String.optional.meta(omittable: true)
      attribute :last_name, Types::String.meta(omittable: false)
      attribute? :name_sfx, Types::String.optional.meta(omittable: true)
      attribute? :name_pfx, Types::String.optional.meta(omittable: true)
      attribute? :full_name, Types::String.optional.meta(omittable: true)
      attribute? :alternate_name, Types::String.optional.meta(omittable: true)

      def <=>(other)
        [last_name, first_name] <=> [other.last_name, other.first_name]
      end

      def full_name
        @full_name || [name_pfx, first_name, middle_name, last_name, name_sfx].compact.join(' ')
      end
    end
  end
end

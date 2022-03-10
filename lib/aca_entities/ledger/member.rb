# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Schema and validation rules for {AcaEntities::Ledger::Member}
    class Member < Dry::Struct
      include Comparable

      attribute? :id, Types::Coercible::String.meta(omittable: true)
      attribute :hbx_id, Types::Coercible::String.meta(omittable: false)
      attribute? :insurer_assigned_id, Types::Coercible::String.meta(omittable: true)
      attribute :subscriber_hbx_id, Types::Coercible::String.meta(omittable: false)
      attribute? :insurer_assigned_subscriber_id, Types::Coercible::String.meta(omittable: true)
      attribute :person_name, AcaEntities::People::PersonName.meta(omittable: false)
      attribute? :ssn, Types::Coercible::String.meta(omittable: true)
      attribute? :dob, Types::Date.meta(omittable: true)
      attribute? :gender, AcaEntities::Types::BinaryGenderKind.meta(omittable: true)
      attribute? :tax_household_id, Types::Integer.meta(omittable: true)
      attribute? :relationship_code, Types::Coercible::String.meta(omittable: true)
      attribute? :is_subscriber, Types::Bool.meta(omittable: true)
      attribute? :is_tobacco_user, Types::Bool.meta(omittable: true)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)

      def <=>(other)
        member_comp =
          [hbx_id, ssn, dob, gender, tax_household_id, is_tobacco_user] <=> [
            other.hbx_id,
            other.ssn,
            other.dob,
            other.gender,
            other.tax_household_id,
            other.is_tobacco_user
          ]

        return person_name <=> other.person_name if member_comp == 0
      end
    end
  end
end

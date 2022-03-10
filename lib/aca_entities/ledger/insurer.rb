# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Schema and validation rules for {AcaEntities::Ledger::Insurer}
    class Insurer < Dry::Struct
      include Comparable

      attribute? :id, Types::Coercible::String.meta(omittable: true)
      attribute :hios_id, Types::Coercible::String.meta(omittable: false)
      attribute? :name, Types::Coercible::String.meta(omittable: true)
      attribute? :description, Types::Coercible::String.meta(omittable: true)
      attribute? :user_fee_reports, Types::Array.of(AcaEntities::Ledger::UserFeeReport)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)

      def <=>(other)
        hios_id <=> other.hios_id
      end
    end
  end
end

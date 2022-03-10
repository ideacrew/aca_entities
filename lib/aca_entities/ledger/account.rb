# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Financial account
    class Account < Dry::Struct
      attribute? :id, Types::Coercible::String.meta(omittable: true)
      attribute :number, Types::Integer.meta(omittable: false)
      attribute :name, Types::Coercible::String.meta(omittable: false)
      attribute :kind, AcaEntities::Ledger::Types::KeeprAccountKind.meta(omittable: false)
      attribute? :parent, Types::Coercible::String.meta(omittable: true)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)
    end
  end
end

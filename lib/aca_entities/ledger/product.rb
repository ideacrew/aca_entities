# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Health or dental insurace plan
    class Product < Dry::Struct
      include Comparable

      # @!attribute [r] id
      # A unique identifier -- typically system-assigned -- for a
      #   Product instance
      # @return [String]
      attribute? :id, Types::String.optional.meta(ommittable: true)

      # @!attribute [r] hbx_qhp_id
      # A unique identifier key assigned to this Product by the State-based
      #   marketplace
      # @return [String]
      attribute :hbx_qhp_id, Types::Coercible::String.meta(omittable: false)

      # @!attribute [r] hbx_qhp_id
      # The calendar year of coveraged provided by this Product
      # @return [String]
      attribute :effective_year, Types::Integer.meta(omittable: false)
      attribute? :name, Types::Coercible::String.meta(omittable: true)
      attribute? :description, Types::Coercible::String.meta(omittable: true)
      attribute :kind, Types::Coercible::String.meta(omittable: false)
      attribute? :income_account, AcaEntities::Ledger::Account.meta(omittable: true)
      attribute? :expense_account, AcaEntities::Ledger::Account.meta(omittable: true)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)

      def <=>(other)
        [hbx_qhp_id, effective_year, kind] <=> [other.hbx_qhp_id, other.effective_year, other.kind]
      end
    end
  end
end

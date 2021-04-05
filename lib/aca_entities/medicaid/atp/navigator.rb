# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp navigator
      class Navigator < Dry::Struct
        attribute :first_name,        Types::String.optional.meta(omittable: true)
        attribute :middle_name,       Types::String.optional.meta(omittable: true)
        attribute :last_name,         Types::String
        attribute :name_sfx,          Types::String.optional.meta(omittable: true)

        attribute :organization_name, Types::String.optional.meta(omittable: true)
        attribute :organization_id,   Types::String.optional.meta(omittable: true)
        attribute :broker_user_id,    Types::String.optional.meta(omittable: true)
        attribute :broker_npn,        Types::String.optional.meta(omittable: true)
        attribute :designation_date,  Types::Date
      end
    end
  end
end

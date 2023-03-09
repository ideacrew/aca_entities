# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      # entity for Primary
      class Primary < Dry::Struct
        attribute :exchange_assigned_member_id, Types::String.meta(omittable: false)
        attribute :member_name, AcaEntities::PayNow::CareFirst::MemberName.meta(omittable: false)
      end
    end
  end
end

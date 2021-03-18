# frozen_string_literal: true

module Ehs
  module ProductDeliveryCases
    class ProductDeliveryCase < Dry::Struct

      attribute :ids,                Types::Array.of(Identifiers::Id).meta(omittable: false)
      attribute :name,               Ehs::Types::ProductNameKind.meta(omittable: true)
      attribute :type,               Ehs::Types::ProductTypeKind.meta(omittable: true)
      attribute :participant_roles,  Types::Array.of(Ehs::ParticipantRoles::ParticipantRole).optional.meta(omittable: true)
    end
  end
end

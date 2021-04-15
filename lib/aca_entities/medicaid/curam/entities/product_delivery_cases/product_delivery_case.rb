# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ProductDeliveryCases
        # ProductDeliveryCase entity
        class ProductDeliveryCase < Dry::Struct

          attribute :ids,                Types::Array.of(Identifiers::Id).meta(omittable: false)
          attribute :name,               Curam::TypesProductNameKind.meta(omittable: true)
          attribute :type,               Curam::TypesProductTypeKind.meta(omittable: true)
          attribute :participant_roles,  Types::Array.of(Curam::ParticipantRoles::ParticipantRole).optional.meta(omittable: true)
        end
      end
    end
  end
end

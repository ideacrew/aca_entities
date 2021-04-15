# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      # entity for curam phone record
      module Phones
        class Phone < Dry::Struct

          attribute :type,              Types::PhoneKind.meta(omittable: false)
          attribute :area_code,         Types::String.optional.meta(omittable: true)
          attribute :phone_number,      Types::String.meta(omittable: false)
          attribute :full_phone_number, Types::String.optional.meta(omittable: true)
          attribute :is_preferred,      Types::Bool.meta(omittable: false)
        end
      end
    end
  end
end

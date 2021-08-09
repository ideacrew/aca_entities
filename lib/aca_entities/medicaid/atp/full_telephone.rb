# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp FullTelephone
      class FullTelephone < Dry::Struct

        attribute :telephone_number_full_id, Types::String.optional.meta(omittable: true)
        attribute :telephone_suffix_id,      Types::String.optional.meta(omittable: true)
      end
    end
  end
end
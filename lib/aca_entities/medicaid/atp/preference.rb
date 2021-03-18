# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Preference
      class Preference < Dry::Struct

        attribute :spoken_language, Types::String.optional
        attribute :written_language, Types::String.optional.meta(omittable: true)
        attribute :notification_email_address, Types::String.optional.meta(omittable: true)
        attribute :contact_preference_Code, Types::String
      end
    end
  end
end

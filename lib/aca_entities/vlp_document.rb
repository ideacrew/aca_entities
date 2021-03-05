# frozen_string_literal: true

module AcaEntities
  # Entity for VLPDocument
  class VlpDocument < Dry::Struct
    attribute :subject,             Iap::Types::VlpDocumentKind.optional.meta(omittable: true)
    attribute :alien_number, Types::String.optional.meta(omittable: true)
    attribute :i94_number, Types::String.optional.meta(omittable: true)
    attribute :visa_number, Types::String.optional.meta(omittable: true)
    attribute :passport_number, Types::String.optional.meta(omittable: true)
    attribute :sevis_id, Types::String.optional.meta(omittable: true)
    attribute :naturalization_number, Types::String.optional.meta(omittable: true)
    attribute :receipt_number, Types::String.optional.meta(omittable: true)
    attribute :citizenship_number, Types::String.optional.meta(omittable: true)
    attribute :card_number, Types::String.optional.meta(omittable: true)
    attribute :country_of_citizenship, Types::String.optional.meta(omittable: true)
    attribute :expiration_date, Types::Date.optional.meta(omittable: true)
    attribute :issuing_country, Types::String.optional.meta(omittable: true)

    attribute :description, Types::String.optional.meta(omittable: true)

    # The name of country issuing the foreign passport.
    # Three uppercase letter country code (ISO 3166-1).
    def three_letter_country_of_citizenship
      # TODO: method should return 3 letter country code.
      # Gem Ref: https://github.com/alexrabarts/iso_country_codes
    end
  end
end

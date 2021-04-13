# frozen_string_literal: true

module AcaEntities
  module Documents
    # Entity for VLPDocument
    class VlpDocument < AcaEntities::Documents::Document
      # attribute :identification_number,   Types::String.optional.meta(omittable: false)

      attribute :subject,      Iap::Types::VlpDocumentKind.optional.meta(omittable: false)
      attribute :alien_number, Types::String.optional.meta(omittable: false)
      attribute :i94_number, Types::String.optional.meta(omittable: false)
      attribute :visa_number, Types::String.optional.meta(omittable: false)
      attribute :passport_number, Types::String.optional.meta(omittable: false)
      attribute :sevis_id, Types::String.optional.meta(omittable: false)
      attribute :naturalization_number, Types::String.optional.meta(omittable: false)
      attribute :receipt_number, Types::String.optional.meta(omittable: false)
      attribute :citizenship_number, Types::String.optional.meta(omittable: false)
      attribute :card_number, Types::String.optional.meta(omittable: false)
      attribute :country_of_citizenship, Types::String.optional.meta(omittable: false)
      attribute :expiration_date, Types::Date.optional.meta(omittable: false)
      attribute :issuing_country, Types::String.optional.meta(omittable: false)

      attribute :description, Types::String.optional.meta(omittable: false)

      # The name of country issuing the foreign passport.
      # Three uppercase letter country code (ISO 3166-1).
      def three_letter_country_of_citizenship
        # TODO: method should return 3 letter country code.
        # Gem Ref: https://github.com/alexrabarts/iso_country_codes
      end
    end
  end
end
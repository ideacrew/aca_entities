# frozen_string_literal: true

require 'iso_country_codes'

module AcaEntities
  module Documents
    # Entity for VLPDocument
    class VlpDocument < AcaEntities::Documents::Document
      # attribute :identification_number,   Types::String.optional.meta(omittable: false)

      attribute :subject,      Types::VlpDocumentKind.meta(omittable: false)
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
      attribute :expiration_date, Types::DateTime.optional.meta(omittable: true)
      attribute :issuing_country, Types::String.optional.meta(omittable: true)

      def three_letter_country_of_citizenship
        return nil if country_of_citizenship.empty?

        IsoCountryCodes.search_by_name(country_of_citizenship).first.alpha3
      end
    end
  end
end
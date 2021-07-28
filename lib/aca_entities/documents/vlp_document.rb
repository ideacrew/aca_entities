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
        modified_countries = ["Vatican City", "Laos", "East Timor (Timor Timur)", "Czech Republic", "Cote d'Ivoire", "Korea, North", "Korea, South"]
        country = if modified_countries.include?(country_of_citizenship)
          map_countries_to_iso[country_of_citizenship]
        else
          country_of_citizenship
        end
        IsoCountryCodes.search_by_name(country).first.alpha3
      end

      def map_countries_to_iso
        {
          "Vatican City" => "Holy See",
          "Laos" => "Lao People's Democratic Republic",
          "East Timor (Timor Timur)" => "Timor-Leste",
          "Czech Republic" => "Czechia",
          "Cote d'Ivoire" => "Côte d'Ivoire",
          "Korea, North" => "Korea (Democratic People's Republic of)",
          "Korea, South" => "Korea (Republic of)"
        }
      end
    end
  end
end